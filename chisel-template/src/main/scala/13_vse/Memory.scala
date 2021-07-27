package vse

import chisel3._
import chisel3.util._
import common.Consts._
import chisel3.util.experimental.loadMemoryFromFile

class ImemPortIo extends Bundle {
  val addr = Input(UInt(WORD_LEN.W))
  val inst = Output(UInt(WORD_LEN.W))
}

class DmemPortIo extends Bundle {
  val addr     = Input(UInt(WORD_LEN.W))
  val rdata    = Output(UInt(WORD_LEN.W))
  val wen      = Input(UInt(MEN_LEN.W))
  val wdata    = Input(UInt(WORD_LEN.W))
  val vrdata   = Output(UInt((VLEN*8).W))
  val vwdata   = Input(UInt((VLEN*8).W))
  val data_len = Input(UInt(WORD_LEN.W))
}

class Memory extends Module {
  val io = IO(new Bundle {
    val imem = new ImemPortIo()
    val dmem = new DmemPortIo()
  })

  val mem = Mem(16384, UInt(8.W))
  loadMemoryFromFile(mem, "src/hex/vse32_m2.hex")
  io.imem.inst := Cat(
    mem(io.imem.addr + 3.U(WORD_LEN.W)), 
    mem(io.imem.addr + 2.U(WORD_LEN.W)),
    mem(io.imem.addr + 1.U(WORD_LEN.W)),
    mem(io.imem.addr)
  )
  
  def readData(len: Int) = Cat(Seq.tabulate(len / 8)(n => mem(io.dmem.addr + n.U(WORD_LEN.W))).reverse)
  io.dmem.rdata  := readData(WORD_LEN)
  io.dmem.vrdata := readData(VLEN*8)

  switch(io.dmem.wen){
    is(MEN_S){
      mem(io.dmem.addr)       := io.dmem.wdata( 7, 0)
      mem(io.dmem.addr + 1.U) := io.dmem.wdata(15, 8)
      mem(io.dmem.addr + 2.U) := io.dmem.wdata(23,16)
      mem(io.dmem.addr + 3.U) := io.dmem.wdata(31,24)
    }
    is(MEN_V){
      val data_len_byte = io.dmem.data_len / 8.U
      for(i <- 0 to VLEN - 1){ // 最大[VLEN*8]bit = VLEN byte
        when(i.U < data_len_byte){
          mem(io.dmem.addr + i.U) := io.dmem.vwdata(8*(i+1)-1, 8*i)
        }
      }
    }
  }
}