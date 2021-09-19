package vsetvli

import chisel3._
import common.Consts._

class Top extends Module {
  val io = IO(new Bundle {
    val pc   = Output(UInt(WORD_LEN.W))
    val gp   = Output(UInt(WORD_LEN.W))
    val exit = Output(Bool())
  })
  val core   = Module(new Core())
  val memory = Module(new Memory())
  core.io.imem <> memory.io.imem
  core.io.dmem <> memory.io.dmem
  io.pc   := core.io.pc
  io.gp   := core.io.gp
  io.exit := core.io.exit
}
