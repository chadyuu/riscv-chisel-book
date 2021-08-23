package fpga

import chisel3._
import chisel3.util._
import common.Consts._
import chisel3.stage.ChiselStage

class DMemDecoder(targetAddressRanges: Seq[(BigInt, BigInt)]) extends Module {
  val io = IO(new Bundle {
    val initiator = new DmemPortIo()
    val targets = Vec(targetAddressRanges.size, Flipped(new DmemPortIo))
  })

  val rvalid = WireDefault(true.B)
  val rdata = WireDefault("xdeadbeef".U(32.W))
  val wready = WireDefault(false.B)

  io.initiator.rvalid := rvalid
  io.initiator.rdata := rdata
  io.initiator.wready := wready

  for(((start, length), index) <- targetAddressRanges.zipWithIndex) {
    val target = io.targets(index)

    val raddr = WireDefault(0.U(32.W))
    val ren = WireDefault(false.B)
    val waddr = WireDefault(0.U(32.W))
    val wen = WireDefault(false.B)
    val wdata = WireDefault("xdeadbeef".U(32.W))
    val wstrb = WireDefault("b1111".U)
    
    target.raddr := raddr
    target.ren := ren
    target.waddr := waddr
    target.wen := wen
    target.wdata := wdata
    target.wstrb := wstrb

    when(start.U <= io.initiator.raddr && io.initiator.raddr < (start + length).U ) {
      raddr := io.initiator.raddr - start.U
      ren := io.initiator.ren
      rvalid := target.rvalid
      rdata := target.rdata
    }
    when(start.U <= io.initiator.waddr && io.initiator.waddr < (start + length).U ) {
      waddr := io.initiator.waddr - start.U
      wen := io.initiator.wen
      wdata := io.initiator.wdata
      wstrb := io.initiator.wstrb
      wready := target.wready
    }
  }
}

class Gpio() extends Module {
  val io = IO(new Bundle {
    val mem = new DmemPortIo
    val gpio = Output(UInt(32.W))
  })

  val output = RegInit(0.U(32.W))
  io.gpio := output

  io.mem.rdata := "xdeadbeef".U
  io.mem.rvalid := true.B
  io.mem.wready := true.B
  when(io.mem.wen) {
    output := io.mem.wdata
  }
}

class SingleCycleMem(sizeInBytes: Int) extends Module {
  val io = IO(new Bundle {
    val mem = new DmemPortIo
    val read = new MemoryReadPort(sizeInBytes/4, UInt(32.W))
    val write = new MemoryWritePort(sizeInBytes/4, UInt(32.W))
  })

  io.read.address := io.mem.raddr
  io.read.enable := io.mem.ren
  io.mem.rdata := io.read.data
  io.mem.rvalid := true.B

  io.write.address := io.mem.waddr
  io.write.enable := io.mem.wen
  io.write.data := io.mem.wdata
  io.mem.wready := true.B
}

class RiscV extends Module {
  val imemSizeInBytes = 2048
  val dmemSizeInBytes = 512
  val startAddress = 0x08000000L

  val io = IO(new Bundle {
    val gpio = Output(UInt(8.W))
    val exit = Output(Bool())
    val imem = new MemoryReadPort(imemSizeInBytes/4, UInt(32.W))
    val imemRead = new MemoryReadPort(imemSizeInBytes/4, UInt(32.W))
    val imemWrite = new MemoryWritePort(imemSizeInBytes/4, UInt(32.W))
  })
  val core = Module(new Core(startAddress))
  
  val memory = Module(new Memory(null, imemSizeInBytes, dmemSizeInBytes, false))
  val imem_dbus = Module(new SingleCycleMem(imemSizeInBytes))
  val gpio = Module(new Gpio)

  val decoder = Module(new DMemDecoder(Seq(
    (BigInt(startAddress), BigInt(imemSizeInBytes)),
    (BigInt(0x20000000L), BigInt(dmemSizeInBytes)),
    (BigInt(0x30000000L), BigInt(64)),
  )))
  decoder.io.targets(0) <> imem_dbus.io.mem
  decoder.io.targets(1) <> memory.io.dmem
  decoder.io.targets(2) <> gpio.io.mem

  core.io.imem <> memory.io.imem
  memory.io.imemReadPort <> io.imem
  // core.io.dmem <> memory.io.dmem
  core.io.dmem <> decoder.io.initiator
  imem_dbus.io.read <> io.imemRead
  imem_dbus.io.write <> io.imemWrite

  io.exit := core.io.exit
  io.gpio <> gpio.io.gpio
}

object Elaborate extends App {
  (new ChiselStage).emitVerilog(new RiscV, Array(
    "-o", "riscv.v",
    "--target-dir", "rtl/riscv",
  ))
}