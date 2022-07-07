package fpga

import chisel3._
import chisel3.util._
import common.Consts._
import chisel3.stage.ChiselStage

class Gpio() extends Module {
  val io = IO(new Bundle {
    val mem = new DmemPortIo
    val in = Input(UInt(32.W))
    val out = Output(UInt(32.W))
    val out_enable = Output(UInt(32.W))
  })

  val out = RegInit(0.U(32.W))
  val out_enable = RegInit(0.U(32.W))
  val in = RegInit(0.U(32.W))

  io.out := out
  io.out_enable := out_enable
  in := io.in
  
  io.mem.rdata := "xdeadbeef".U
  io.mem.rvalid := true.B
  io.mem.wready := true.B
  io.mem.rdata := MuxLookup(io.mem.raddr(3, 2), "xDEADBEEF".U, Seq(
      0.U -> out, // Output
      1.U -> in, // Input
      2.U -> out_enable, // Output Enable
  ))
  when(io.mem.wen) {
      val mask = Cat((0 to 3).map(i => Mux(io.mem.wstrb(i), 0xff.U(8.W), 0x00.U(8.W))).reverse)
      switch(io.mem.waddr(3,2)) {
        // Output
        is(0.U) {
          out := (out & ~mask) | (io.mem.wdata & mask)
        }
        // Output Enable
        is(2.U) {
          out_enable := (out_enable & ~mask) | (io.mem.wdata & mask)
        }
    }
  }
}
