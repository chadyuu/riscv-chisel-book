package fpga

import chisel3._
import chisel3.util._
import common.Instructions._
import common.Consts._

class LongCounter(unitWidth: Int, unitCount: Int) extends Module {
  val counterWidth = unitWidth * unitCount
  val io = IO(new Bundle {
    val value = Output(UInt(counterWidth.W))
  })

  // val counters = RegInit(VecInit((0 to unitCount - 1).map(_ => 0.U(unitWidth.W))))
  // val carries = RegInit(VecInit((0 to unitCount - 1).map(_ => false.B)))
  // for(i <- 0 to unitCount - 1) {
  //   carries(i) := counters(i)(unitWidth - 1, 1).andR() && !counters(i)(0) // overflows at the next cycle or not.
  //   if( i == 0 ) {
  //     counters(i) := counters(i) + 1.U
  //   } else {
  //     counters(i) := counters(i) + carries(i - 1).asUInt
  //   }
  // }
  // io.value := Cat(counters.reverse)
  val counter = RegInit(0.U(counterWidth.W))
  counter := counter + 1.U
  io.value := counter
}

class CoreDebugSignals extends Bundle {
  val mem_reg_pc = Output(UInt(WORD_LEN.W))
  val csr_rdata = Output(UInt(WORD_LEN.W))
  val mem_reg_csr_addr = Output(UInt(WORD_LEN.W))
  val cycle_counter = Output(UInt(64.W))
}

class Core(startAddress: BigInt = 0) extends Module {
  val io = IO(
    new Bundle {
      val imem = Flipped(new ImemPortIo())
      val dmem = Flipped(new DmemPortIo())
      val gp   = Output(UInt(WORD_LEN.W))
      val exit = Output(Bool())
      val debug_signal = new CoreDebugSignals()
    }
  )

  val regfile = Mem(32, UInt(WORD_LEN.W))
  //val csr_regfile = Mem(4096, UInt(WORD_LEN.W)) 
  val csr_trap_vector = RegInit(0.U(WORD_LEN.W))
  val cycle_counter = Module(new LongCounter(8, 8)) // 64-bit cycle counter for CYCLE[H] CSR

  //**********************************
  // Pipeline State Registers

  // IF/ID State
  val id_reg_pc             = RegInit(0.U(WORD_LEN.W))
  val id_reg_inst           = RegInit(0.U(WORD_LEN.W))

  // ID/EX State
  val exe_reg_pc            = RegInit(0.U(WORD_LEN.W))
  val exe_reg_wb_addr       = RegInit(0.U(ADDR_LEN.W))
  val exe_reg_op1_data      = RegInit(0.U(WORD_LEN.W))
  val exe_reg_op2_data      = RegInit(0.U(WORD_LEN.W))
  val exe_reg_rs2_data      = RegInit(0.U(WORD_LEN.W))
  val exe_reg_exe_fun       = RegInit(0.U(EXE_FUN_LEN.W))
  val exe_reg_mem_wen       = RegInit(0.U(MEN_LEN.W))
  val exe_reg_rf_wen        = RegInit(0.U(REN_LEN.W))
  val exe_reg_wb_sel        = RegInit(0.U(WB_SEL_LEN.W))
  val exe_reg_csr_addr      = RegInit(0.U(CSR_ADDR_LEN.W))
  val exe_reg_csr_cmd       = RegInit(0.U(CSR_LEN.W))
  val exe_reg_imm_i_sext    = RegInit(0.U(WORD_LEN.W))
  val exe_reg_imm_s_sext    = RegInit(0.U(WORD_LEN.W))
  val exe_reg_imm_b_sext    = RegInit(0.U(WORD_LEN.W))
  val exe_reg_imm_u_shifted = RegInit(0.U(WORD_LEN.W))
  val exe_reg_imm_z_uext    = RegInit(0.U(WORD_LEN.W))
  val exe_reg_mem_w         = RegInit(0.U(WORD_LEN.W))
  val exe_is_ecall          = RegInit(false.B)

