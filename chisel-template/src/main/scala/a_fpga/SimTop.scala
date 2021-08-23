package fpga

import chisel3._
import chisel3.util._
import common.Consts._
import chisel3.util.experimental.loadMemoryFromFile

class SimTop(memoryPath: String) extends Module {
  val io = IO(new Bundle {
    val gp = Output(UInt(WORD_LEN.W))
    val exit = Output(Bool())
  })
  val core = Module(new Core())
  val memory = Module(new Memory(memoryPath))
  val imem = Mem(16384, UInt(32.W))
  loadMemoryFromFile(imem, memoryPath)

  core.io.imem <> memory.io.imem
  core.io.dmem <> memory.io.dmem
  io.gp   := core.io.gp
  io.exit := core.io.exit

  val imemData = RegInit(0.U(32.W))
  memory.io.imemReadPort.data := imemData
  when(memory.io.imemReadPort.enable) {
    imemData := imem(memory.io.imemReadPort.address)
  }
}