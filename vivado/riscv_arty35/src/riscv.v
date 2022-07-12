module LongCounter(
  input         clock,
  input         reset,
  output [63:0] io_value
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] counter; // @[Core.scala 25:24]
  wire [63:0] _counter_T_1 = counter + 64'h1; // @[Core.scala 26:22]
  assign io_value = counter; // @[Core.scala 27:12]
  always @(posedge clock) begin
    if (reset) begin // @[Core.scala 25:24]
      counter <= 64'h0; // @[Core.scala 25:24]
    end else begin
      counter <= _counter_T_1; // @[Core.scala 26:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  counter = _RAND_0[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Core(
  input         clock,
  input         reset,
  output [31:0] io_imem_addr,
  input  [31:0] io_imem_inst,
  input         io_imem_valid,
  output [31:0] io_dmem_raddr,
  input  [31:0] io_dmem_rdata,
  output        io_dmem_ren,
  input         io_dmem_rvalid,
  output [31:0] io_dmem_waddr,
  output        io_dmem_wen,
  output [3:0]  io_dmem_wstrb,
  output [31:0] io_dmem_wdata,
  output        io_exit,
  output [31:0] io_debug_signal_mem_reg_pc,
  output [31:0] io_debug_signal_csr_rdata,
  output [31:0] io_debug_signal_mem_reg_csr_addr,
  output [63:0] io_debug_signal_cycle_counter
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regfile [0:31]; // @[Core.scala 48:20]
  wire [31:0] regfile_id_rs1_data_MPORT_data; // @[Core.scala 48:20]
  wire [4:0] regfile_id_rs1_data_MPORT_addr; // @[Core.scala 48:20]
  wire [31:0] regfile_id_rs2_data_MPORT_data; // @[Core.scala 48:20]
  wire [4:0] regfile_id_rs2_data_MPORT_addr; // @[Core.scala 48:20]
  wire [31:0] regfile_io_gp_MPORT_data; // @[Core.scala 48:20]
  wire [4:0] regfile_io_gp_MPORT_addr; // @[Core.scala 48:20]
  wire [31:0] regfile_MPORT_data; // @[Core.scala 48:20]
  wire [4:0] regfile_MPORT_addr; // @[Core.scala 48:20]
  wire  regfile_MPORT_mask; // @[Core.scala 48:20]
  wire  regfile_MPORT_en; // @[Core.scala 48:20]
  wire  cycle_counter_clock; // @[Core.scala 51:29]
  wire  cycle_counter_reset; // @[Core.scala 51:29]
  wire [63:0] cycle_counter_io_value; // @[Core.scala 51:29]
  reg [31:0] csr_trap_vector; // @[Core.scala 50:32]
  reg [31:0] id_reg_pc; // @[Core.scala 57:38]
  reg [31:0] id_reg_inst; // @[Core.scala 58:38]
  reg [31:0] exe_reg_pc; // @[Core.scala 61:38]
  reg [4:0] exe_reg_wb_addr; // @[Core.scala 62:38]
  reg [31:0] exe_reg_op1_data; // @[Core.scala 63:38]
  reg [31:0] exe_reg_op2_data; // @[Core.scala 64:38]
  reg [31:0] exe_reg_rs2_data; // @[Core.scala 65:38]
  reg [4:0] exe_reg_exe_fun; // @[Core.scala 66:38]
  reg [1:0] exe_reg_mem_wen; // @[Core.scala 67:38]
  reg [1:0] exe_reg_rf_wen; // @[Core.scala 68:38]
  reg [2:0] exe_reg_wb_sel; // @[Core.scala 69:38]
  reg [11:0] exe_reg_csr_addr; // @[Core.scala 70:38]
  reg [2:0] exe_reg_csr_cmd; // @[Core.scala 71:38]
  reg [31:0] exe_reg_imm_b_sext; // @[Core.scala 74:38]
  reg [31:0] exe_reg_mem_w; // @[Core.scala 77:38]
  reg  exe_is_ecall; // @[Core.scala 78:38]
  reg [31:0] mem_reg_pc; // @[Core.scala 81:38]
  reg [4:0] mem_reg_wb_addr; // @[Core.scala 82:38]
  reg [31:0] mem_reg_op1_data; // @[Core.scala 83:38]
  reg [31:0] mem_reg_rs2_data; // @[Core.scala 84:38]
  reg [1:0] mem_reg_mem_wen; // @[Core.scala 85:38]
  reg [1:0] mem_reg_rf_wen; // @[Core.scala 86:38]
  reg [2:0] mem_reg_wb_sel; // @[Core.scala 87:38]
  reg [11:0] mem_reg_csr_addr; // @[Core.scala 88:38]
  reg [2:0] mem_reg_csr_cmd; // @[Core.scala 89:38]
  reg [31:0] mem_reg_alu_out; // @[Core.scala 91:38]
  reg [31:0] mem_reg_mem_w; // @[Core.scala 92:38]
  reg [3:0] mem_reg_mem_wstrb; // @[Core.scala 93:38]
  reg [4:0] wb_reg_wb_addr; // @[Core.scala 95:38]
  reg [1:0] wb_reg_rf_wen; // @[Core.scala 96:38]
  reg [31:0] wb_reg_wb_data; // @[Core.scala 97:38]
  reg [31:0] if_reg_pc; // @[Core.scala 103:26]
  wire [31:0] if_inst = io_imem_valid ? io_imem_inst : 32'h13; // @[Core.scala 105:20]
  wire  _T_1 = ~reset; // @[Core.scala 106:9]
  wire [31:0] if_pc_plus4 = if_reg_pc + 32'h4; // @[Core.scala 114:31]
  wire  _if_pc_next_T_1 = 32'h73 == if_inst; // @[Core.scala 119:14]
  wire  _id_rs1_data_hazard_T = exe_reg_rf_wen == 2'h1; // @[Core.scala 143:44]
  wire [4:0] id_rs1_addr_b = id_reg_inst[19:15]; // @[Core.scala 139:34]
  wire  id_rs1_data_hazard = exe_reg_rf_wen == 2'h1 & id_rs1_addr_b != 5'h0 & id_rs1_addr_b == exe_reg_wb_addr; // @[Core.scala 143:82]
  wire [4:0] id_rs2_addr_b = id_reg_inst[24:20]; // @[Core.scala 140:34]
  wire  id_rs2_data_hazard = _id_rs1_data_hazard_T & id_rs2_addr_b != 5'h0 & id_rs2_addr_b == exe_reg_wb_addr; // @[Core.scala 144:82]
  wire  mem_stall_flg = io_dmem_ren & ~io_dmem_rvalid; // @[Core.scala 330:32]
  wire  stall_flg = id_rs1_data_hazard | id_rs2_data_hazard | mem_stall_flg; // @[Core.scala 145:57]
  wire  _if_pc_next_T_3 = stall_flg | ~io_imem_valid; // @[Core.scala 120:16]
  wire [31:0] _if_pc_next_T_4 = _if_pc_next_T_3 ? if_reg_pc : if_pc_plus4; // @[Mux.scala 98:16]
  wire  exe_jmp_flg = exe_reg_wb_sel == 3'h2; // @[Core.scala 297:34]
  wire  _exe_alu_out_T = exe_reg_exe_fun == 5'h1; // @[Core.scala 272:22]
  wire [31:0] _exe_alu_out_T_2 = exe_reg_op1_data + exe_reg_op2_data; // @[Core.scala 272:58]
  wire  _exe_alu_out_T_3 = exe_reg_exe_fun == 5'h2; // @[Core.scala 273:22]
  wire [31:0] _exe_alu_out_T_5 = exe_reg_op1_data - exe_reg_op2_data; // @[Core.scala 273:58]
  wire  _exe_alu_out_T_6 = exe_reg_exe_fun == 5'h3; // @[Core.scala 274:22]
  wire [31:0] _exe_alu_out_T_7 = exe_reg_op1_data & exe_reg_op2_data; // @[Core.scala 274:58]
  wire  _exe_alu_out_T_8 = exe_reg_exe_fun == 5'h4; // @[Core.scala 275:22]
  wire [31:0] _exe_alu_out_T_9 = exe_reg_op1_data | exe_reg_op2_data; // @[Core.scala 275:58]
  wire  _exe_alu_out_T_10 = exe_reg_exe_fun == 5'h5; // @[Core.scala 276:22]
  wire [31:0] _exe_alu_out_T_11 = exe_reg_op1_data ^ exe_reg_op2_data; // @[Core.scala 276:58]
  wire  _exe_alu_out_T_12 = exe_reg_exe_fun == 5'h6; // @[Core.scala 277:22]
  wire [62:0] _GEN_38 = {{31'd0}, exe_reg_op1_data}; // @[Core.scala 277:58]
  wire [62:0] _exe_alu_out_T_14 = _GEN_38 << exe_reg_op2_data[4:0]; // @[Core.scala 277:58]
  wire  _exe_alu_out_T_16 = exe_reg_exe_fun == 5'h7; // @[Core.scala 278:22]
  wire [31:0] _exe_alu_out_T_18 = exe_reg_op1_data >> exe_reg_op2_data[4:0]; // @[Core.scala 278:58]
  wire  _exe_alu_out_T_19 = exe_reg_exe_fun == 5'h8; // @[Core.scala 279:22]
  wire [31:0] _exe_alu_out_T_23 = $signed(exe_reg_op1_data) >>> exe_reg_op2_data[4:0]; // @[Core.scala 279:100]
  wire  _exe_alu_out_T_24 = exe_reg_exe_fun == 5'h9; // @[Core.scala 280:22]
  wire  _exe_alu_out_T_27 = $signed(exe_reg_op1_data) < $signed(exe_reg_op2_data); // @[Core.scala 280:67]
  wire  _exe_alu_out_T_28 = exe_reg_exe_fun == 5'ha; // @[Core.scala 281:22]
  wire  _exe_alu_out_T_29 = exe_reg_op1_data < exe_reg_op2_data; // @[Core.scala 281:58]
  wire  _exe_alu_out_T_30 = exe_reg_exe_fun == 5'h11; // @[Core.scala 282:22]
  wire [31:0] _exe_alu_out_T_34 = _exe_alu_out_T_2 & 32'hfffffffe; // @[Core.scala 282:79]
  wire  _exe_alu_out_T_35 = exe_reg_exe_fun == 5'h12; // @[Core.scala 283:22]
  wire [31:0] _exe_alu_out_T_36 = _exe_alu_out_T_35 ? exe_reg_op1_data : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_37 = _exe_alu_out_T_30 ? _exe_alu_out_T_34 : _exe_alu_out_T_36; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_38 = _exe_alu_out_T_28 ? {{31'd0}, _exe_alu_out_T_29} : _exe_alu_out_T_37; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_39 = _exe_alu_out_T_24 ? {{31'd0}, _exe_alu_out_T_27} : _exe_alu_out_T_38; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_40 = _exe_alu_out_T_19 ? _exe_alu_out_T_23 : _exe_alu_out_T_39; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_41 = _exe_alu_out_T_16 ? _exe_alu_out_T_18 : _exe_alu_out_T_40; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_42 = _exe_alu_out_T_12 ? _exe_alu_out_T_14[31:0] : _exe_alu_out_T_41; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_43 = _exe_alu_out_T_10 ? _exe_alu_out_T_11 : _exe_alu_out_T_42; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_44 = _exe_alu_out_T_8 ? _exe_alu_out_T_9 : _exe_alu_out_T_43; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_45 = _exe_alu_out_T_6 ? _exe_alu_out_T_7 : _exe_alu_out_T_44; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_46 = _exe_alu_out_T_3 ? _exe_alu_out_T_5 : _exe_alu_out_T_45; // @[Mux.scala 98:16]
  wire [31:0] exe_alu_out = _exe_alu_out_T ? _exe_alu_out_T_2 : _exe_alu_out_T_46; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T = exe_reg_exe_fun == 5'hb; // @[Core.scala 288:22]
  wire  _exe_br_flg_T_1 = exe_reg_op1_data == exe_reg_op2_data; // @[Core.scala 288:57]
  wire  _exe_br_flg_T_2 = exe_reg_exe_fun == 5'hc; // @[Core.scala 289:22]
  wire  _exe_br_flg_T_4 = ~_exe_br_flg_T_1; // @[Core.scala 289:38]
  wire  _exe_br_flg_T_5 = exe_reg_exe_fun == 5'hd; // @[Core.scala 290:22]
  wire  _exe_br_flg_T_9 = exe_reg_exe_fun == 5'he; // @[Core.scala 291:22]
  wire  _exe_br_flg_T_13 = ~_exe_alu_out_T_27; // @[Core.scala 291:38]
  wire  _exe_br_flg_T_14 = exe_reg_exe_fun == 5'hf; // @[Core.scala 292:22]
  wire  _exe_br_flg_T_16 = exe_reg_exe_fun == 5'h10; // @[Core.scala 293:22]
  wire  _exe_br_flg_T_18 = ~_exe_alu_out_T_29; // @[Core.scala 293:38]
  wire  _exe_br_flg_T_20 = _exe_br_flg_T_14 ? _exe_alu_out_T_29 : _exe_br_flg_T_16 & _exe_br_flg_T_18; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_21 = _exe_br_flg_T_9 ? _exe_br_flg_T_13 : _exe_br_flg_T_20; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_22 = _exe_br_flg_T_5 ? _exe_alu_out_T_27 : _exe_br_flg_T_21; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_23 = _exe_br_flg_T_2 ? _exe_br_flg_T_4 : _exe_br_flg_T_22; // @[Mux.scala 98:16]
  wire  exe_br_flg = _exe_br_flg_T ? _exe_br_flg_T_1 : _exe_br_flg_T_23; // @[Mux.scala 98:16]
  wire [31:0] exe_br_target = exe_reg_pc + exe_reg_imm_b_sext; // @[Core.scala 295:31]
  wire  _id_reg_inst_T = exe_br_flg | exe_jmp_flg; // @[Core.scala 130:17]
  wire [31:0] id_inst = _id_reg_inst_T | stall_flg ? 32'h13 : id_reg_inst; // @[Core.scala 148:20]
  wire [4:0] id_rs1_addr = id_inst[19:15]; // @[Core.scala 150:28]
  wire [4:0] id_rs2_addr = id_inst[24:20]; // @[Core.scala 151:28]
  wire [4:0] id_wb_addr = id_inst[11:7]; // @[Core.scala 152:28]
  wire  _id_rs1_data_T = id_rs1_addr == 5'h0; // @[Core.scala 156:18]
  wire  _id_rs1_data_T_2 = mem_reg_rf_wen == 2'h1; // @[Core.scala 157:59]
  wire  _id_rs1_data_T_3 = id_rs1_addr == mem_reg_wb_addr & mem_reg_rf_wen == 2'h1; // @[Core.scala 157:40]
  wire  _id_rs1_data_T_5 = wb_reg_rf_wen == 2'h1; // @[Core.scala 158:59]
  wire  _id_rs1_data_T_6 = id_rs1_addr == wb_reg_wb_addr & wb_reg_rf_wen == 2'h1; // @[Core.scala 158:40]
  wire [31:0] _id_rs1_data_T_7 = _id_rs1_data_T_6 ? wb_reg_wb_data : regfile_id_rs1_data_MPORT_data; // @[Mux.scala 98:16]
  wire  _mem_wb_data_T = mem_reg_wb_sel == 3'h1; // @[Core.scala 369:21]
  wire  _mem_wb_data_load_T = mem_reg_mem_w == 32'h3; // @[Core.scala 362:20]
  wire [1:0] mem_wb_byte_offset = mem_reg_alu_out[1:0]; // @[Core.scala 359:43]
  wire [5:0] _mem_wb_rdata_T = 4'h8 * mem_wb_byte_offset; // @[Core.scala 360:44]
  wire [31:0] mem_wb_rdata = io_dmem_rdata >> _mem_wb_rdata_T; // @[Core.scala 360:36]
  wire [23:0] _mem_wb_data_load_T_3 = mem_wb_rdata[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _mem_wb_data_load_T_5 = {_mem_wb_data_load_T_3,mem_wb_rdata[7:0]}; // @[Core.scala 353:40]
  wire  _mem_wb_data_load_T_6 = mem_reg_mem_w == 32'h2; // @[Core.scala 363:20]
  wire [15:0] _mem_wb_data_load_T_9 = mem_wb_rdata[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _mem_wb_data_load_T_11 = {_mem_wb_data_load_T_9,mem_wb_rdata[15:0]}; // @[Core.scala 353:40]
  wire  _mem_wb_data_load_T_12 = mem_reg_mem_w == 32'h5; // @[Core.scala 364:20]
  wire [31:0] _mem_wb_data_load_T_15 = {24'h0,mem_wb_rdata[7:0]}; // @[Core.scala 356:31]
  wire  _mem_wb_data_load_T_16 = mem_reg_mem_w == 32'h4; // @[Core.scala 365:20]
  wire [31:0] _mem_wb_data_load_T_19 = {16'h0,mem_wb_rdata[15:0]}; // @[Core.scala 356:31]
  wire [31:0] _mem_wb_data_load_T_20 = _mem_wb_data_load_T_16 ? _mem_wb_data_load_T_19 : mem_wb_rdata; // @[Mux.scala 98:16]
  wire [31:0] _mem_wb_data_load_T_21 = _mem_wb_data_load_T_12 ? _mem_wb_data_load_T_15 : _mem_wb_data_load_T_20; // @[Mux.scala 98:16]
  wire [31:0] _mem_wb_data_load_T_22 = _mem_wb_data_load_T_6 ? _mem_wb_data_load_T_11 : _mem_wb_data_load_T_21; // @[Mux.scala 98:16]
  wire [31:0] mem_wb_data_load = _mem_wb_data_load_T ? _mem_wb_data_load_T_5 : _mem_wb_data_load_T_22; // @[Mux.scala 98:16]
  wire  _mem_wb_data_T_1 = mem_reg_wb_sel == 3'h2; // @[Core.scala 370:21]
  wire [31:0] _mem_wb_data_T_3 = mem_reg_pc + 32'h4; // @[Core.scala 370:48]
  wire  _mem_wb_data_T_4 = mem_reg_wb_sel == 3'h3; // @[Core.scala 371:21]
  wire [31:0] _csr_rdata_T_3 = 12'h305 == mem_reg_csr_addr ? csr_trap_vector : 32'h0; // @[Mux.scala 80:57]
  wire [31:0] _csr_rdata_T_5 = 12'hc00 == mem_reg_csr_addr ? cycle_counter_io_value[31:0] : _csr_rdata_T_3; // @[Mux.scala 80:57]
  wire [31:0] csr_rdata = 12'hc80 == mem_reg_csr_addr ? cycle_counter_io_value[63:32] : _csr_rdata_T_5; // @[Mux.scala 80:57]
  wire [31:0] _mem_wb_data_T_5 = _mem_wb_data_T_4 ? csr_rdata : mem_reg_alu_out; // @[Mux.scala 98:16]
  wire [31:0] _mem_wb_data_T_6 = _mem_wb_data_T_1 ? _mem_wb_data_T_3 : _mem_wb_data_T_5; // @[Mux.scala 98:16]
  wire [31:0] mem_wb_data = _mem_wb_data_T ? mem_wb_data_load : _mem_wb_data_T_6; // @[Mux.scala 98:16]
  wire [31:0] _id_rs1_data_T_8 = _id_rs1_data_T_3 ? mem_wb_data : _id_rs1_data_T_7; // @[Mux.scala 98:16]
  wire [31:0] id_rs1_data = _id_rs1_data_T ? 32'h0 : _id_rs1_data_T_8; // @[Mux.scala 98:16]
  wire  _id_rs2_data_T = id_rs2_addr == 5'h0; // @[Core.scala 161:18]
  wire  _id_rs2_data_T_3 = id_rs2_addr == mem_reg_wb_addr & _id_rs1_data_T_2; // @[Core.scala 162:40]
  wire  _id_rs2_data_T_6 = id_rs2_addr == wb_reg_wb_addr & _id_rs1_data_T_5; // @[Core.scala 163:40]
  wire [31:0] _id_rs2_data_T_7 = _id_rs2_data_T_6 ? wb_reg_wb_data : regfile_id_rs2_data_MPORT_data; // @[Mux.scala 98:16]
  wire [31:0] _id_rs2_data_T_8 = _id_rs2_data_T_3 ? mem_wb_data : _id_rs2_data_T_7; // @[Mux.scala 98:16]
  wire [31:0] id_rs2_data = _id_rs2_data_T ? 32'h0 : _id_rs2_data_T_8; // @[Mux.scala 98:16]
  wire [11:0] id_imm_i = id_inst[31:20]; // @[Core.scala 166:25]
  wire [19:0] id_imm_i_sext_hi = id_imm_i[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_i_sext = {id_imm_i_sext_hi,id_imm_i}; // @[Cat.scala 30:58]
  wire [6:0] id_imm_s_hi = id_inst[31:25]; // @[Core.scala 168:29]
  wire [11:0] id_imm_s = {id_imm_s_hi,id_wb_addr}; // @[Cat.scala 30:58]
  wire [19:0] id_imm_s_sext_hi = id_imm_s[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_s_sext = {id_imm_s_sext_hi,id_imm_s_hi,id_wb_addr}; // @[Cat.scala 30:58]
  wire  id_imm_b_hi_hi = id_inst[31]; // @[Core.scala 170:29]
  wire  id_imm_b_hi_lo = id_inst[7]; // @[Core.scala 170:42]
  wire [5:0] id_imm_b_lo_hi = id_inst[30:25]; // @[Core.scala 170:54]
  wire [3:0] id_imm_b_lo_lo = id_inst[11:8]; // @[Core.scala 170:71]
  wire [11:0] id_imm_b = {id_imm_b_hi_hi,id_imm_b_hi_lo,id_imm_b_lo_hi,id_imm_b_lo_lo}; // @[Cat.scala 30:58]
  wire [18:0] id_imm_b_sext_hi_hi = id_imm_b[11] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_b_sext = {id_imm_b_sext_hi_hi,id_imm_b_hi_hi,id_imm_b_hi_lo,id_imm_b_lo_hi,id_imm_b_lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [7:0] id_imm_j_hi_lo = id_inst[19:12]; // @[Core.scala 172:42]
  wire  id_imm_j_lo_hi = id_inst[20]; // @[Core.scala 172:59]
  wire [9:0] id_imm_j_lo_lo = id_inst[30:21]; // @[Core.scala 172:72]
  wire [19:0] id_imm_j = {id_imm_b_hi_hi,id_imm_j_hi_lo,id_imm_j_lo_hi,id_imm_j_lo_lo}; // @[Cat.scala 30:58]
  wire [10:0] id_imm_j_sext_hi_hi = id_imm_j[19] ? 11'h7ff : 11'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_j_sext = {id_imm_j_sext_hi_hi,id_imm_b_hi_hi,id_imm_j_hi_lo,id_imm_j_lo_hi,id_imm_j_lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [19:0] id_imm_u = id_inst[31:12]; // @[Core.scala 174:25]
  wire [31:0] id_imm_u_shifted = {id_imm_u,12'h0}; // @[Cat.scala 30:58]
  wire [31:0] id_imm_z_uext = {27'h0,id_rs1_addr}; // @[Cat.scala 30:58]
  wire [31:0] _csignals_T = id_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_1 = 32'h3 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_3 = 32'h4003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_5 = 32'h23 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_7 = 32'h1003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_9 = 32'h5003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_11 = 32'h1023 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_13 = 32'h2003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_15 = 32'h2023 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_16 = id_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_17 = 32'h33 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_19 = 32'h13 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_21 = 32'h40000033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_23 = 32'h7033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_25 = 32'h6033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_27 = 32'h4033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_29 = 32'h7013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_31 = 32'h6013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_33 = 32'h4013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_35 = 32'h1033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_37 = 32'h5033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_39 = 32'h40005033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_41 = 32'h1013 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_43 = 32'h5013 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_45 = 32'h40005013 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_47 = 32'h2033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_49 = 32'h3033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_51 = 32'h2013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_53 = 32'h3013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_55 = 32'h63 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_57 = 32'h1063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_59 = 32'h5063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_61 = 32'h7063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_63 = 32'h4063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_65 = 32'h6063 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_66 = id_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _csignals_T_67 = 32'h6f == _csignals_T_66; // @[Lookup.scala 31:38]
  wire  _csignals_T_69 = 32'h67 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_71 = 32'h37 == _csignals_T_66; // @[Lookup.scala 31:38]
  wire  _csignals_T_73 = 32'h17 == _csignals_T_66; // @[Lookup.scala 31:38]
  wire  _csignals_T_75 = 32'h1073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_77 = 32'h5073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_79 = 32'h2073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_81 = 32'h6073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_83 = 32'h3073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_85 = 32'h7073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_87 = 32'h73 == id_inst; // @[Lookup.scala 31:38]
  wire [4:0] _csignals_T_89 = _csignals_T_85 ? 5'h12 : 5'h0; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_90 = _csignals_T_83 ? 5'h12 : _csignals_T_89; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_91 = _csignals_T_81 ? 5'h12 : _csignals_T_90; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_92 = _csignals_T_79 ? 5'h12 : _csignals_T_91; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_93 = _csignals_T_77 ? 5'h12 : _csignals_T_92; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_94 = _csignals_T_75 ? 5'h12 : _csignals_T_93; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_95 = _csignals_T_73 ? 5'h1 : _csignals_T_94; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_96 = _csignals_T_71 ? 5'h1 : _csignals_T_95; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_97 = _csignals_T_69 ? 5'h11 : _csignals_T_96; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_98 = _csignals_T_67 ? 5'h1 : _csignals_T_97; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_99 = _csignals_T_65 ? 5'hf : _csignals_T_98; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_100 = _csignals_T_63 ? 5'hd : _csignals_T_99; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_101 = _csignals_T_61 ? 5'h10 : _csignals_T_100; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_102 = _csignals_T_59 ? 5'he : _csignals_T_101; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_103 = _csignals_T_57 ? 5'hc : _csignals_T_102; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_104 = _csignals_T_55 ? 5'hb : _csignals_T_103; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_105 = _csignals_T_53 ? 5'ha : _csignals_T_104; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_106 = _csignals_T_51 ? 5'h9 : _csignals_T_105; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_107 = _csignals_T_49 ? 5'ha : _csignals_T_106; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_108 = _csignals_T_47 ? 5'h9 : _csignals_T_107; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_109 = _csignals_T_45 ? 5'h8 : _csignals_T_108; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_110 = _csignals_T_43 ? 5'h7 : _csignals_T_109; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_111 = _csignals_T_41 ? 5'h6 : _csignals_T_110; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_112 = _csignals_T_39 ? 5'h8 : _csignals_T_111; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_113 = _csignals_T_37 ? 5'h7 : _csignals_T_112; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_114 = _csignals_T_35 ? 5'h6 : _csignals_T_113; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_115 = _csignals_T_33 ? 5'h5 : _csignals_T_114; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_116 = _csignals_T_31 ? 5'h4 : _csignals_T_115; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_117 = _csignals_T_29 ? 5'h3 : _csignals_T_116; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_118 = _csignals_T_27 ? 5'h5 : _csignals_T_117; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_119 = _csignals_T_25 ? 5'h4 : _csignals_T_118; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_120 = _csignals_T_23 ? 5'h3 : _csignals_T_119; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_121 = _csignals_T_21 ? 5'h2 : _csignals_T_120; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_122 = _csignals_T_19 ? 5'h1 : _csignals_T_121; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_123 = _csignals_T_17 ? 5'h1 : _csignals_T_122; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_124 = _csignals_T_15 ? 5'h1 : _csignals_T_123; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_125 = _csignals_T_13 ? 5'h1 : _csignals_T_124; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_126 = _csignals_T_11 ? 5'h1 : _csignals_T_125; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_127 = _csignals_T_9 ? 5'h1 : _csignals_T_126; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_128 = _csignals_T_7 ? 5'h1 : _csignals_T_127; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_129 = _csignals_T_5 ? 5'h1 : _csignals_T_128; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_131 = _csignals_T_87 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_132 = _csignals_T_85 ? 2'h3 : _csignals_T_131; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_133 = _csignals_T_83 ? 2'h0 : _csignals_T_132; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_134 = _csignals_T_81 ? 2'h3 : _csignals_T_133; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_135 = _csignals_T_79 ? 2'h0 : _csignals_T_134; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_136 = _csignals_T_77 ? 2'h3 : _csignals_T_135; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_137 = _csignals_T_75 ? 2'h0 : _csignals_T_136; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_138 = _csignals_T_73 ? 2'h1 : _csignals_T_137; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_139 = _csignals_T_71 ? 2'h2 : _csignals_T_138; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_140 = _csignals_T_69 ? 2'h0 : _csignals_T_139; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_141 = _csignals_T_67 ? 2'h1 : _csignals_T_140; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_142 = _csignals_T_65 ? 2'h0 : _csignals_T_141; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_143 = _csignals_T_63 ? 2'h0 : _csignals_T_142; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_144 = _csignals_T_61 ? 2'h0 : _csignals_T_143; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_145 = _csignals_T_59 ? 2'h0 : _csignals_T_144; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_146 = _csignals_T_57 ? 2'h0 : _csignals_T_145; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_147 = _csignals_T_55 ? 2'h0 : _csignals_T_146; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_148 = _csignals_T_53 ? 2'h0 : _csignals_T_147; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_149 = _csignals_T_51 ? 2'h0 : _csignals_T_148; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_150 = _csignals_T_49 ? 2'h0 : _csignals_T_149; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_151 = _csignals_T_47 ? 2'h0 : _csignals_T_150; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_152 = _csignals_T_45 ? 2'h0 : _csignals_T_151; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_153 = _csignals_T_43 ? 2'h0 : _csignals_T_152; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_154 = _csignals_T_41 ? 2'h0 : _csignals_T_153; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_155 = _csignals_T_39 ? 2'h0 : _csignals_T_154; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_156 = _csignals_T_37 ? 2'h0 : _csignals_T_155; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_157 = _csignals_T_35 ? 2'h0 : _csignals_T_156; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_158 = _csignals_T_33 ? 2'h0 : _csignals_T_157; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_159 = _csignals_T_31 ? 2'h0 : _csignals_T_158; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_160 = _csignals_T_29 ? 2'h0 : _csignals_T_159; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_161 = _csignals_T_27 ? 2'h0 : _csignals_T_160; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_162 = _csignals_T_25 ? 2'h0 : _csignals_T_161; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_163 = _csignals_T_23 ? 2'h0 : _csignals_T_162; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_164 = _csignals_T_21 ? 2'h0 : _csignals_T_163; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_165 = _csignals_T_19 ? 2'h0 : _csignals_T_164; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_166 = _csignals_T_17 ? 2'h0 : _csignals_T_165; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_167 = _csignals_T_15 ? 2'h0 : _csignals_T_166; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_168 = _csignals_T_13 ? 2'h0 : _csignals_T_167; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_169 = _csignals_T_11 ? 2'h0 : _csignals_T_168; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_170 = _csignals_T_9 ? 2'h0 : _csignals_T_169; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_171 = _csignals_T_7 ? 2'h0 : _csignals_T_170; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_172 = _csignals_T_5 ? 2'h0 : _csignals_T_171; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_173 = _csignals_T_3 ? 2'h0 : _csignals_T_172; // @[Lookup.scala 33:37]
  wire [1:0] csignals_1 = _csignals_T_1 ? 2'h0 : _csignals_T_173; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_174 = _csignals_T_87 ? 3'h0 : 3'h1; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_175 = _csignals_T_85 ? 3'h0 : _csignals_T_174; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_176 = _csignals_T_83 ? 3'h0 : _csignals_T_175; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_177 = _csignals_T_81 ? 3'h0 : _csignals_T_176; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_178 = _csignals_T_79 ? 3'h0 : _csignals_T_177; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_179 = _csignals_T_77 ? 3'h0 : _csignals_T_178; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_180 = _csignals_T_75 ? 3'h0 : _csignals_T_179; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_181 = _csignals_T_73 ? 3'h5 : _csignals_T_180; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_182 = _csignals_T_71 ? 3'h5 : _csignals_T_181; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_183 = _csignals_T_69 ? 3'h2 : _csignals_T_182; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_184 = _csignals_T_67 ? 3'h4 : _csignals_T_183; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_185 = _csignals_T_65 ? 3'h1 : _csignals_T_184; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_186 = _csignals_T_63 ? 3'h1 : _csignals_T_185; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_187 = _csignals_T_61 ? 3'h1 : _csignals_T_186; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_188 = _csignals_T_59 ? 3'h1 : _csignals_T_187; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_189 = _csignals_T_57 ? 3'h1 : _csignals_T_188; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_190 = _csignals_T_55 ? 3'h1 : _csignals_T_189; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_191 = _csignals_T_53 ? 3'h2 : _csignals_T_190; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_192 = _csignals_T_51 ? 3'h2 : _csignals_T_191; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_193 = _csignals_T_49 ? 3'h1 : _csignals_T_192; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_194 = _csignals_T_47 ? 3'h1 : _csignals_T_193; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_195 = _csignals_T_45 ? 3'h2 : _csignals_T_194; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_196 = _csignals_T_43 ? 3'h2 : _csignals_T_195; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_197 = _csignals_T_41 ? 3'h2 : _csignals_T_196; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_198 = _csignals_T_39 ? 3'h1 : _csignals_T_197; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_199 = _csignals_T_37 ? 3'h1 : _csignals_T_198; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_200 = _csignals_T_35 ? 3'h1 : _csignals_T_199; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_201 = _csignals_T_33 ? 3'h2 : _csignals_T_200; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_202 = _csignals_T_31 ? 3'h2 : _csignals_T_201; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_203 = _csignals_T_29 ? 3'h2 : _csignals_T_202; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_204 = _csignals_T_27 ? 3'h1 : _csignals_T_203; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_205 = _csignals_T_25 ? 3'h1 : _csignals_T_204; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_206 = _csignals_T_23 ? 3'h1 : _csignals_T_205; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_207 = _csignals_T_21 ? 3'h1 : _csignals_T_206; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_208 = _csignals_T_19 ? 3'h2 : _csignals_T_207; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_209 = _csignals_T_17 ? 3'h1 : _csignals_T_208; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_210 = _csignals_T_15 ? 3'h3 : _csignals_T_209; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_211 = _csignals_T_13 ? 3'h2 : _csignals_T_210; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_212 = _csignals_T_11 ? 3'h3 : _csignals_T_211; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_213 = _csignals_T_9 ? 3'h2 : _csignals_T_212; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_214 = _csignals_T_7 ? 3'h2 : _csignals_T_213; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_215 = _csignals_T_5 ? 3'h3 : _csignals_T_214; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_216 = _csignals_T_3 ? 3'h2 : _csignals_T_215; // @[Lookup.scala 33:37]
  wire [2:0] csignals_2 = _csignals_T_1 ? 3'h2 : _csignals_T_216; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_253 = _csignals_T_15 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_254 = _csignals_T_13 ? 2'h0 : _csignals_T_253; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_255 = _csignals_T_11 ? 2'h1 : _csignals_T_254; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_256 = _csignals_T_9 ? 2'h0 : _csignals_T_255; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_257 = _csignals_T_7 ? 2'h0 : _csignals_T_256; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_258 = _csignals_T_5 ? 2'h1 : _csignals_T_257; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_261 = _csignals_T_85 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_262 = _csignals_T_83 ? 2'h1 : _csignals_T_261; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_263 = _csignals_T_81 ? 2'h1 : _csignals_T_262; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_264 = _csignals_T_79 ? 2'h1 : _csignals_T_263; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_265 = _csignals_T_77 ? 2'h1 : _csignals_T_264; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_266 = _csignals_T_75 ? 2'h1 : _csignals_T_265; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_267 = _csignals_T_73 ? 2'h1 : _csignals_T_266; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_268 = _csignals_T_71 ? 2'h1 : _csignals_T_267; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_269 = _csignals_T_69 ? 2'h1 : _csignals_T_268; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_270 = _csignals_T_67 ? 2'h1 : _csignals_T_269; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_271 = _csignals_T_65 ? 2'h0 : _csignals_T_270; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_272 = _csignals_T_63 ? 2'h0 : _csignals_T_271; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_273 = _csignals_T_61 ? 2'h0 : _csignals_T_272; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_274 = _csignals_T_59 ? 2'h0 : _csignals_T_273; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_275 = _csignals_T_57 ? 2'h0 : _csignals_T_274; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_276 = _csignals_T_55 ? 2'h0 : _csignals_T_275; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_277 = _csignals_T_53 ? 2'h1 : _csignals_T_276; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_278 = _csignals_T_51 ? 2'h1 : _csignals_T_277; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_279 = _csignals_T_49 ? 2'h1 : _csignals_T_278; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_280 = _csignals_T_47 ? 2'h1 : _csignals_T_279; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_281 = _csignals_T_45 ? 2'h1 : _csignals_T_280; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_282 = _csignals_T_43 ? 2'h1 : _csignals_T_281; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_283 = _csignals_T_41 ? 2'h1 : _csignals_T_282; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_284 = _csignals_T_39 ? 2'h1 : _csignals_T_283; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_285 = _csignals_T_37 ? 2'h1 : _csignals_T_284; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_286 = _csignals_T_35 ? 2'h1 : _csignals_T_285; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_287 = _csignals_T_33 ? 2'h1 : _csignals_T_286; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_288 = _csignals_T_31 ? 2'h1 : _csignals_T_287; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_289 = _csignals_T_29 ? 2'h1 : _csignals_T_288; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_290 = _csignals_T_27 ? 2'h1 : _csignals_T_289; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_291 = _csignals_T_25 ? 2'h1 : _csignals_T_290; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_292 = _csignals_T_23 ? 2'h1 : _csignals_T_291; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_293 = _csignals_T_21 ? 2'h1 : _csignals_T_292; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_294 = _csignals_T_19 ? 2'h1 : _csignals_T_293; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_295 = _csignals_T_17 ? 2'h1 : _csignals_T_294; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_296 = _csignals_T_15 ? 2'h0 : _csignals_T_295; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_297 = _csignals_T_13 ? 2'h1 : _csignals_T_296; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_298 = _csignals_T_11 ? 2'h0 : _csignals_T_297; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_299 = _csignals_T_9 ? 2'h1 : _csignals_T_298; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_300 = _csignals_T_7 ? 2'h1 : _csignals_T_299; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_301 = _csignals_T_5 ? 2'h0 : _csignals_T_300; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_304 = _csignals_T_85 ? 3'h3 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_305 = _csignals_T_83 ? 3'h3 : _csignals_T_304; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_306 = _csignals_T_81 ? 3'h3 : _csignals_T_305; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_307 = _csignals_T_79 ? 3'h3 : _csignals_T_306; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_308 = _csignals_T_77 ? 3'h3 : _csignals_T_307; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_309 = _csignals_T_75 ? 3'h3 : _csignals_T_308; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_310 = _csignals_T_73 ? 3'h0 : _csignals_T_309; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_311 = _csignals_T_71 ? 3'h0 : _csignals_T_310; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_312 = _csignals_T_69 ? 3'h2 : _csignals_T_311; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_313 = _csignals_T_67 ? 3'h2 : _csignals_T_312; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_314 = _csignals_T_65 ? 3'h0 : _csignals_T_313; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_315 = _csignals_T_63 ? 3'h0 : _csignals_T_314; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_316 = _csignals_T_61 ? 3'h0 : _csignals_T_315; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_317 = _csignals_T_59 ? 3'h0 : _csignals_T_316; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_318 = _csignals_T_57 ? 3'h0 : _csignals_T_317; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_319 = _csignals_T_55 ? 3'h0 : _csignals_T_318; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_320 = _csignals_T_53 ? 3'h0 : _csignals_T_319; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_321 = _csignals_T_51 ? 3'h0 : _csignals_T_320; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_322 = _csignals_T_49 ? 3'h0 : _csignals_T_321; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_323 = _csignals_T_47 ? 3'h0 : _csignals_T_322; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_324 = _csignals_T_45 ? 3'h0 : _csignals_T_323; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_325 = _csignals_T_43 ? 3'h0 : _csignals_T_324; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_326 = _csignals_T_41 ? 3'h0 : _csignals_T_325; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_327 = _csignals_T_39 ? 3'h0 : _csignals_T_326; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_328 = _csignals_T_37 ? 3'h0 : _csignals_T_327; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_329 = _csignals_T_35 ? 3'h0 : _csignals_T_328; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_330 = _csignals_T_33 ? 3'h0 : _csignals_T_329; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_331 = _csignals_T_31 ? 3'h0 : _csignals_T_330; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_332 = _csignals_T_29 ? 3'h0 : _csignals_T_331; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_333 = _csignals_T_27 ? 3'h0 : _csignals_T_332; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_334 = _csignals_T_25 ? 3'h0 : _csignals_T_333; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_335 = _csignals_T_23 ? 3'h0 : _csignals_T_334; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_336 = _csignals_T_21 ? 3'h0 : _csignals_T_335; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_337 = _csignals_T_19 ? 3'h0 : _csignals_T_336; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_338 = _csignals_T_17 ? 3'h0 : _csignals_T_337; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_339 = _csignals_T_15 ? 3'h0 : _csignals_T_338; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_340 = _csignals_T_13 ? 3'h1 : _csignals_T_339; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_341 = _csignals_T_11 ? 3'h0 : _csignals_T_340; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_342 = _csignals_T_9 ? 3'h1 : _csignals_T_341; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_343 = _csignals_T_7 ? 3'h1 : _csignals_T_342; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_344 = _csignals_T_5 ? 3'h0 : _csignals_T_343; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_346 = _csignals_T_87 ? 3'h4 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_347 = _csignals_T_85 ? 3'h3 : _csignals_T_346; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_348 = _csignals_T_83 ? 3'h3 : _csignals_T_347; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_349 = _csignals_T_81 ? 3'h2 : _csignals_T_348; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_350 = _csignals_T_79 ? 3'h2 : _csignals_T_349; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_351 = _csignals_T_77 ? 3'h1 : _csignals_T_350; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_352 = _csignals_T_75 ? 3'h1 : _csignals_T_351; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_353 = _csignals_T_73 ? 3'h0 : _csignals_T_352; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_354 = _csignals_T_71 ? 3'h0 : _csignals_T_353; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_355 = _csignals_T_69 ? 3'h0 : _csignals_T_354; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_356 = _csignals_T_67 ? 3'h0 : _csignals_T_355; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_357 = _csignals_T_65 ? 3'h0 : _csignals_T_356; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_358 = _csignals_T_63 ? 3'h0 : _csignals_T_357; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_359 = _csignals_T_61 ? 3'h0 : _csignals_T_358; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_360 = _csignals_T_59 ? 3'h0 : _csignals_T_359; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_361 = _csignals_T_57 ? 3'h0 : _csignals_T_360; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_362 = _csignals_T_55 ? 3'h0 : _csignals_T_361; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_363 = _csignals_T_53 ? 3'h0 : _csignals_T_362; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_364 = _csignals_T_51 ? 3'h0 : _csignals_T_363; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_365 = _csignals_T_49 ? 3'h0 : _csignals_T_364; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_366 = _csignals_T_47 ? 3'h0 : _csignals_T_365; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_367 = _csignals_T_45 ? 3'h0 : _csignals_T_366; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_368 = _csignals_T_43 ? 3'h0 : _csignals_T_367; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_369 = _csignals_T_41 ? 3'h0 : _csignals_T_368; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_370 = _csignals_T_39 ? 3'h0 : _csignals_T_369; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_371 = _csignals_T_37 ? 3'h0 : _csignals_T_370; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_372 = _csignals_T_35 ? 3'h0 : _csignals_T_371; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_373 = _csignals_T_33 ? 3'h0 : _csignals_T_372; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_374 = _csignals_T_31 ? 3'h0 : _csignals_T_373; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_375 = _csignals_T_29 ? 3'h0 : _csignals_T_374; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_376 = _csignals_T_27 ? 3'h0 : _csignals_T_375; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_377 = _csignals_T_25 ? 3'h0 : _csignals_T_376; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_378 = _csignals_T_23 ? 3'h0 : _csignals_T_377; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_379 = _csignals_T_21 ? 3'h0 : _csignals_T_378; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_380 = _csignals_T_19 ? 3'h0 : _csignals_T_379; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_381 = _csignals_T_17 ? 3'h0 : _csignals_T_380; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_382 = _csignals_T_15 ? 3'h0 : _csignals_T_381; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_383 = _csignals_T_13 ? 3'h0 : _csignals_T_382; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_384 = _csignals_T_11 ? 3'h0 : _csignals_T_383; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_385 = _csignals_T_9 ? 3'h0 : _csignals_T_384; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_386 = _csignals_T_7 ? 3'h0 : _csignals_T_385; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_387 = _csignals_T_5 ? 3'h0 : _csignals_T_386; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_388 = _csignals_T_3 ? 3'h0 : _csignals_T_387; // @[Lookup.scala 33:37]
  wire [2:0] csignals_6 = _csignals_T_1 ? 3'h0 : _csignals_T_388; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_425 = _csignals_T_15 ? 3'h1 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_426 = _csignals_T_13 ? 3'h1 : _csignals_T_425; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_427 = _csignals_T_11 ? 3'h2 : _csignals_T_426; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_428 = _csignals_T_9 ? 3'h4 : _csignals_T_427; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_429 = _csignals_T_7 ? 3'h2 : _csignals_T_428; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_430 = _csignals_T_5 ? 3'h3 : _csignals_T_429; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_431 = _csignals_T_3 ? 3'h5 : _csignals_T_430; // @[Lookup.scala 33:37]
  wire [2:0] csignals_7 = _csignals_T_1 ? 3'h3 : _csignals_T_431; // @[Lookup.scala 33:37]
  wire  _id_op1_data_T = csignals_1 == 2'h0; // @[Core.scala 231:17]
  wire  _id_op1_data_T_1 = csignals_1 == 2'h1; // @[Core.scala 232:17]
  wire  _id_op1_data_T_2 = csignals_1 == 2'h3; // @[Core.scala 233:17]
  wire [31:0] _id_op1_data_T_3 = _id_op1_data_T_2 ? id_imm_z_uext : 32'h0; // @[Mux.scala 98:16]
  wire  _id_op2_data_T = csignals_2 == 3'h1; // @[Core.scala 236:17]
  wire  _id_op2_data_T_1 = csignals_2 == 3'h2; // @[Core.scala 237:17]
  wire  _id_op2_data_T_2 = csignals_2 == 3'h3; // @[Core.scala 238:17]
  wire  _id_op2_data_T_3 = csignals_2 == 3'h4; // @[Core.scala 239:17]
  wire  _id_op2_data_T_4 = csignals_2 == 3'h5; // @[Core.scala 240:17]
  wire [31:0] _id_op2_data_T_5 = _id_op2_data_T_4 ? id_imm_u_shifted : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _id_op2_data_T_6 = _id_op2_data_T_3 ? id_imm_j_sext : _id_op2_data_T_5; // @[Mux.scala 98:16]
  wire [31:0] _id_op2_data_T_7 = _id_op2_data_T_2 ? id_imm_s_sext : _id_op2_data_T_6; // @[Mux.scala 98:16]
  wire  _T_2 = ~mem_stall_flg; // @[Core.scala 248:9]
  wire  _mem_reg_mem_wstrb_T = exe_reg_mem_w == 32'h3; // @[Core.scala 316:22]
  wire  _mem_reg_mem_wstrb_T_1 = exe_reg_mem_w == 32'h2; // @[Core.scala 317:22]
  wire [3:0] _mem_reg_mem_wstrb_T_4 = _mem_reg_mem_wstrb_T_1 ? 4'h3 : 4'hf; // @[Mux.scala 98:16]
  wire [3:0] _mem_reg_mem_wstrb_T_5 = _mem_reg_mem_wstrb_T ? 4'h1 : _mem_reg_mem_wstrb_T_4; // @[Mux.scala 98:16]
  wire [6:0] _GEN_39 = {{3'd0}, _mem_reg_mem_wstrb_T_5}; // @[Core.scala 319:8]
  wire [6:0] _mem_reg_mem_wstrb_T_7 = _GEN_39 << exe_alu_out[1:0]; // @[Core.scala 319:8]
  wire [94:0] _GEN_40 = {{63'd0}, mem_reg_rs2_data}; // @[Core.scala 329:38]
  wire [94:0] _io_dmem_wdata_T_2 = _GEN_40 << _mem_wb_rdata_T; // @[Core.scala 329:38]
  wire  _csr_wdata_T = mem_reg_csr_cmd == 3'h1; // @[Core.scala 340:22]
  wire  _csr_wdata_T_1 = mem_reg_csr_cmd == 3'h2; // @[Core.scala 341:22]
  wire [31:0] _csr_wdata_T_2 = csr_rdata | mem_reg_op1_data; // @[Core.scala 341:47]
  wire  _csr_wdata_T_3 = mem_reg_csr_cmd == 3'h3; // @[Core.scala 342:22]
  wire [31:0] _csr_wdata_T_4 = ~mem_reg_op1_data; // @[Core.scala 342:49]
  wire [31:0] _csr_wdata_T_5 = csr_rdata & _csr_wdata_T_4; // @[Core.scala 342:47]
  wire  _csr_wdata_T_6 = mem_reg_csr_cmd == 3'h4; // @[Core.scala 343:22]
  wire [31:0] _csr_wdata_T_7 = _csr_wdata_T_6 ? 32'hb : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _csr_wdata_T_8 = _csr_wdata_T_3 ? _csr_wdata_T_5 : _csr_wdata_T_7; // @[Mux.scala 98:16]
  wire [31:0] _csr_wdata_T_9 = _csr_wdata_T_1 ? _csr_wdata_T_2 : _csr_wdata_T_8; // @[Mux.scala 98:16]
  LongCounter cycle_counter ( // @[Core.scala 51:29]
    .clock(cycle_counter_clock),
    .reset(cycle_counter_reset),
    .io_value(cycle_counter_io_value)
  );
  assign regfile_id_rs1_data_MPORT_addr = id_inst[19:15];
  assign regfile_id_rs1_data_MPORT_data = regfile[regfile_id_rs1_data_MPORT_addr]; // @[Core.scala 48:20]
  assign regfile_id_rs2_data_MPORT_addr = id_inst[24:20];
  assign regfile_id_rs2_data_MPORT_data = regfile[regfile_id_rs2_data_MPORT_addr]; // @[Core.scala 48:20]
  assign regfile_io_gp_MPORT_addr = 5'h3;
  assign regfile_io_gp_MPORT_data = regfile[regfile_io_gp_MPORT_addr]; // @[Core.scala 48:20]
  assign regfile_MPORT_data = wb_reg_wb_data;
  assign regfile_MPORT_addr = wb_reg_wb_addr;
  assign regfile_MPORT_mask = 1'h1;
  assign regfile_MPORT_en = wb_reg_rf_wen == 2'h1;
  assign io_imem_addr = if_reg_pc; // @[Core.scala 104:16]
  assign io_dmem_raddr = mem_reg_alu_out; // @[Core.scala 324:17]
  assign io_dmem_ren = mem_reg_wb_sel == 3'h1; // @[Core.scala 326:35]
  assign io_dmem_waddr = mem_reg_alu_out; // @[Core.scala 325:17]
  assign io_dmem_wen = mem_reg_mem_wen[0]; // @[Core.scala 327:17]
  assign io_dmem_wstrb = mem_reg_mem_wstrb; // @[Core.scala 328:17]
  assign io_dmem_wdata = _io_dmem_wdata_T_2[31:0]; // @[Core.scala 329:71]
  assign io_exit = exe_is_ecall; // @[Core.scala 399:11]
  assign io_debug_signal_mem_reg_pc = mem_reg_pc; // @[Core.scala 393:30]
  assign io_debug_signal_csr_rdata = 12'hc80 == mem_reg_csr_addr ? cycle_counter_io_value[63:32] : _csr_rdata_T_5; // @[Mux.scala 80:57]
  assign io_debug_signal_mem_reg_csr_addr = {{20'd0}, mem_reg_csr_addr}; // @[Core.scala 392:36]
  assign io_debug_signal_cycle_counter = cycle_counter_io_value; // @[Core.scala 390:33]
  assign cycle_counter_clock = clock;
  assign cycle_counter_reset = reset;
  always @(posedge clock) begin
    if(regfile_MPORT_en & regfile_MPORT_mask) begin
      regfile[regfile_MPORT_addr] <= regfile_MPORT_data; // @[Core.scala 48:20]
    end
    if (reset) begin // @[Core.scala 50:32]
      csr_trap_vector <= 32'h0; // @[Core.scala 50:32]
    end else if (mem_reg_csr_cmd > 3'h0) begin // @[Core.scala 346:30]
      if (mem_reg_csr_addr == 12'h305) begin // @[Core.scala 347:42]
        if (_csr_wdata_T) begin // @[Mux.scala 98:16]
          csr_trap_vector <= mem_reg_op1_data;
        end else begin
          csr_trap_vector <= _csr_wdata_T_9;
        end
      end
    end
    if (reset) begin // @[Core.scala 57:38]
      id_reg_pc <= 32'h0; // @[Core.scala 57:38]
    end else if (!(stall_flg)) begin // @[Core.scala 127:21]
      id_reg_pc <= if_reg_pc;
    end
    if (reset) begin // @[Core.scala 58:38]
      id_reg_inst <= 32'h0; // @[Core.scala 58:38]
    end else if (_id_reg_inst_T) begin // @[Mux.scala 98:16]
      id_reg_inst <= 32'h13;
    end else if (!(stall_flg)) begin // @[Mux.scala 98:16]
      if (io_imem_valid) begin // @[Core.scala 105:20]
        id_reg_inst <= io_imem_inst;
      end else begin
        id_reg_inst <= 32'h13;
      end
    end
    if (reset) begin // @[Core.scala 61:38]
      exe_reg_pc <= 32'h0; // @[Core.scala 61:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      exe_reg_pc <= id_reg_pc; // @[Core.scala 249:27]
    end
    if (reset) begin // @[Core.scala 62:38]
      exe_reg_wb_addr <= 5'h0; // @[Core.scala 62:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      exe_reg_wb_addr <= id_wb_addr; // @[Core.scala 253:27]
    end
    if (reset) begin // @[Core.scala 63:38]
      exe_reg_op1_data <= 32'h0; // @[Core.scala 63:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (_id_op1_data_T) begin // @[Mux.scala 98:16]
        if (_id_rs1_data_T) begin // @[Mux.scala 98:16]
          exe_reg_op1_data <= 32'h0;
        end else begin
          exe_reg_op1_data <= _id_rs1_data_T_8;
        end
      end else if (_id_op1_data_T_1) begin // @[Mux.scala 98:16]
        exe_reg_op1_data <= id_reg_pc;
      end else begin
        exe_reg_op1_data <= _id_op1_data_T_3;
      end
    end
    if (reset) begin // @[Core.scala 64:38]
      exe_reg_op2_data <= 32'h0; // @[Core.scala 64:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (_id_op2_data_T) begin // @[Mux.scala 98:16]
        if (_id_rs2_data_T) begin // @[Mux.scala 98:16]
          exe_reg_op2_data <= 32'h0;
        end else begin
          exe_reg_op2_data <= _id_rs2_data_T_8;
        end
      end else if (_id_op2_data_T_1) begin // @[Mux.scala 98:16]
        exe_reg_op2_data <= id_imm_i_sext;
      end else begin
        exe_reg_op2_data <= _id_op2_data_T_7;
      end
    end
    if (reset) begin // @[Core.scala 65:38]
      exe_reg_rs2_data <= 32'h0; // @[Core.scala 65:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (_id_rs2_data_T) begin // @[Mux.scala 98:16]
        exe_reg_rs2_data <= 32'h0;
      end else if (_id_rs2_data_T_3) begin // @[Mux.scala 98:16]
        exe_reg_rs2_data <= mem_wb_data;
      end else begin
        exe_reg_rs2_data <= _id_rs2_data_T_7;
      end
    end
    if (reset) begin // @[Core.scala 66:38]
      exe_reg_exe_fun <= 5'h0; // @[Core.scala 66:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_exe_fun <= 5'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_exe_fun <= 5'h1;
      end else begin
        exe_reg_exe_fun <= _csignals_T_129;
      end
    end
    if (reset) begin // @[Core.scala 67:38]
      exe_reg_mem_wen <= 2'h0; // @[Core.scala 67:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_mem_wen <= 2'h0;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_mem_wen <= 2'h0;
      end else begin
        exe_reg_mem_wen <= _csignals_T_258;
      end
    end
    if (reset) begin // @[Core.scala 68:38]
      exe_reg_rf_wen <= 2'h0; // @[Core.scala 68:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_rf_wen <= 2'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_rf_wen <= 2'h1;
      end else begin
        exe_reg_rf_wen <= _csignals_T_301;
      end
    end
    if (reset) begin // @[Core.scala 69:38]
      exe_reg_wb_sel <= 3'h0; // @[Core.scala 69:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_wb_sel <= 3'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_wb_sel <= 3'h1;
      end else begin
        exe_reg_wb_sel <= _csignals_T_344;
      end
    end
    if (reset) begin // @[Core.scala 70:38]
      exe_reg_csr_addr <= 12'h0; // @[Core.scala 70:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (csignals_6 == 3'h4) begin // @[Core.scala 243:24]
        exe_reg_csr_addr <= 12'h342;
      end else begin
        exe_reg_csr_addr <= id_imm_i;
      end
    end
    if (reset) begin // @[Core.scala 71:38]
      exe_reg_csr_cmd <= 3'h0; // @[Core.scala 71:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_csr_cmd <= 3'h0;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_csr_cmd <= 3'h0;
      end else begin
        exe_reg_csr_cmd <= _csignals_T_387;
      end
    end
    if (reset) begin // @[Core.scala 74:38]
      exe_reg_imm_b_sext <= 32'h0; // @[Core.scala 74:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      exe_reg_imm_b_sext <= id_imm_b_sext; // @[Core.scala 259:27]
    end
    if (reset) begin // @[Core.scala 77:38]
      exe_reg_mem_w <= 32'h0; // @[Core.scala 77:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      exe_reg_mem_w <= {{29'd0}, csignals_7}; // @[Core.scala 265:27]
    end
    if (reset) begin // @[Core.scala 78:38]
      exe_is_ecall <= 1'h0; // @[Core.scala 78:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 248:26]
      exe_is_ecall <= _csignals_T_87; // @[Core.scala 266:27]
    end
    if (reset) begin // @[Core.scala 81:38]
      mem_reg_pc <= 32'h0; // @[Core.scala 81:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_pc <= exe_reg_pc; // @[Core.scala 303:24]
    end
    if (reset) begin // @[Core.scala 82:38]
      mem_reg_wb_addr <= 5'h0; // @[Core.scala 82:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_wb_addr <= exe_reg_wb_addr; // @[Core.scala 306:24]
    end
    if (reset) begin // @[Core.scala 83:38]
      mem_reg_op1_data <= 32'h0; // @[Core.scala 83:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_op1_data <= exe_reg_op1_data; // @[Core.scala 304:24]
    end
    if (reset) begin // @[Core.scala 84:38]
      mem_reg_rs2_data <= 32'h0; // @[Core.scala 84:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_rs2_data <= exe_reg_rs2_data; // @[Core.scala 305:24]
    end
    if (reset) begin // @[Core.scala 85:38]
      mem_reg_mem_wen <= 2'h0; // @[Core.scala 85:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_mem_wen <= exe_reg_mem_wen; // @[Core.scala 313:24]
    end
    if (reset) begin // @[Core.scala 86:38]
      mem_reg_rf_wen <= 2'h0; // @[Core.scala 86:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_rf_wen <= exe_reg_rf_wen; // @[Core.scala 308:24]
    end
    if (reset) begin // @[Core.scala 87:38]
      mem_reg_wb_sel <= 3'h0; // @[Core.scala 87:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_wb_sel <= exe_reg_wb_sel; // @[Core.scala 309:24]
    end
    if (reset) begin // @[Core.scala 88:38]
      mem_reg_csr_addr <= 12'h0; // @[Core.scala 88:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_csr_addr <= exe_reg_csr_addr; // @[Core.scala 310:24]
    end
    if (reset) begin // @[Core.scala 89:38]
      mem_reg_csr_cmd <= 3'h0; // @[Core.scala 89:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_csr_cmd <= exe_reg_csr_cmd; // @[Core.scala 311:24]
    end
    if (reset) begin // @[Core.scala 91:38]
      mem_reg_alu_out <= 32'h0; // @[Core.scala 91:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      if (_exe_alu_out_T) begin // @[Mux.scala 98:16]
        mem_reg_alu_out <= _exe_alu_out_T_2;
      end else if (_exe_alu_out_T_3) begin // @[Mux.scala 98:16]
        mem_reg_alu_out <= _exe_alu_out_T_5;
      end else begin
        mem_reg_alu_out <= _exe_alu_out_T_45;
      end
    end
    if (reset) begin // @[Core.scala 92:38]
      mem_reg_mem_w <= 32'h0; // @[Core.scala 92:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_mem_w <= exe_reg_mem_w; // @[Core.scala 314:24]
    end
    if (reset) begin // @[Core.scala 93:38]
      mem_reg_mem_wstrb <= 4'h0; // @[Core.scala 93:38]
    end else if (_T_2) begin // @[Core.scala 302:26]
      mem_reg_mem_wstrb <= _mem_reg_mem_wstrb_T_7[3:0]; // @[Core.scala 315:24]
    end
    if (reset) begin // @[Core.scala 95:38]
      wb_reg_wb_addr <= 5'h0; // @[Core.scala 95:38]
    end else begin
      wb_reg_wb_addr <= mem_reg_wb_addr; // @[Core.scala 377:18]
    end
    if (reset) begin // @[Core.scala 96:38]
      wb_reg_rf_wen <= 2'h0; // @[Core.scala 96:38]
    end else if (_T_2) begin // @[Core.scala 378:24]
      wb_reg_rf_wen <= mem_reg_rf_wen;
    end else begin
      wb_reg_rf_wen <= 2'h0;
    end
    if (reset) begin // @[Core.scala 97:38]
      wb_reg_wb_data <= 32'h0; // @[Core.scala 97:38]
    end else if (_mem_wb_data_T) begin // @[Mux.scala 98:16]
      if (_mem_wb_data_load_T) begin // @[Mux.scala 98:16]
        wb_reg_wb_data <= _mem_wb_data_load_T_5;
      end else if (_mem_wb_data_load_T_6) begin // @[Mux.scala 98:16]
        wb_reg_wb_data <= _mem_wb_data_load_T_11;
      end else begin
        wb_reg_wb_data <= _mem_wb_data_load_T_21;
      end
    end else if (_mem_wb_data_T_1) begin // @[Mux.scala 98:16]
      wb_reg_wb_data <= _mem_wb_data_T_3;
    end else if (_mem_wb_data_T_4) begin // @[Mux.scala 98:16]
      wb_reg_wb_data <= csr_rdata;
    end else begin
      wb_reg_wb_data <= mem_reg_alu_out;
    end
    if (reset) begin // @[Core.scala 103:26]
      if_reg_pc <= 32'h8000000; // @[Core.scala 103:26]
    end else if (exe_br_flg) begin // @[Mux.scala 98:16]
      if_reg_pc <= exe_br_target;
    end else if (exe_jmp_flg) begin // @[Mux.scala 98:16]
      if (_exe_alu_out_T) begin // @[Mux.scala 98:16]
        if_reg_pc <= _exe_alu_out_T_2;
      end else begin
        if_reg_pc <= _exe_alu_out_T_46;
      end
    end else if (_if_pc_next_T_1) begin // @[Mux.scala 98:16]
      if_reg_pc <= csr_trap_vector;
    end else begin
      if_reg_pc <= _if_pc_next_T_4;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"addr: %x, valid: %d\n",io_imem_addr,io_imem_valid); // @[Core.scala 106:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"if_reg_pc        : 0x%x\n",if_reg_pc); // @[Core.scala 400:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_reg_pc        : 0x%x\n",id_reg_pc); // @[Core.scala 401:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_reg_inst      : 0x%x\n",id_reg_inst); // @[Core.scala 402:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"stall_flg        : 0x%x\n",stall_flg); // @[Core.scala 403:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_inst          : 0x%x\n",id_inst); // @[Core.scala 404:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_rs1_data      : 0x%x\n",id_rs1_data); // @[Core.scala 405:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_rs2_data      : 0x%x\n",id_rs2_data); // @[Core.scala 406:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"exe_reg_pc       : 0x%x\n",exe_reg_pc); // @[Core.scala 407:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"exe_reg_op1_data : 0x%x\n",exe_reg_op1_data); // @[Core.scala 408:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"exe_reg_op2_data : 0x%x\n",exe_reg_op2_data); // @[Core.scala 409:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"exe_alu_out      : 0x%x\n",exe_alu_out); // @[Core.scala 410:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"mem_reg_pc       : 0x%x\n",mem_reg_pc); // @[Core.scala 411:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"mem_wb_data      : 0x%x\n",mem_wb_data); // @[Core.scala 412:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"mem_reg_mem_w    : 0x%x\n",mem_reg_mem_w); // @[Core.scala 413:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"mem_reg_wb_addr  : 0x%x\n",mem_reg_wb_addr); // @[Core.scala 414:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"wb_reg_wb_addr   : 0x%x\n",wb_reg_wb_addr); // @[Core.scala 415:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"wb_reg_wb_data   : 0x%x\n",wb_reg_wb_data); // @[Core.scala 416:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"---------\n"); // @[Core.scala 417:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regfile[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  csr_trap_vector = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  id_reg_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  id_reg_inst = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  exe_reg_pc = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  exe_reg_wb_addr = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  exe_reg_op1_data = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  exe_reg_op2_data = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  exe_reg_rs2_data = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  exe_reg_exe_fun = _RAND_9[4:0];
  _RAND_10 = {1{`RANDOM}};
  exe_reg_mem_wen = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  exe_reg_rf_wen = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  exe_reg_wb_sel = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  exe_reg_csr_addr = _RAND_13[11:0];
  _RAND_14 = {1{`RANDOM}};
  exe_reg_csr_cmd = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  exe_reg_imm_b_sext = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  exe_reg_mem_w = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  exe_is_ecall = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  mem_reg_pc = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mem_reg_wb_addr = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  mem_reg_op1_data = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  mem_reg_rs2_data = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  mem_reg_mem_wen = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  mem_reg_rf_wen = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  mem_reg_wb_sel = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  mem_reg_csr_addr = _RAND_25[11:0];
  _RAND_26 = {1{`RANDOM}};
  mem_reg_csr_cmd = _RAND_26[2:0];
  _RAND_27 = {1{`RANDOM}};
  mem_reg_alu_out = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  mem_reg_mem_w = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  mem_reg_mem_wstrb = _RAND_29[3:0];
  _RAND_30 = {1{`RANDOM}};
  wb_reg_wb_addr = _RAND_30[4:0];
  _RAND_31 = {1{`RANDOM}};
  wb_reg_rf_wen = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  wb_reg_wb_data = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  if_reg_pc = _RAND_33[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Memory(
  input         clock,
  input         reset,
  input  [31:0] io_imem_addr,
  output [31:0] io_imem_inst,
  output        io_imem_valid,
  input  [31:0] io_dmem_raddr,
  output [31:0] io_dmem_rdata,
  input         io_dmem_ren,
  output        io_dmem_rvalid,
  input  [31:0] io_dmem_waddr,
  input         io_dmem_wen,
  input  [3:0]  io_dmem_wstrb,
  input  [31:0] io_dmem_wdata,
  output [8:0]  io_imemReadPort_address,
  input  [31:0] io_imemReadPort_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] dataMem_0 [0:127]; // @[Memory.scala 53:20]
  wire [7:0] dataMem_0_rdata_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_0_rdata_MPORT_addr; // @[Memory.scala 53:20]
  wire [7:0] dataMem_0_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_0_MPORT_addr; // @[Memory.scala 53:20]
  wire  dataMem_0_MPORT_mask; // @[Memory.scala 53:20]
  wire  dataMem_0_MPORT_en; // @[Memory.scala 53:20]
  reg [7:0] dataMem_1 [0:127]; // @[Memory.scala 53:20]
  wire [7:0] dataMem_1_rdata_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_1_rdata_MPORT_addr; // @[Memory.scala 53:20]
  wire [7:0] dataMem_1_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_1_MPORT_addr; // @[Memory.scala 53:20]
  wire  dataMem_1_MPORT_mask; // @[Memory.scala 53:20]
  wire  dataMem_1_MPORT_en; // @[Memory.scala 53:20]
  reg [7:0] dataMem_2 [0:127]; // @[Memory.scala 53:20]
  wire [7:0] dataMem_2_rdata_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_2_rdata_MPORT_addr; // @[Memory.scala 53:20]
  wire [7:0] dataMem_2_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_2_MPORT_addr; // @[Memory.scala 53:20]
  wire  dataMem_2_MPORT_mask; // @[Memory.scala 53:20]
  wire  dataMem_2_MPORT_en; // @[Memory.scala 53:20]
  reg [7:0] dataMem_3 [0:127]; // @[Memory.scala 53:20]
  wire [7:0] dataMem_3_rdata_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_3_rdata_MPORT_addr; // @[Memory.scala 53:20]
  wire [7:0] dataMem_3_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_3_MPORT_addr; // @[Memory.scala 53:20]
  wire  dataMem_3_MPORT_mask; // @[Memory.scala 53:20]
  wire  dataMem_3_MPORT_en; // @[Memory.scala 53:20]
  reg  instIsFirst; // @[Memory.scala 37:28]
  wire [29:0] instAddr = io_imem_addr[31:2]; // @[Memory.scala 38:30]
  reg [29:0] instFetchedAddr; // @[Memory.scala 40:32]
  wire  instValid = instFetchedAddr == instAddr & ~instIsFirst; // @[Memory.scala 42:48]
  wire [29:0] _instFetchingAddr_T_1 = instFetchedAddr + 30'h1; // @[Memory.scala 47:54]
  wire [29:0] instFetchingAddr = instValid ? _instFetchingAddr_T_1 : instAddr; // @[Memory.scala 47:26]
  reg [31:0] rdata; // @[Memory.scala 58:22]
  reg  rvalid; // @[Memory.scala 59:23]
  wire  _T = ~io_dmem_wen; // @[Memory.scala 64:9]
  wire  _T_1 = ~io_dmem_wen & io_dmem_ren; // @[Memory.scala 64:22]
  wire [31:0] _rdata_T_2 = {dataMem_3_rdata_MPORT_data,dataMem_2_rdata_MPORT_data,dataMem_1_rdata_MPORT_data,
    dataMem_0_rdata_MPORT_data}; // @[Cat.scala 30:58]
  assign dataMem_0_rdata_MPORT_addr = io_dmem_raddr[8:2];
  assign dataMem_0_rdata_MPORT_data = dataMem_0[dataMem_0_rdata_MPORT_addr]; // @[Memory.scala 53:20]
  assign dataMem_0_MPORT_data = io_dmem_wdata[7:0];
  assign dataMem_0_MPORT_addr = io_dmem_waddr[8:2];
  assign dataMem_0_MPORT_mask = io_dmem_wstrb[0];
  assign dataMem_0_MPORT_en = io_dmem_wen;
  assign dataMem_1_rdata_MPORT_addr = io_dmem_raddr[8:2];
  assign dataMem_1_rdata_MPORT_data = dataMem_1[dataMem_1_rdata_MPORT_addr]; // @[Memory.scala 53:20]
  assign dataMem_1_MPORT_data = io_dmem_wdata[15:8];
  assign dataMem_1_MPORT_addr = io_dmem_waddr[8:2];
  assign dataMem_1_MPORT_mask = io_dmem_wstrb[1];
  assign dataMem_1_MPORT_en = io_dmem_wen;
  assign dataMem_2_rdata_MPORT_addr = io_dmem_raddr[8:2];
  assign dataMem_2_rdata_MPORT_data = dataMem_2[dataMem_2_rdata_MPORT_addr]; // @[Memory.scala 53:20]
  assign dataMem_2_MPORT_data = io_dmem_wdata[23:16];
  assign dataMem_2_MPORT_addr = io_dmem_waddr[8:2];
  assign dataMem_2_MPORT_mask = io_dmem_wstrb[2];
  assign dataMem_2_MPORT_en = io_dmem_wen;
  assign dataMem_3_rdata_MPORT_addr = io_dmem_raddr[8:2];
  assign dataMem_3_rdata_MPORT_data = dataMem_3[dataMem_3_rdata_MPORT_addr]; // @[Memory.scala 53:20]
  assign dataMem_3_MPORT_data = io_dmem_wdata[31:24];
  assign dataMem_3_MPORT_addr = io_dmem_waddr[8:2];
  assign dataMem_3_MPORT_mask = io_dmem_wstrb[3];
  assign dataMem_3_MPORT_en = io_dmem_wen;
  assign io_imem_inst = io_imemReadPort_data; // @[Memory.scala 39:22 Memory.scala 48:12]
  assign io_imem_valid = instFetchedAddr == instAddr & ~instIsFirst; // @[Memory.scala 42:48]
  assign io_dmem_rdata = rdata; // @[Memory.scala 60:17]
  assign io_dmem_rvalid = rvalid; // @[Memory.scala 61:18]
  assign io_imemReadPort_address = instFetchingAddr[8:0]; // @[Memory.scala 50:27]
  always @(posedge clock) begin
    if(dataMem_0_MPORT_en & dataMem_0_MPORT_mask) begin
      dataMem_0[dataMem_0_MPORT_addr] <= dataMem_0_MPORT_data; // @[Memory.scala 53:20]
    end
    if(dataMem_1_MPORT_en & dataMem_1_MPORT_mask) begin
      dataMem_1[dataMem_1_MPORT_addr] <= dataMem_1_MPORT_data; // @[Memory.scala 53:20]
    end
    if(dataMem_2_MPORT_en & dataMem_2_MPORT_mask) begin
      dataMem_2[dataMem_2_MPORT_addr] <= dataMem_2_MPORT_data; // @[Memory.scala 53:20]
    end
    if(dataMem_3_MPORT_en & dataMem_3_MPORT_mask) begin
      dataMem_3[dataMem_3_MPORT_addr] <= dataMem_3_MPORT_data; // @[Memory.scala 53:20]
    end
    instIsFirst <= reset; // @[Memory.scala 37:28 Memory.scala 37:28 Memory.scala 44:15]
    if (reset) begin // @[Memory.scala 40:32]
      instFetchedAddr <= 30'h0; // @[Memory.scala 40:32]
    end else if (instValid) begin // @[Memory.scala 47:26]
      instFetchedAddr <= _instFetchingAddr_T_1;
    end else begin
      instFetchedAddr <= instAddr;
    end
    if (reset) begin // @[Memory.scala 58:22]
      rdata <= 32'h0; // @[Memory.scala 58:22]
    end else if (~io_dmem_wen & io_dmem_ren) begin // @[Memory.scala 64:39]
      rdata <= _rdata_T_2; // @[Memory.scala 65:11]
    end
    if (reset) begin // @[Memory.scala 59:23]
      rvalid <= 1'h0; // @[Memory.scala 59:23]
    end else begin
      rvalid <= _T_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    dataMem_0[initvar] = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    dataMem_1[initvar] = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    dataMem_2[initvar] = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    dataMem_3[initvar] = _RAND_3[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  instIsFirst = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  instFetchedAddr = _RAND_5[29:0];
  _RAND_6 = {1{`RANDOM}};
  rdata = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  rvalid = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SingleCycleMem(
  input         clock,
  input         reset,
  input  [31:0] io_mem_raddr,
  output [31:0] io_mem_rdata,
  input         io_mem_ren,
  output        io_mem_rvalid,
  input  [31:0] io_mem_waddr,
  input         io_mem_wen,
  input  [31:0] io_mem_wdata,
  output [8:0]  io_read_address,
  input  [31:0] io_read_data,
  output        io_read_enable,
  output [8:0]  io_write_address,
  output [31:0] io_write_data,
  output        io_write_enable
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  io_mem_rvalid_REG; // @[SingleCycleMem.scala 18:27]
  assign io_mem_rdata = io_read_data; // @[SingleCycleMem.scala 17:16]
  assign io_mem_rvalid = io_mem_rvalid_REG; // @[SingleCycleMem.scala 18:17]
  assign io_read_address = io_mem_raddr[8:0]; // @[SingleCycleMem.scala 15:19]
  assign io_read_enable = io_mem_ren; // @[SingleCycleMem.scala 16:18]
  assign io_write_address = io_mem_waddr[8:0]; // @[SingleCycleMem.scala 20:20]
  assign io_write_data = io_mem_wdata; // @[SingleCycleMem.scala 22:17]
  assign io_write_enable = io_mem_wen; // @[SingleCycleMem.scala 21:19]
  always @(posedge clock) begin
    if (reset) begin // @[SingleCycleMem.scala 18:27]
      io_mem_rvalid_REG <= 1'h0; // @[SingleCycleMem.scala 18:27]
    end else begin
      io_mem_rvalid_REG <= io_mem_ren; // @[SingleCycleMem.scala 18:27]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_mem_rvalid_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Gpio(
  input         clock,
  input         reset,
  input         io_mem_wen,
  input  [31:0] io_mem_wdata,
  output [31:0] io_gpio
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] output_; // @[Gpio.scala 14:23]
  assign io_gpio = output_; // @[Gpio.scala 15:11]
  always @(posedge clock) begin
    if (reset) begin // @[Gpio.scala 14:23]
      output_ <= 32'h0; // @[Gpio.scala 14:23]
    end else if (io_mem_wen) begin // @[Gpio.scala 20:20]
      output_ <= io_mem_wdata; // @[Gpio.scala 21:12]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  output_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module UartTx(
  input        clock,
  input        reset,
  output       io_in_ready,
  input        io_in_valid,
  input  [7:0] io_in_bits,
  output       io_tx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] rateCounter; // @[Uart.scala 12:30]
  reg [3:0] bitCounter; // @[Uart.scala 13:29]
  reg  bits_0; // @[Uart.scala 14:19]
  reg  bits_1; // @[Uart.scala 14:19]
  reg  bits_2; // @[Uart.scala 14:19]
  reg  bits_3; // @[Uart.scala 14:19]
  reg  bits_4; // @[Uart.scala 14:19]
  reg  bits_5; // @[Uart.scala 14:19]
  reg  bits_6; // @[Uart.scala 14:19]
  reg  bits_7; // @[Uart.scala 14:19]
  reg  bits_8; // @[Uart.scala 14:19]
  reg  bits_9; // @[Uart.scala 14:19]
  wire [9:0] _T_1 = {1'h1,io_in_bits,1'h0}; // @[Cat.scala 30:58]
  wire  _GEN_0 = io_in_valid & io_in_ready ? _T_1[0] : bits_0; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire  _GEN_1 = io_in_valid & io_in_ready ? _T_1[1] : bits_1; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire  _GEN_2 = io_in_valid & io_in_ready ? _T_1[2] : bits_2; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire  _GEN_3 = io_in_valid & io_in_ready ? _T_1[3] : bits_3; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire  _GEN_4 = io_in_valid & io_in_ready ? _T_1[4] : bits_4; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire  _GEN_5 = io_in_valid & io_in_ready ? _T_1[5] : bits_5; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire  _GEN_6 = io_in_valid & io_in_ready ? _T_1[6] : bits_6; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire  _GEN_7 = io_in_valid & io_in_ready ? _T_1[7] : bits_7; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire  _GEN_8 = io_in_valid & io_in_ready ? _T_1[8] : bits_8; // @[Uart.scala 19:38 Uart.scala 20:14 Uart.scala 14:19]
  wire [3:0] _GEN_10 = io_in_valid & io_in_ready ? 4'ha : bitCounter; // @[Uart.scala 19:38 Uart.scala 21:20 Uart.scala 13:29]
  wire [3:0] _bitCounter_T_1 = bitCounter - 4'h1; // @[Uart.scala 29:38]
  wire [9:0] _rateCounter_T_1 = rateCounter - 10'h1; // @[Uart.scala 32:40]
  assign io_in_ready = bitCounter == 4'h0; // @[Uart.scala 17:31]
  assign io_tx = bitCounter == 4'h0 | bits_0; // @[Uart.scala 16:33]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 12:30]
      rateCounter <= 10'h0; // @[Uart.scala 12:30]
    end else if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        rateCounter <= 10'h2b5; // @[Uart.scala 30:25]
      end else begin
        rateCounter <= _rateCounter_T_1; // @[Uart.scala 32:25]
      end
    end else if (io_in_valid & io_in_ready) begin // @[Uart.scala 19:38]
      rateCounter <= 10'h2b5; // @[Uart.scala 22:21]
    end
    if (reset) begin // @[Uart.scala 13:29]
      bitCounter <= 4'h0; // @[Uart.scala 13:29]
    end else if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bitCounter <= _bitCounter_T_1; // @[Uart.scala 29:24]
      end else begin
        bitCounter <= _GEN_10;
      end
    end else begin
      bitCounter <= _GEN_10;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_0 <= bits_1; // @[Uart.scala 28:54]
      end else begin
        bits_0 <= _GEN_0;
      end
    end else begin
      bits_0 <= _GEN_0;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_1 <= bits_2; // @[Uart.scala 28:54]
      end else begin
        bits_1 <= _GEN_1;
      end
    end else begin
      bits_1 <= _GEN_1;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_2 <= bits_3; // @[Uart.scala 28:54]
      end else begin
        bits_2 <= _GEN_2;
      end
    end else begin
      bits_2 <= _GEN_2;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_3 <= bits_4; // @[Uart.scala 28:54]
      end else begin
        bits_3 <= _GEN_3;
      end
    end else begin
      bits_3 <= _GEN_3;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_4 <= bits_5; // @[Uart.scala 28:54]
      end else begin
        bits_4 <= _GEN_4;
      end
    end else begin
      bits_4 <= _GEN_4;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_5 <= bits_6; // @[Uart.scala 28:54]
      end else begin
        bits_5 <= _GEN_5;
      end
    end else begin
      bits_5 <= _GEN_5;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_6 <= bits_7; // @[Uart.scala 28:54]
      end else begin
        bits_6 <= _GEN_6;
      end
    end else begin
      bits_6 <= _GEN_6;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_7 <= bits_8; // @[Uart.scala 28:54]
      end else begin
        bits_7 <= _GEN_7;
      end
    end else begin
      bits_7 <= _GEN_7;
    end
    if (bitCounter > 4'h0) begin // @[Uart.scala 25:30]
      if (rateCounter == 10'h0) begin // @[Uart.scala 26:35]
        bits_8 <= bits_9; // @[Uart.scala 28:54]
      end else begin
        bits_8 <= _GEN_8;
      end
    end else begin
      bits_8 <= _GEN_8;
    end
    if (io_in_valid & io_in_ready) begin // @[Uart.scala 19:38]
      bits_9 <= _T_1[9]; // @[Uart.scala 20:14]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rateCounter = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  bitCounter = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  bits_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  bits_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  bits_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  bits_3 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  bits_4 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  bits_5 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  bits_6 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  bits_7 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  bits_8 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  bits_9 = _RAND_11[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Uart(
  input         clock,
  input         reset,
  output [31:0] io_mem_rdata,
  input         io_mem_wen,
  input  [31:0] io_mem_wdata,
  output        io_tx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  tx_clock; // @[Uart.scala 99:18]
  wire  tx_reset; // @[Uart.scala 99:18]
  wire  tx_io_in_ready; // @[Uart.scala 99:18]
  wire  tx_io_in_valid; // @[Uart.scala 99:18]
  wire [7:0] tx_io_in_bits; // @[Uart.scala 99:18]
  wire  tx_io_tx; // @[Uart.scala 99:18]
  reg  txValid; // @[Uart.scala 100:24]
  reg [7:0] txData; // @[Uart.scala 102:23]
  wire  txReady = tx_io_in_ready;
  wire  _GEN_0 = txValid & txReady ? 1'h0 : txValid; // @[Uart.scala 106:28 Uart.scala 107:13 Uart.scala 100:24]
  wire  _GEN_1 = ~txValid | _GEN_0; // @[Uart.scala 114:22 Uart.scala 115:15]
  wire [31:0] _GEN_2 = ~txValid ? io_mem_wdata : {{24'd0}, txData}; // @[Uart.scala 114:22 Uart.scala 116:14 Uart.scala 102:23]
  wire [31:0] _GEN_4 = io_mem_wen ? _GEN_2 : {{24'd0}, txData}; // @[Uart.scala 113:20 Uart.scala 102:23]
  UartTx tx ( // @[Uart.scala 99:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_in_ready(tx_io_in_ready),
    .io_in_valid(tx_io_in_valid),
    .io_in_bits(tx_io_in_bits),
    .io_tx(tx_io_tx)
  );
  assign io_mem_rdata = {31'h0,txValid}; // @[Cat.scala 30:58]
  assign io_tx = tx_io_tx; // @[Uart.scala 120:9]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_in_valid = txValid; // @[Uart.scala 103:18]
  assign tx_io_in_bits = txData; // @[Uart.scala 104:17]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 100:24]
      txValid <= 1'h0; // @[Uart.scala 100:24]
    end else if (io_mem_wen) begin // @[Uart.scala 113:20]
      txValid <= _GEN_1;
    end else if (txValid & txReady) begin // @[Uart.scala 106:28]
      txValid <= 1'h0; // @[Uart.scala 107:13]
    end
    if (reset) begin // @[Uart.scala 102:23]
      txData <= 8'h0; // @[Uart.scala 102:23]
    end else begin
      txData <= _GEN_4[7:0];
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  txValid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  txData = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Config(
  input  [31:0] io_mem_raddr,
  output [31:0] io_mem_rdata
);
  wire [26:0] _io_mem_rdata_T_2 = io_mem_raddr[2] ? 27'h4c4b400 : 27'h1234567; // @[Mux.scala 80:57]
  assign io_mem_rdata = {{5'd0}, _io_mem_rdata_T_2}; // @[Mux.scala 80:57]
endmodule
module DMemDecoder(
  input  [31:0] io_initiator_raddr,
  output [31:0] io_initiator_rdata,
  input         io_initiator_ren,
  output        io_initiator_rvalid,
  input  [31:0] io_initiator_waddr,
  input         io_initiator_wen,
  output        io_initiator_wready,
  input  [3:0]  io_initiator_wstrb,
  input  [31:0] io_initiator_wdata,
  output [31:0] io_targets_0_raddr,
  input  [31:0] io_targets_0_rdata,
  output        io_targets_0_ren,
  input         io_targets_0_rvalid,
  output [31:0] io_targets_0_waddr,
  output        io_targets_0_wen,
  output [31:0] io_targets_0_wdata,
  output [31:0] io_targets_1_raddr,
  input  [31:0] io_targets_1_rdata,
  output        io_targets_1_ren,
  input         io_targets_1_rvalid,
  output [31:0] io_targets_1_waddr,
  output        io_targets_1_wen,
  output [3:0]  io_targets_1_wstrb,
  output [31:0] io_targets_1_wdata,
  output        io_targets_2_wen,
  output [31:0] io_targets_2_wdata,
  input  [31:0] io_targets_3_rdata,
  output        io_targets_3_wen,
  output [31:0] io_targets_3_wdata,
  output [31:0] io_targets_4_raddr,
  input  [31:0] io_targets_4_rdata
);
  wire [31:0] _raddr_T_1 = io_initiator_raddr - 32'h8000000; // @[Decoder.scala 40:35]
  wire  _GEN_2 = 32'h8000000 <= io_initiator_raddr & io_initiator_raddr < 32'h8000800 ? io_targets_0_rvalid : 1'h1; // @[Decoder.scala 39:85 Decoder.scala 42:14]
  wire [31:0] _GEN_3 = 32'h8000000 <= io_initiator_raddr & io_initiator_raddr < 32'h8000800 ? io_targets_0_rdata : 32'hdeadbeef
    ; // @[Decoder.scala 39:85 Decoder.scala 43:13]
  wire [31:0] _waddr_T_1 = io_initiator_waddr - 32'h8000000; // @[Decoder.scala 46:35]
  wire [31:0] _raddr_T_3 = io_initiator_raddr - 32'h20000000; // @[Decoder.scala 40:35]
  wire  _GEN_11 = 32'h20000000 <= io_initiator_raddr & io_initiator_raddr < 32'h20000200 ? io_targets_1_rvalid : _GEN_2; // @[Decoder.scala 39:85 Decoder.scala 42:14]
  wire [31:0] _GEN_12 = 32'h20000000 <= io_initiator_raddr & io_initiator_raddr < 32'h20000200 ? io_targets_1_rdata :
    _GEN_3; // @[Decoder.scala 39:85 Decoder.scala 43:13]
  wire [31:0] _waddr_T_3 = io_initiator_waddr - 32'h20000000; // @[Decoder.scala 46:35]
  wire [31:0] _GEN_21 = 32'h30000000 <= io_initiator_raddr & io_initiator_raddr < 32'h30000040 ? 32'hdeadbeef : _GEN_12; // @[Decoder.scala 39:85 Decoder.scala 43:13]
  wire [31:0] _GEN_30 = 32'h30001000 <= io_initiator_raddr & io_initiator_raddr < 32'h30001040 ? io_targets_3_rdata :
    _GEN_21; // @[Decoder.scala 39:85 Decoder.scala 43:13]
  wire [31:0] _raddr_T_9 = io_initiator_raddr - 32'h40000000; // @[Decoder.scala 40:35]
  assign io_initiator_rdata = 32'h40000000 <= io_initiator_raddr & io_initiator_raddr < 32'h40000040 ?
    io_targets_4_rdata : _GEN_30; // @[Decoder.scala 39:85 Decoder.scala 43:13]
  assign io_initiator_rvalid = 32'h40000000 <= io_initiator_raddr & io_initiator_raddr < 32'h40000040 | (32'h30001000
     <= io_initiator_raddr & io_initiator_raddr < 32'h30001040 | (32'h30000000 <= io_initiator_raddr &
    io_initiator_raddr < 32'h30000040 | _GEN_11)); // @[Decoder.scala 39:85 Decoder.scala 42:14]
  assign io_initiator_wready = 32'h40000000 <= io_initiator_waddr & io_initiator_waddr < 32'h40000040 | (32'h30001000
     <= io_initiator_waddr & io_initiator_waddr < 32'h30001040 | (32'h30000000 <= io_initiator_waddr &
    io_initiator_waddr < 32'h30000040 | (32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 | 32'h8000000
     <= io_initiator_waddr & io_initiator_waddr < 32'h8000800))); // @[Decoder.scala 45:85 Decoder.scala 50:14]
  assign io_targets_0_raddr = 32'h8000000 <= io_initiator_raddr & io_initiator_raddr < 32'h8000800 ? _raddr_T_1 : 32'h0; // @[Decoder.scala 39:85 Decoder.scala 40:13]
  assign io_targets_0_ren = 32'h8000000 <= io_initiator_raddr & io_initiator_raddr < 32'h8000800 & io_initiator_ren; // @[Decoder.scala 39:85 Decoder.scala 41:11]
  assign io_targets_0_waddr = 32'h8000000 <= io_initiator_waddr & io_initiator_waddr < 32'h8000800 ? _waddr_T_1 : 32'h0; // @[Decoder.scala 45:85 Decoder.scala 46:13]
  assign io_targets_0_wen = 32'h8000000 <= io_initiator_waddr & io_initiator_waddr < 32'h8000800 & io_initiator_wen; // @[Decoder.scala 45:85 Decoder.scala 47:11]
  assign io_targets_0_wdata = 32'h8000000 <= io_initiator_waddr & io_initiator_waddr < 32'h8000800 ? io_initiator_wdata
     : 32'hdeadbeef; // @[Decoder.scala 45:85 Decoder.scala 48:13]
  assign io_targets_1_raddr = 32'h20000000 <= io_initiator_raddr & io_initiator_raddr < 32'h20000200 ? _raddr_T_3 : 32'h0
    ; // @[Decoder.scala 39:85 Decoder.scala 40:13]
  assign io_targets_1_ren = 32'h20000000 <= io_initiator_raddr & io_initiator_raddr < 32'h20000200 & io_initiator_ren; // @[Decoder.scala 39:85 Decoder.scala 41:11]
  assign io_targets_1_waddr = 32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 ? _waddr_T_3 : 32'h0
    ; // @[Decoder.scala 45:85 Decoder.scala 46:13]
  assign io_targets_1_wen = 32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 & io_initiator_wen; // @[Decoder.scala 45:85 Decoder.scala 47:11]
  assign io_targets_1_wstrb = 32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 ?
    io_initiator_wstrb : 4'hf; // @[Decoder.scala 45:85 Decoder.scala 49:13]
  assign io_targets_1_wdata = 32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 ?
    io_initiator_wdata : 32'hdeadbeef; // @[Decoder.scala 45:85 Decoder.scala 48:13]
  assign io_targets_2_wen = 32'h30000000 <= io_initiator_waddr & io_initiator_waddr < 32'h30000040 & io_initiator_wen; // @[Decoder.scala 45:85 Decoder.scala 47:11]
  assign io_targets_2_wdata = 32'h30000000 <= io_initiator_waddr & io_initiator_waddr < 32'h30000040 ?
    io_initiator_wdata : 32'hdeadbeef; // @[Decoder.scala 45:85 Decoder.scala 48:13]
  assign io_targets_3_wen = 32'h30001000 <= io_initiator_waddr & io_initiator_waddr < 32'h30001040 & io_initiator_wen; // @[Decoder.scala 45:85 Decoder.scala 47:11]
  assign io_targets_3_wdata = 32'h30001000 <= io_initiator_waddr & io_initiator_waddr < 32'h30001040 ?
    io_initiator_wdata : 32'hdeadbeef; // @[Decoder.scala 45:85 Decoder.scala 48:13]
  assign io_targets_4_raddr = 32'h40000000 <= io_initiator_raddr & io_initiator_raddr < 32'h40000040 ? _raddr_T_9 : 32'h0
    ; // @[Decoder.scala 39:85 Decoder.scala 40:13]
endmodule
module RiscV(
  input         clock,
  input         reset,
  output [7:0]  io_gpio,
  output        io_uart_tx,
  output        io_exit,
  output [8:0]  io_imem_address,
  input  [31:0] io_imem_data,
  output        io_imem_enable,
  output [8:0]  io_imemRead_address,
  input  [31:0] io_imemRead_data,
  output        io_imemRead_enable,
  output [8:0]  io_imemWrite_address,
  output [31:0] io_imemWrite_data,
  output        io_imemWrite_enable,
  output [31:0] io_debugSignals_core_mem_reg_pc,
  output [31:0] io_debugSignals_core_csr_rdata,
  output [31:0] io_debugSignals_core_mem_reg_csr_addr,
  output [63:0] io_debugSignals_core_cycle_counter,
  output [31:0] io_debugSignals_raddr,
  output [31:0] io_debugSignals_rdata,
  output        io_debugSignals_ren,
  output        io_debugSignals_rvalid,
  output [31:0] io_debugSignals_waddr,
  output        io_debugSignals_wen,
  output        io_debugSignals_wready,
  output [3:0]  io_debugSignals_wstrb,
  output [31:0] io_debugSignals_wdata
);
  wire  core_clock; // @[Top.scala 51:20]
  wire  core_reset; // @[Top.scala 51:20]
  wire [31:0] core_io_imem_addr; // @[Top.scala 51:20]
  wire [31:0] core_io_imem_inst; // @[Top.scala 51:20]
  wire  core_io_imem_valid; // @[Top.scala 51:20]
  wire [31:0] core_io_dmem_raddr; // @[Top.scala 51:20]
  wire [31:0] core_io_dmem_rdata; // @[Top.scala 51:20]
  wire  core_io_dmem_ren; // @[Top.scala 51:20]
  wire  core_io_dmem_rvalid; // @[Top.scala 51:20]
  wire [31:0] core_io_dmem_waddr; // @[Top.scala 51:20]
  wire  core_io_dmem_wen; // @[Top.scala 51:20]
  wire [3:0] core_io_dmem_wstrb; // @[Top.scala 51:20]
  wire [31:0] core_io_dmem_wdata; // @[Top.scala 51:20]
  wire  core_io_exit; // @[Top.scala 51:20]
  wire [31:0] core_io_debug_signal_mem_reg_pc; // @[Top.scala 51:20]
  wire [31:0] core_io_debug_signal_csr_rdata; // @[Top.scala 51:20]
  wire [31:0] core_io_debug_signal_mem_reg_csr_addr; // @[Top.scala 51:20]
  wire [63:0] core_io_debug_signal_cycle_counter; // @[Top.scala 51:20]
  wire  memory_clock; // @[Top.scala 53:22]
  wire  memory_reset; // @[Top.scala 53:22]
  wire [31:0] memory_io_imem_addr; // @[Top.scala 53:22]
  wire [31:0] memory_io_imem_inst; // @[Top.scala 53:22]
  wire  memory_io_imem_valid; // @[Top.scala 53:22]
  wire [31:0] memory_io_dmem_raddr; // @[Top.scala 53:22]
  wire [31:0] memory_io_dmem_rdata; // @[Top.scala 53:22]
  wire  memory_io_dmem_ren; // @[Top.scala 53:22]
  wire  memory_io_dmem_rvalid; // @[Top.scala 53:22]
  wire [31:0] memory_io_dmem_waddr; // @[Top.scala 53:22]
  wire  memory_io_dmem_wen; // @[Top.scala 53:22]
  wire [3:0] memory_io_dmem_wstrb; // @[Top.scala 53:22]
  wire [31:0] memory_io_dmem_wdata; // @[Top.scala 53:22]
  wire [8:0] memory_io_imemReadPort_address; // @[Top.scala 53:22]
  wire [31:0] memory_io_imemReadPort_data; // @[Top.scala 53:22]
  wire  imem_dbus_clock; // @[Top.scala 54:25]
  wire  imem_dbus_reset; // @[Top.scala 54:25]
  wire [31:0] imem_dbus_io_mem_raddr; // @[Top.scala 54:25]
  wire [31:0] imem_dbus_io_mem_rdata; // @[Top.scala 54:25]
  wire  imem_dbus_io_mem_ren; // @[Top.scala 54:25]
  wire  imem_dbus_io_mem_rvalid; // @[Top.scala 54:25]
  wire [31:0] imem_dbus_io_mem_waddr; // @[Top.scala 54:25]
  wire  imem_dbus_io_mem_wen; // @[Top.scala 54:25]
  wire [31:0] imem_dbus_io_mem_wdata; // @[Top.scala 54:25]
  wire [8:0] imem_dbus_io_read_address; // @[Top.scala 54:25]
  wire [31:0] imem_dbus_io_read_data; // @[Top.scala 54:25]
  wire  imem_dbus_io_read_enable; // @[Top.scala 54:25]
  wire [8:0] imem_dbus_io_write_address; // @[Top.scala 54:25]
  wire [31:0] imem_dbus_io_write_data; // @[Top.scala 54:25]
  wire  imem_dbus_io_write_enable; // @[Top.scala 54:25]
  wire  gpio_clock; // @[Top.scala 55:20]
  wire  gpio_reset; // @[Top.scala 55:20]
  wire  gpio_io_mem_wen; // @[Top.scala 55:20]
  wire [31:0] gpio_io_mem_wdata; // @[Top.scala 55:20]
  wire [31:0] gpio_io_gpio; // @[Top.scala 55:20]
  wire  uart_clock; // @[Top.scala 56:20]
  wire  uart_reset; // @[Top.scala 56:20]
  wire [31:0] uart_io_mem_rdata; // @[Top.scala 56:20]
  wire  uart_io_mem_wen; // @[Top.scala 56:20]
  wire [31:0] uart_io_mem_wdata; // @[Top.scala 56:20]
  wire  uart_io_tx; // @[Top.scala 56:20]
  wire [31:0] config__io_mem_raddr; // @[Top.scala 57:22]
  wire [31:0] config__io_mem_rdata; // @[Top.scala 57:22]
  wire [31:0] decoder_io_initiator_raddr; // @[Top.scala 59:23]
  wire [31:0] decoder_io_initiator_rdata; // @[Top.scala 59:23]
  wire  decoder_io_initiator_ren; // @[Top.scala 59:23]
  wire  decoder_io_initiator_rvalid; // @[Top.scala 59:23]
  wire [31:0] decoder_io_initiator_waddr; // @[Top.scala 59:23]
  wire  decoder_io_initiator_wen; // @[Top.scala 59:23]
  wire  decoder_io_initiator_wready; // @[Top.scala 59:23]
  wire [3:0] decoder_io_initiator_wstrb; // @[Top.scala 59:23]
  wire [31:0] decoder_io_initiator_wdata; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_0_raddr; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_0_rdata; // @[Top.scala 59:23]
  wire  decoder_io_targets_0_ren; // @[Top.scala 59:23]
  wire  decoder_io_targets_0_rvalid; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_0_waddr; // @[Top.scala 59:23]
  wire  decoder_io_targets_0_wen; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_0_wdata; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_1_raddr; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_1_rdata; // @[Top.scala 59:23]
  wire  decoder_io_targets_1_ren; // @[Top.scala 59:23]
  wire  decoder_io_targets_1_rvalid; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_1_waddr; // @[Top.scala 59:23]
  wire  decoder_io_targets_1_wen; // @[Top.scala 59:23]
  wire [3:0] decoder_io_targets_1_wstrb; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_1_wdata; // @[Top.scala 59:23]
  wire  decoder_io_targets_2_wen; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_2_wdata; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_3_rdata; // @[Top.scala 59:23]
  wire  decoder_io_targets_3_wen; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_3_wdata; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_4_raddr; // @[Top.scala 59:23]
  wire [31:0] decoder_io_targets_4_rdata; // @[Top.scala 59:23]
  Core core ( // @[Top.scala 51:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_imem_addr(core_io_imem_addr),
    .io_imem_inst(core_io_imem_inst),
    .io_imem_valid(core_io_imem_valid),
    .io_dmem_raddr(core_io_dmem_raddr),
    .io_dmem_rdata(core_io_dmem_rdata),
    .io_dmem_ren(core_io_dmem_ren),
    .io_dmem_rvalid(core_io_dmem_rvalid),
    .io_dmem_waddr(core_io_dmem_waddr),
    .io_dmem_wen(core_io_dmem_wen),
    .io_dmem_wstrb(core_io_dmem_wstrb),
    .io_dmem_wdata(core_io_dmem_wdata),
    .io_exit(core_io_exit),
    .io_debug_signal_mem_reg_pc(core_io_debug_signal_mem_reg_pc),
    .io_debug_signal_csr_rdata(core_io_debug_signal_csr_rdata),
    .io_debug_signal_mem_reg_csr_addr(core_io_debug_signal_mem_reg_csr_addr),
    .io_debug_signal_cycle_counter(core_io_debug_signal_cycle_counter)
  );
  Memory memory ( // @[Top.scala 53:22]
    .clock(memory_clock),
    .reset(memory_reset),
    .io_imem_addr(memory_io_imem_addr),
    .io_imem_inst(memory_io_imem_inst),
    .io_imem_valid(memory_io_imem_valid),
    .io_dmem_raddr(memory_io_dmem_raddr),
    .io_dmem_rdata(memory_io_dmem_rdata),
    .io_dmem_ren(memory_io_dmem_ren),
    .io_dmem_rvalid(memory_io_dmem_rvalid),
    .io_dmem_waddr(memory_io_dmem_waddr),
    .io_dmem_wen(memory_io_dmem_wen),
    .io_dmem_wstrb(memory_io_dmem_wstrb),
    .io_dmem_wdata(memory_io_dmem_wdata),
    .io_imemReadPort_address(memory_io_imemReadPort_address),
    .io_imemReadPort_data(memory_io_imemReadPort_data)
  );
  SingleCycleMem imem_dbus ( // @[Top.scala 54:25]
    .clock(imem_dbus_clock),
    .reset(imem_dbus_reset),
    .io_mem_raddr(imem_dbus_io_mem_raddr),
    .io_mem_rdata(imem_dbus_io_mem_rdata),
    .io_mem_ren(imem_dbus_io_mem_ren),
    .io_mem_rvalid(imem_dbus_io_mem_rvalid),
    .io_mem_waddr(imem_dbus_io_mem_waddr),
    .io_mem_wen(imem_dbus_io_mem_wen),
    .io_mem_wdata(imem_dbus_io_mem_wdata),
    .io_read_address(imem_dbus_io_read_address),
    .io_read_data(imem_dbus_io_read_data),
    .io_read_enable(imem_dbus_io_read_enable),
    .io_write_address(imem_dbus_io_write_address),
    .io_write_data(imem_dbus_io_write_data),
    .io_write_enable(imem_dbus_io_write_enable)
  );
  Gpio gpio ( // @[Top.scala 55:20]
    .clock(gpio_clock),
    .reset(gpio_reset),
    .io_mem_wen(gpio_io_mem_wen),
    .io_mem_wdata(gpio_io_mem_wdata),
    .io_gpio(gpio_io_gpio)
  );
  Uart uart ( // @[Top.scala 56:20]
    .clock(uart_clock),
    .reset(uart_reset),
    .io_mem_rdata(uart_io_mem_rdata),
    .io_mem_wen(uart_io_mem_wen),
    .io_mem_wdata(uart_io_mem_wdata),
    .io_tx(uart_io_tx)
  );
  Config config_ ( // @[Top.scala 57:22]
    .io_mem_raddr(config__io_mem_raddr),
    .io_mem_rdata(config__io_mem_rdata)
  );
  DMemDecoder decoder ( // @[Top.scala 59:23]
    .io_initiator_raddr(decoder_io_initiator_raddr),
    .io_initiator_rdata(decoder_io_initiator_rdata),
    .io_initiator_ren(decoder_io_initiator_ren),
    .io_initiator_rvalid(decoder_io_initiator_rvalid),
    .io_initiator_waddr(decoder_io_initiator_waddr),
    .io_initiator_wen(decoder_io_initiator_wen),
    .io_initiator_wready(decoder_io_initiator_wready),
    .io_initiator_wstrb(decoder_io_initiator_wstrb),
    .io_initiator_wdata(decoder_io_initiator_wdata),
    .io_targets_0_raddr(decoder_io_targets_0_raddr),
    .io_targets_0_rdata(decoder_io_targets_0_rdata),
    .io_targets_0_ren(decoder_io_targets_0_ren),
    .io_targets_0_rvalid(decoder_io_targets_0_rvalid),
    .io_targets_0_waddr(decoder_io_targets_0_waddr),
    .io_targets_0_wen(decoder_io_targets_0_wen),
    .io_targets_0_wdata(decoder_io_targets_0_wdata),
    .io_targets_1_raddr(decoder_io_targets_1_raddr),
    .io_targets_1_rdata(decoder_io_targets_1_rdata),
    .io_targets_1_ren(decoder_io_targets_1_ren),
    .io_targets_1_rvalid(decoder_io_targets_1_rvalid),
    .io_targets_1_waddr(decoder_io_targets_1_waddr),
    .io_targets_1_wen(decoder_io_targets_1_wen),
    .io_targets_1_wstrb(decoder_io_targets_1_wstrb),
    .io_targets_1_wdata(decoder_io_targets_1_wdata),
    .io_targets_2_wen(decoder_io_targets_2_wen),
    .io_targets_2_wdata(decoder_io_targets_2_wdata),
    .io_targets_3_rdata(decoder_io_targets_3_rdata),
    .io_targets_3_wen(decoder_io_targets_3_wen),
    .io_targets_3_wdata(decoder_io_targets_3_wdata),
    .io_targets_4_raddr(decoder_io_targets_4_raddr),
    .io_targets_4_rdata(decoder_io_targets_4_rdata)
  );
  assign io_gpio = gpio_io_gpio[7:0]; // @[Top.scala 92:11]
  assign io_uart_tx = uart_io_tx; // @[Top.scala 93:14]
  assign io_exit = core_io_exit; // @[Top.scala 91:11]
  assign io_imem_address = memory_io_imemReadPort_address; // @[Top.scala 73:26]
  assign io_imem_enable = 1'h1; // @[Top.scala 73:26]
  assign io_imemRead_address = imem_dbus_io_read_address; // @[Top.scala 76:21]
  assign io_imemRead_enable = imem_dbus_io_read_enable; // @[Top.scala 76:21]
  assign io_imemWrite_address = imem_dbus_io_write_address; // @[Top.scala 77:22]
  assign io_imemWrite_data = imem_dbus_io_write_data; // @[Top.scala 77:22]
  assign io_imemWrite_enable = imem_dbus_io_write_enable; // @[Top.scala 77:22]
  assign io_debugSignals_core_mem_reg_pc = core_io_debug_signal_mem_reg_pc; // @[Top.scala 80:24]
  assign io_debugSignals_core_csr_rdata = core_io_debug_signal_csr_rdata; // @[Top.scala 80:24]
  assign io_debugSignals_core_mem_reg_csr_addr = core_io_debug_signal_mem_reg_csr_addr; // @[Top.scala 80:24]
  assign io_debugSignals_core_cycle_counter = core_io_debug_signal_cycle_counter; // @[Top.scala 80:24]
  assign io_debugSignals_raddr = core_io_dmem_raddr; // @[Top.scala 81:26]
  assign io_debugSignals_rdata = decoder_io_initiator_rdata; // @[Top.scala 82:26]
  assign io_debugSignals_ren = core_io_dmem_ren; // @[Top.scala 83:26]
  assign io_debugSignals_rvalid = decoder_io_initiator_rvalid; // @[Top.scala 84:26]
  assign io_debugSignals_waddr = core_io_dmem_waddr; // @[Top.scala 85:26]
  assign io_debugSignals_wen = core_io_dmem_wen; // @[Top.scala 87:26]
  assign io_debugSignals_wready = decoder_io_initiator_wready; // @[Top.scala 88:26]
  assign io_debugSignals_wstrb = core_io_dmem_wstrb; // @[Top.scala 89:26]
  assign io_debugSignals_wdata = core_io_dmem_wdata; // @[Top.scala 86:26]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_imem_inst = memory_io_imem_inst; // @[Top.scala 72:16]
  assign core_io_imem_valid = memory_io_imem_valid; // @[Top.scala 72:16]
  assign core_io_dmem_rdata = decoder_io_initiator_rdata; // @[Top.scala 75:16]
  assign core_io_dmem_rvalid = decoder_io_initiator_rvalid; // @[Top.scala 75:16]
  assign memory_clock = clock;
  assign memory_reset = reset;
  assign memory_io_imem_addr = core_io_imem_addr; // @[Top.scala 72:16]
  assign memory_io_dmem_raddr = decoder_io_targets_1_raddr; // @[Top.scala 67:25]
  assign memory_io_dmem_ren = decoder_io_targets_1_ren; // @[Top.scala 67:25]
  assign memory_io_dmem_waddr = decoder_io_targets_1_waddr; // @[Top.scala 67:25]
  assign memory_io_dmem_wen = decoder_io_targets_1_wen; // @[Top.scala 67:25]
  assign memory_io_dmem_wstrb = decoder_io_targets_1_wstrb; // @[Top.scala 67:25]
  assign memory_io_dmem_wdata = decoder_io_targets_1_wdata; // @[Top.scala 67:25]
  assign memory_io_imemReadPort_data = io_imem_data; // @[Top.scala 73:26]
  assign imem_dbus_clock = clock;
  assign imem_dbus_reset = reset;
  assign imem_dbus_io_mem_raddr = decoder_io_targets_0_raddr; // @[Top.scala 66:25]
  assign imem_dbus_io_mem_ren = decoder_io_targets_0_ren; // @[Top.scala 66:25]
  assign imem_dbus_io_mem_waddr = decoder_io_targets_0_waddr; // @[Top.scala 66:25]
  assign imem_dbus_io_mem_wen = decoder_io_targets_0_wen; // @[Top.scala 66:25]
  assign imem_dbus_io_mem_wdata = decoder_io_targets_0_wdata; // @[Top.scala 66:25]
  assign imem_dbus_io_read_data = io_imemRead_data; // @[Top.scala 76:21]
  assign gpio_clock = clock;
  assign gpio_reset = reset;
  assign gpio_io_mem_wen = decoder_io_targets_2_wen; // @[Top.scala 68:25]
  assign gpio_io_mem_wdata = decoder_io_targets_2_wdata; // @[Top.scala 68:25]
  assign uart_clock = clock;
  assign uart_reset = reset;
  assign uart_io_mem_wen = decoder_io_targets_3_wen; // @[Top.scala 69:25]
  assign uart_io_mem_wdata = decoder_io_targets_3_wdata; // @[Top.scala 69:25]
  assign config__io_mem_raddr = decoder_io_targets_4_raddr; // @[Top.scala 70:25]
  assign decoder_io_initiator_raddr = core_io_dmem_raddr; // @[Top.scala 75:16]
  assign decoder_io_initiator_ren = core_io_dmem_ren; // @[Top.scala 75:16]
  assign decoder_io_initiator_waddr = core_io_dmem_waddr; // @[Top.scala 75:16]
  assign decoder_io_initiator_wen = core_io_dmem_wen; // @[Top.scala 75:16]
  assign decoder_io_initiator_wstrb = core_io_dmem_wstrb; // @[Top.scala 75:16]
  assign decoder_io_initiator_wdata = core_io_dmem_wdata; // @[Top.scala 75:16]
  assign decoder_io_targets_0_rdata = imem_dbus_io_mem_rdata; // @[Top.scala 66:25]
  assign decoder_io_targets_0_rvalid = imem_dbus_io_mem_rvalid; // @[Top.scala 66:25]
  assign decoder_io_targets_1_rdata = memory_io_dmem_rdata; // @[Top.scala 67:25]
  assign decoder_io_targets_1_rvalid = memory_io_dmem_rvalid; // @[Top.scala 67:25]
  assign decoder_io_targets_3_rdata = uart_io_mem_rdata; // @[Top.scala 69:25]
  assign decoder_io_targets_4_rdata = config__io_mem_rdata; // @[Top.scala 70:25]
endmodule