  // EX/MEM State
  val mem_reg_pc            = RegInit(0.U(WORD_LEN.W))
  val mem_reg_wb_addr       = RegInit(0.U(ADDR_LEN.W))
  val mem_reg_op1_data      = RegInit(0.U(WORD_LEN.W))
  val mem_reg_rs2_data      = RegInit(0.U(WORD_LEN.W))
  val mem_reg_mem_wen       = RegInit(0.U(MEN_LEN.W))
  val mem_reg_rf_wen        = RegInit(0.U(REN_LEN.W))
  val mem_reg_wb_sel        = RegInit(0.U(WB_SEL_LEN.W))
  val mem_reg_csr_addr      = RegInit(0.U(CSR_ADDR_LEN.W))
  val mem_reg_csr_cmd       = RegInit(0.U(CSR_LEN.W))
  val mem_reg_imm_z_uext    = RegInit(0.U(WORD_LEN.W))
  val mem_reg_alu_out       = RegInit(0.U(WORD_LEN.W))
  val mem_reg_mem_w         = RegInit(0.U(WORD_LEN.W))
  val mem_reg_mem_wstrb     = RegInit(0.U((WORD_LEN/8).W))
  // MEM/WB State
  val wb_reg_wb_addr        = RegInit(0.U(ADDR_LEN.W))
  val wb_reg_rf_wen         = RegInit(0.U(REN_LEN.W))
  val wb_reg_wb_data        = RegInit(0.U(WORD_LEN.W))


  //**********************************
  // Instruction Fetch (IF) Stage

  val if_reg_pc = RegInit(startAddress.U(WORD_LEN.W))
  io.imem.addr := if_reg_pc
  val if_inst = Mux(io.imem.valid, io.imem.inst, BUBBLE)
  printf(p"addr: ${Hexadecimal(io.imem.addr)}, valid: ${io.imem.valid}\n")
  val stall_flg     = Wire(Bool())
  val mem_stall_flg = Wire(Bool())
  val exe_br_flg    = Wire(Bool())
  val exe_br_target = Wire(UInt(WORD_LEN.W))
  val exe_jmp_flg   = Wire(Bool())
  val exe_alu_out   = Wire(UInt(WORD_LEN.W))

  val if_pc_plus4 = if_reg_pc + 4.U(WORD_LEN.W)
  val if_pc_next = MuxCase(if_pc_plus4, Seq(
	  // 優先順位重要！ジャンプ成立とストールが同時発生した場合、ジャンプ処理を優先
    exe_br_flg         -> exe_br_target,
    exe_jmp_flg         -> exe_alu_out,
    (if_inst === ECALL) -> csr_trap_vector, // go to trap_vector
    (stall_flg || !io.imem.valid)  -> if_reg_pc, // stall
  ))
  if_reg_pc := if_pc_next


  //**********************************
  // IF/ID Register
  id_reg_pc   := Mux(stall_flg, id_reg_pc, if_reg_pc)
  id_reg_inst := MuxCase(if_inst, Seq(
	  // 優先順位重要！ジャンプ成立とストールが同時発生した場合、ジャンプ処理を優先
    (exe_br_flg || exe_jmp_flg) -> BUBBLE,
    stall_flg -> id_reg_inst, 
  ))


  //**********************************
  // Instruction Decode (ID) Stage

  // stall_flg検出用にアドレスのみ一旦デコード
  val id_rs1_addr_b = id_reg_inst(19, 15)
  val id_rs2_addr_b = id_reg_inst(24, 20)

  // EXとのデータハザード→stall
  val id_rs1_data_hazard = (exe_reg_rf_wen === REN_S) && (id_rs1_addr_b =/= 0.U) && (id_rs1_addr_b === exe_reg_wb_addr)
  val id_rs2_data_hazard = (exe_reg_rf_wen === REN_S) && (id_rs2_addr_b =/= 0.U) && (id_rs2_addr_b === exe_reg_wb_addr)
  stall_flg := id_rs1_data_hazard || id_rs2_data_hazard || mem_stall_flg

  // branch,jump,stall時にIDをBUBBLE化
  val id_inst = Mux((exe_br_flg || exe_jmp_flg || stall_flg), BUBBLE, id_reg_inst)  

  val id_rs1_addr = id_inst(19, 15)
  val id_rs2_addr = id_inst(24, 20)
  val id_wb_addr  = id_inst(11, 7)

