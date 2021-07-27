package vle

import chisel3._
import chisel3.util._
import common.Consts._
import chisel3.util.experimental.loadMemoryFromFile

class ImemPortIo extends Bundle {
  val addr = Input(UInt(WORD_LEN.W))
  val inst = Output(UInt(WORD_LEN.W))
}

class DmemPortIo extends Bundle {
  val addr   = Input(UInt(WORD_LEN.W))
  val rdata  = Output(UInt(WORD_LEN.W))
  val wen    = Input(Bool())
  val wdata  = Input(UInt(WORD_LEN.W))
  val vrdata = Output(UInt((VLEN*8).W))
}

class Memory extends Module {
  val io = IO(new Bundle {
    val imem = new ImemPortIo()
    val dmem = new DmemPortIo()
  })

  val mem = Mem(16384, UInt(8.W))
  loadMemoryFromFile(mem, "src/hex/vle32_m2.hex")
  io.imem.inst := Cat(
    mem(io.imem.addr + 3.U(WORD_LEN.W)), 
    mem(io.imem.addr + 2.U(WORD_LEN.W)),
    mem(io.imem.addr + 1.U(WORD_LEN.W)),
    mem(io.imem.addr)
  )
  
  def readData(len: Int) = Cat(Seq.tabulate(len / 8)(n => mem(io.dmem.addr + n.U(WORD_LEN.W))).reverse)
  io.dmem.rdata  := readData(WORD_LEN)
  io.dmem.vrdata := readData(VLEN*8)

  when(io.dmem.wen){
    mem(io.dmem.addr)                   := io.dmem.wdata( 7,  0)
    mem(io.dmem.addr + 1.U(WORD_LEN.W)) := io.dmem.wdata(15,  8)
    mem(io.dmem.addr + 2.U(WORD_LEN.W)) := io.dmem.wdata(23, 16)
    mem(io.dmem.addr + 3.U(WORD_LEN.W)) := io.dmem.wdata(31, 24)
  }
}