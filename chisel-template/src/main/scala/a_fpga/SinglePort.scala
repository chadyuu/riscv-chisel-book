package fpga

import chisel3._
import chisel3.util._
import java.io.FileInputStream
import scala.collection.mutable.ArrayBuffer

class MemoryReadPort[T <: Data](numberOfElements: Int, gen: T) extends Bundle {
  val addressBits = log2Ceil(numberOfElements)
  val address = Output(UInt(addressBits.W))
  val data = Input(gen)
  val enable = Output(Bool())
}
class MemoryWritePort[T <: Data](numberOfElements: Int, gen: T) extends Bundle {
  val addressBits = log2Ceil(numberOfElements)
  val address = Output(UInt(addressBits.W))
  val data = Output(gen)
  val enable = Output(Bool())
}

class SinglePortMemory[T <: Data](numberOfElements: Int, gen: T) extends Module {
  val io = IO(new Bundle{
    val read = Flipped(new MemoryReadPort(numberOfElements, gen))
    val write = Flipped(new MemoryWritePort(numberOfElements, gen))
  })

  val mem = SyncReadMem(numberOfElements, gen)

  when(io.read.enable) {
    io.read.data := mem.read(io.read.address)
  } .otherwise {
    io.read.data := DontCare
  }
  when(io.write.enable) {
    mem.write(io.write.address, io.write.data)
  }
}