package fpga

import chisel3._
import chisel3.util._
import common.Consts._
import chisel3.stage.ChiselStage

class SingleCycleMem(sizeInBytes: Int) extends Module {
  val io = IO(new Bundle {
    val mem = new DmemPortIo
    val read = new MemoryReadPort(sizeInBytes/4, UInt(32.W))
    val write = new MemoryWritePort(sizeInBytes/4, UInt(32.W))
  })

  io.read.address := io.mem.raddr >> 2
  io.read.enable := io.mem.ren
  io.mem.rdata := io.read.data
  io.mem.rvalid := RegNext(io.mem.ren, false.B)

  io.write.address := io.mem.waddr >> 2
  io.write.enable := io.mem.wen
  io.write.data := io.mem.wdata
  io.mem.wready := true.B
}