  val mem_wb_data = Wire(UInt(WORD_LEN.W))
  val id_rs1_data = MuxCase(regfile(id_rs1_addr), Seq(
    (id_rs1_addr === 0.U) -> 0.U(WORD_LEN.W),
    ((id_rs1_addr === mem_reg_wb_addr) && (mem_reg_rf_wen === REN_S)) -> mem_wb_data,   // MEMからフォワーディング
    ((id_rs1_addr === wb_reg_wb_addr ) && (wb_reg_rf_wen  === REN_S)) -> wb_reg_wb_data // WBからフォワーディング
  ))
  val id_rs2_data = MuxCase(regfile(id_rs2_addr),  Seq(
    (id_rs2_addr === 0.U) -> 0.U(WORD_LEN.W),
    ((id_rs2_addr === mem_reg_wb_addr) && (mem_reg_rf_wen === REN_S)) -> mem_wb_data,   // MEMからフォワーディング
    ((id_rs2_addr === wb_reg_wb_addr ) && (wb_reg_rf_wen  === REN_S)) -> wb_reg_wb_data // WBからフォワーディング
  ))

  val id_imm_i = id_inst(31, 20)
  val id_imm_i_sext = Cat(Fill(20, id_imm_i(11)), id_imm_i)
  val id_imm_s = Cat(id_inst(31, 25), id_inst(11, 7))
  val id_imm_s_sext = Cat(Fill(20, id_imm_s(11)), id_imm_s)
  val id_imm_b = Cat(id_inst(31), id_inst(7), id_inst(30, 25), id_inst(11, 8))
  val id_imm_b_sext = Cat(Fill(19, id_imm_b(11)), id_imm_b, 0.U(1.U))
  val id_imm_j = Cat(id_inst(31), id_inst(19, 12), id_inst(20), id_inst(30, 21))
  val id_imm_j_sext = Cat(Fill(11, id_imm_j(19)), id_imm_j, 0.U(1.U))
  val id_imm_u = id_inst(31,12)
  val id_imm_u_shifted = Cat(id_imm_u, Fill(12, 0.U))
  val id_imm_z = id_inst(19,15)
  val id_imm_z_uext = Cat(Fill(27, 0.U), id_imm_z)
  
