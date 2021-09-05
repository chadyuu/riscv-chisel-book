package lw

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import common.Consts._

class ImemPortIo extends Bundle {
  val addr = Input(UInt(WORD_LEN.W))
  val inst = Output(UInt(WORD_LEN.W))
}

class DmemPortIo extends Bundle {
  val addr  = Input(UInt(WORD_LEN.W))
  val rdata = Output(UInt(WORD_LEN.W))
}

class Memory extends Module {
  val io = IO(new Bundle {
    val imem = new ImemPortIo()
    val dmem = new DmemPortIo() // 追加
  })

  val mem = Mem(16384, UInt(8.W))
  loadMemoryFromFile(mem, "src/hex/lw.hex")
  io.imem.inst := Cat(
    mem(io.imem.addr + 3.U(WORD_LEN.W)), 
    mem(io.imem.addr + 2.U(WORD_LEN.W)),
    mem(io.imem.addr + 1.U(WORD_LEN.W)),
    mem(io.imem.addr)
  )
  io.dmem.rdata := Cat(
    mem(io.dmem.addr + 3.U(WORD_LEN.W)),
    mem(io.dmem.addr + 2.U(WORD_LEN.W)), 
    mem(io.dmem.addr + 1.U(WORD_LEN.W)),
    mem(io.dmem.addr)
  ) // 追加
}