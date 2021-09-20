package sw

import chisel3._

class Top extends Module {
  val io = IO(new Bundle {
    val exit = Output(Bool())
  })
  val core = Module(new Core())
  val memory = Module(new Memory())
  core.io.imem <> memory.io.imem
  core.io.dmem <> memory.io.dmem
  io.exit := core.io.exit
}