  val csignals = ListLookup(id_inst,
               List(ALU_X    , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X, MW_X),
    Array(
      LB    -> List(ALU_ADD  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_MEM, CSR_X, MW_B),
      LBU   -> List(ALU_ADD  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_MEM, CSR_X, MW_BU),
      SB    -> List(ALU_ADD  , OP1_RS1, OP2_IMS, MEN_S, REN_X, WB_X  , CSR_X, MW_B),
      LH    -> List(ALU_ADD  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_MEM, CSR_X, MW_H),
      LHU   -> List(ALU_ADD  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_MEM, CSR_X, MW_HU),
      SH    -> List(ALU_ADD  , OP1_RS1, OP2_IMS, MEN_S, REN_X, WB_X  , CSR_X, MW_H),
      LW    -> List(ALU_ADD  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_MEM, CSR_X, MW_W),
      SW    -> List(ALU_ADD  , OP1_RS1, OP2_IMS, MEN_S, REN_X, WB_X  , CSR_X, MW_W),
      ADD   -> List(ALU_ADD  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      ADDI  -> List(ALU_ADD  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SUB   -> List(ALU_SUB  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      AND   -> List(ALU_AND  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      OR    -> List(ALU_OR   , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      XOR   -> List(ALU_XOR  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      ANDI  -> List(ALU_AND  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      ORI   -> List(ALU_OR   , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      XORI  -> List(ALU_XOR  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SLL   -> List(ALU_SLL  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SRL   -> List(ALU_SRL  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SRA   -> List(ALU_SRA  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SLLI  -> List(ALU_SLL  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SRLI  -> List(ALU_SRL  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SRAI  -> List(ALU_SRA  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SLT   -> List(ALU_SLT  , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SLTU  -> List(ALU_SLTU , OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SLTI  -> List(ALU_SLT  , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      SLTIU -> List(ALU_SLTU , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      BEQ   -> List(BR_BEQ   , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X, MW_X),
      BNE   -> List(BR_BNE   , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X, MW_X),
      BGE   -> List(BR_BGE   , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X, MW_X),
      BGEU  -> List(BR_BGEU  , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X, MW_X),
      BLT   -> List(BR_BLT   , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X, MW_X),
      BLTU  -> List(BR_BLTU  , OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X  , CSR_X, MW_X),
      JAL   -> List(ALU_ADD  , OP1_PC , OP2_IMJ, MEN_X, REN_S, WB_PC , CSR_X, MW_X),
      JALR  -> List(ALU_JALR , OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_PC , CSR_X, MW_X),
      LUI   -> List(ALU_ADD  , OP1_X  , OP2_IMU, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      AUIPC -> List(ALU_ADD  , OP1_PC , OP2_IMU, MEN_X, REN_S, WB_ALU, CSR_X, MW_X),
      CSRRW -> List(ALU_COPY1, OP1_RS1, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_W, MW_X),
      CSRRWI-> List(ALU_COPY1, OP1_IMZ, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_W, MW_X),
      CSRRS -> List(ALU_COPY1, OP1_RS1, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_S, MW_X),
      CSRRSI-> List(ALU_COPY1, OP1_IMZ, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_S, MW_X),
      CSRRC -> List(ALU_COPY1, OP1_RS1, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_C, MW_X),
      CSRRCI-> List(ALU_COPY1, OP1_IMZ, OP2_X  , MEN_X, REN_S, WB_CSR, CSR_C, MW_X),
      ECALL -> List(ALU_X    , OP1_X  , OP2_X  , MEN_X, REN_X, WB_X  , CSR_E, MW_X)
		)
	)
  val id_exe_fun :: id_op1_sel :: id_op2_sel :: id_mem_wen :: id_rf_wen :: id_wb_sel :: id_csr_cmd :: id_mem_w :: Nil = csignals

  val id_op1_data = MuxCase(0.U(WORD_LEN.W), Seq(
    (id_op1_sel === OP1_RS1) -> id_rs1_data,
    (id_op1_sel === OP1_PC)  -> id_reg_pc,
    (id_op1_sel === OP1_IMZ) -> id_imm_z_uext
  ))
  val id_op2_data = MuxCase(0.U(WORD_LEN.W), Seq(
    (id_op2_sel === OP2_RS2) -> id_rs2_data,
    (id_op2_sel === OP2_IMI) -> id_imm_i_sext,
    (id_op2_sel === OP2_IMS) -> id_imm_s_sext,
    (id_op2_sel === OP2_IMJ) -> id_imm_j_sext,
    (id_op2_sel === OP2_IMU) -> id_imm_u_shifted
  ))

  val id_csr_addr = Mux(id_csr_cmd === CSR_E, 0x342.U(CSR_ADDR_LEN.W), id_inst(31,20))


  //**********************************
  // ID/EX register
  when( !mem_stall_flg ) {
    exe_reg_pc            := id_reg_pc
    exe_reg_op1_data      := id_op1_data
    exe_reg_op2_data      := id_op2_data
    exe_reg_rs2_data      := id_rs2_data
    exe_reg_wb_addr       := id_wb_addr
    exe_reg_rf_wen        := id_rf_wen
    exe_reg_exe_fun       := id_exe_fun
    exe_reg_wb_sel        := id_wb_sel
    exe_reg_imm_i_sext    := id_imm_i_sext
    exe_reg_imm_s_sext    := id_imm_s_sext
    exe_reg_imm_b_sext    := id_imm_b_sext
    exe_reg_imm_u_shifted := id_imm_u_shifted
    exe_reg_imm_z_uext    := id_imm_z_uext
    exe_reg_csr_addr      := id_csr_addr
    exe_reg_csr_cmd       := id_csr_cmd
    exe_reg_mem_wen       := id_mem_wen
    exe_reg_mem_w         := id_mem_w
    exe_is_ecall          := id_inst === ECALL
  }
  //**********************************
  // Execute (EX) Stage

  exe_alu_out := MuxCase(0.U(WORD_LEN.W), Seq(
    (exe_reg_exe_fun === ALU_ADD)   -> (exe_reg_op1_data + exe_reg_op2_data),
    (exe_reg_exe_fun === ALU_SUB)   -> (exe_reg_op1_data - exe_reg_op2_data),
    (exe_reg_exe_fun === ALU_AND)   -> (exe_reg_op1_data & exe_reg_op2_data),
    (exe_reg_exe_fun === ALU_OR)    -> (exe_reg_op1_data | exe_reg_op2_data),
    (exe_reg_exe_fun === ALU_XOR)   -> (exe_reg_op1_data ^ exe_reg_op2_data),
    (exe_reg_exe_fun === ALU_SLL)   -> (exe_reg_op1_data << exe_reg_op2_data(4, 0))(31, 0),
    (exe_reg_exe_fun === ALU_SRL)   -> (exe_reg_op1_data >> exe_reg_op2_data(4, 0)).asUInt(),
    (exe_reg_exe_fun === ALU_SRA)   -> (exe_reg_op1_data.asSInt() >> exe_reg_op2_data(4, 0)).asUInt(),
    (exe_reg_exe_fun === ALU_SLT)   -> (exe_reg_op1_data.asSInt() < exe_reg_op2_data.asSInt()).asUInt(),
    (exe_reg_exe_fun === ALU_SLTU)  -> (exe_reg_op1_data < exe_reg_op2_data).asUInt(),
    (exe_reg_exe_fun === ALU_JALR)  -> ((exe_reg_op1_data + exe_reg_op2_data) & ~1.U(WORD_LEN.W)),
    (exe_reg_exe_fun === ALU_COPY1) -> exe_reg_op1_data
  ))

  // branch
  exe_br_flg := MuxCase(false.B, Seq(
    (exe_reg_exe_fun === BR_BEQ)  ->  (exe_reg_op1_data === exe_reg_op2_data),
    (exe_reg_exe_fun === BR_BNE)  -> !(exe_reg_op1_data === exe_reg_op2_data),
    (exe_reg_exe_fun === BR_BLT)  ->  (exe_reg_op1_data.asSInt() < exe_reg_op2_data.asSInt()),
    (exe_reg_exe_fun === BR_BGE)  -> !(exe_reg_op1_data.asSInt() < exe_reg_op2_data.asSInt()),
    (exe_reg_exe_fun === BR_BLTU) ->  (exe_reg_op1_data < exe_reg_op2_data),
    (exe_reg_exe_fun === BR_BGEU) -> !(exe_reg_op1_data < exe_reg_op2_data)
  ))
  exe_br_target := exe_reg_pc + exe_reg_imm_b_sext

  exe_jmp_flg := (exe_reg_wb_sel === WB_PC)


  //**********************************
  // EX/MEM register
  when( !mem_stall_flg ) {  // MEMステージがストールしていない場合のみMEMのパイプラインレジスタを更新する。
    mem_reg_pc         := exe_reg_pc
    mem_reg_op1_data   := exe_reg_op1_data
    mem_reg_rs2_data   := exe_reg_rs2_data
    mem_reg_wb_addr    := exe_reg_wb_addr
    mem_reg_alu_out    := exe_alu_out
    mem_reg_rf_wen     := exe_reg_rf_wen
    mem_reg_wb_sel     := exe_reg_wb_sel
    mem_reg_csr_addr   := exe_reg_csr_addr
    mem_reg_csr_cmd    := exe_reg_csr_cmd
    mem_reg_imm_z_uext := exe_reg_imm_z_uext
    mem_reg_mem_wen    := exe_reg_mem_wen
    mem_reg_mem_w      := exe_reg_mem_w
    mem_reg_mem_wstrb  := (MuxCase("b1111".U, Seq(
      (exe_reg_mem_w === MW_B) -> "b0001".U,
      (exe_reg_mem_w === MW_H) -> "b0011".U,
      (exe_reg_mem_w === MW_W) -> "b1111".U,
    )) << (exe_alu_out(1, 0)))(3, 0)
  }
  //**********************************
  // Memory Access Stage

  io.dmem.raddr := mem_reg_alu_out
  io.dmem.waddr := mem_reg_alu_out
  io.dmem.ren   := mem_reg_wb_sel === WB_MEM
  io.dmem.wen   := mem_reg_mem_wen
  io.dmem.wstrb := mem_reg_mem_wstrb
  io.dmem.wdata := (mem_reg_rs2_data << (8.U * mem_reg_alu_out(1, 0)))(WORD_LEN-1, 0)
  mem_stall_flg := io.dmem.ren && !io.dmem.rvalid

  // CSR
  val csr_rdata = MuxLookup(mem_reg_csr_addr, 0.U(WORD_LEN.W), Seq(
    0x305.U -> csr_trap_vector,
    CSR_ADDR_CYCLE  -> cycle_counter.io.value(31, 0),
    CSR_ADDR_CYCLEH -> cycle_counter.io.value(63, 32),
  ))

  val csr_wdata = MuxCase(0.U(WORD_LEN.W), Seq(
    (mem_reg_csr_cmd === CSR_W) -> mem_reg_op1_data,
    (mem_reg_csr_cmd === CSR_S) -> (csr_rdata | mem_reg_op1_data),
    (mem_reg_csr_cmd === CSR_C) -> (csr_rdata & ~mem_reg_op1_data),
    (mem_reg_csr_cmd === CSR_E) -> 11.U(WORD_LEN.W)
  ))
  
  when(mem_reg_csr_cmd > 0.U){
    when( mem_reg_csr_addr === 0x305.U ) {
      csr_trap_vector := csr_wdata
    }
  }

  def signExtend(value: UInt, w: Int) = {
      Fill(WORD_LEN - w, value(w - 1)) ## value(w - 1, 0)
  }
  def zeroExtend(value: UInt, w: Int) = {
      Fill(WORD_LEN - w, 0.U) ## value(w - 1, 0)
  }
  
  val mem_wb_byte_offset = mem_reg_alu_out(1, 0)
  val mem_wb_rdata = io.dmem.rdata >> (8.U * mem_wb_byte_offset)
  val mem_wb_data_load = MuxCase(mem_wb_rdata, Seq(
    (mem_reg_mem_w === MW_B) -> signExtend(mem_wb_rdata, 8),
    (mem_reg_mem_w === MW_H) -> signExtend(mem_wb_rdata, 16),
    (mem_reg_mem_w === MW_BU) -> zeroExtend(mem_wb_rdata, 8),
    (mem_reg_mem_w === MW_HU) -> zeroExtend(mem_wb_rdata, 16),
  ))

  mem_wb_data := MuxCase(mem_reg_alu_out, Seq(
    (mem_reg_wb_sel === WB_MEM) -> mem_wb_data_load,
    (mem_reg_wb_sel === WB_PC)  -> (mem_reg_pc + 4.U(WORD_LEN.W)),
    (mem_reg_wb_sel === WB_CSR) -> csr_rdata
  ))

  
  //**********************************
  // MEM/WB regsiter
  wb_reg_wb_addr := mem_reg_wb_addr
  wb_reg_rf_wen  := Mux(!mem_stall_flg, mem_reg_rf_wen, REN_X)
  wb_reg_wb_data := mem_wb_data 


  //**********************************
  // Writeback (WB) Stage

  when(wb_reg_rf_wen === REN_S) {
    regfile(wb_reg_wb_addr) := wb_reg_wb_data
  }

  // Debug signals
  io.debug_signal.cycle_counter := cycle_counter.io.value
  io.debug_signal.csr_rdata := csr_rdata
  io.debug_signal.mem_reg_csr_addr := mem_reg_csr_addr
  io.debug_signal.mem_reg_pc := mem_reg_pc

  //**********************************
  // IO & Debug
  io.gp := regfile(3)
  //io.exit := (mem_reg_pc === 0x44.U(WORD_LEN.W))
  io.exit := exe_is_ecall
  printf(p"if_reg_pc        : 0x${Hexadecimal(if_reg_pc)}\n")
  printf(p"id_reg_pc        : 0x${Hexadecimal(id_reg_pc)}\n")
  printf(p"id_reg_inst      : 0x${Hexadecimal(id_reg_inst)}\n")
  printf(p"stall_flg        : 0x${Hexadecimal(stall_flg)}\n")
  printf(p"id_inst          : 0x${Hexadecimal(id_inst)}\n")
  printf(p"id_rs1_data      : 0x${Hexadecimal(id_rs1_data)}\n")
  printf(p"id_rs2_data      : 0x${Hexadecimal(id_rs2_data)}\n")
  printf(p"exe_reg_pc       : 0x${Hexadecimal(exe_reg_pc)}\n")
  printf(p"exe_reg_op1_data : 0x${Hexadecimal(exe_reg_op1_data)}\n")
  printf(p"exe_reg_op2_data : 0x${Hexadecimal(exe_reg_op2_data)}\n")
  printf(p"exe_alu_out      : 0x${Hexadecimal(exe_alu_out)}\n")
  printf(p"mem_reg_pc       : 0x${Hexadecimal(mem_reg_pc)}\n")
  printf(p"mem_wb_data      : 0x${Hexadecimal(mem_wb_data)}\n")
  printf(p"mem_reg_mem_w    : 0x${Hexadecimal(mem_reg_mem_w)}\n")
  printf(p"mem_reg_wb_addr  : 0x${Hexadecimal(mem_reg_wb_addr)}\n")
  printf(p"wb_reg_wb_addr   : 0x${Hexadecimal(wb_reg_wb_addr)}\n")
  printf(p"wb_reg_wb_data   : 0x${Hexadecimal(wb_reg_wb_data)}\n")
  printf("---------\n")
}