package fetch

import chisel3._
import common.Consts._

class Core extends Module {
  val io = IO(new Bundle {
    val imem = Flipped(new ImemPortIo())
    val exit = Output(Bool())
  })

  val regfile = Mem(32, UInt(WORD_LEN.W))


  //**********************************
  // Instruction Fetch (IF) Stage

  val pc_reg = RegInit(START_ADDR)
  pc_reg := pc_reg + 4.U(WORD_LEN.W)
  io.imem.addr := pc_reg
  val inst = io.imem.inst


  //**********************************
  // Debug
  io.exit := (inst === 0x34333231.U(WORD_LEN.W))
  printf(p"pc_reg : 0x${Hexadecimal(pc_reg)}\n")
  printf(p"inst   : 0x${Hexadecimal(inst)}\n")
  printf("---------\n")
}
