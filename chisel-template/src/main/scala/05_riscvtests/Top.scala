package riscvtests

import chisel3._
import common.Consts._

class Top extends Module {
  val io = IO(new Bundle {
    val exit = Output(Bool())
    val gp   = Output(UInt(WORD_LEN.W))
  })
  val core = Module(new Core())
  val memory = Module(new Memory())
  core.io.imem <> memory.io.imem
  core.io.dmem <> memory.io.dmem
  io.exit := core.io.exit
  io.gp   := core.io.gp
}