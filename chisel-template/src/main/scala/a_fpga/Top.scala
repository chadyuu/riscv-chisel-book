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


class Uart(clockHz: Int, baudRate: Int = 115200) extends Module {
  val io = IO(new Bundle {
    val mem = new DmemPortIo
    val tx = Output(Bool())
  })

  val tx = Module(new UartTx(8, clockHz/baudRate))
  val txValid = RegInit(false.B)
  val txReady = WireDefault(tx.io.in.ready)
  val txData = RegInit(0.U(8.W))
  tx.io.in.valid := txValid
  tx.io.in.bits := txData

  when(txValid && txReady) {
    txValid := false.B
  }

  io.mem.rdata := Cat(0.U(31.W), txValid.asUInt)
  io.mem.rvalid := true.B
  io.mem.wready := true.B
  when(io.mem.wen) {
    when( !txValid ) {  //Send TX Data if not busy.
      txValid := true.B
      txData := io.mem.wdata
    }
  }

  io.tx <> tx.io.tx // Connect UART TX signal.
}

class Config(clockHz: Int) extends Module {
  val io = IO(new Bundle {
    val mem = new DmemPortIo
  })

  io.mem.rdata := MuxLookup(io.mem.raddr(2, 2), "xDEADBEEF".U, Seq(
    0.U -> "x01234567".U,
    1.U -> clockHz.U,
  ))
  io.mem.rvalid := true.B
  io.mem.wready := true.B
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
  io.mem.rvalid := RegNext(io.mem.ren, false.B)

  io.write.address := io.mem.waddr
  io.write.enable := io.mem.wen
  io.write.data := io.mem.wdata
  io.mem.wready := true.B
}

class RiscVDebugSignals extends Bundle {
  val core = new CoreDebugSignals()

  val raddr  = Output(UInt(WORD_LEN.W))
  val rdata = Output(UInt(WORD_LEN.W))
  val ren   = Output(Bool())
  val rvalid = Output(Bool())

  val waddr  = Output(UInt(WORD_LEN.W))
  val wen   = Output(Bool())
  val wready = Output(Bool())
  val wstrb = Output(UInt(4.W))
  val wdata = Output(UInt(WORD_LEN.W))
}

class RiscV(clockHz: Int) extends Module {
  val imemSizeInBytes = 2048
  val dmemSizeInBytes = 512
  val startAddress = 0x08000000L

  val io = IO(new Bundle {
    val gpio = Output(UInt(8.W))
    val uart_tx = Output(Bool())
    val exit = Output(Bool())
    val imem = new MemoryReadPort(imemSizeInBytes/4, UInt(32.W))
    val imemRead = new MemoryReadPort(imemSizeInBytes/4, UInt(32.W))
    val imemWrite = new MemoryWritePort(imemSizeInBytes/4, UInt(32.W))
    val debugSignals = new RiscVDebugSignals()
  })
  val core = Module(new Core(startAddress))
  
  val memory = Module(new Memory(null, imemSizeInBytes, dmemSizeInBytes, false))
  val imem_dbus = Module(new SingleCycleMem(imemSizeInBytes))
  val gpio = Module(new Gpio)
  val uart = Module(new Uart(clockHz))
  val config = Module(new Config(clockHz))

  val decoder = Module(new DMemDecoder(Seq(
    (BigInt(startAddress), BigInt(imemSizeInBytes)),
    (BigInt(0x20000000L), BigInt(dmemSizeInBytes)),
    (BigInt(0x30000000L), BigInt(64)),  // GPIO
    (BigInt(0x30001000L), BigInt(64)),  // UART
    (BigInt(0x40000000L), BigInt(64)),  // CONFIG
  )))
  decoder.io.targets(0) <> imem_dbus.io.mem
  decoder.io.targets(1) <> memory.io.dmem
  decoder.io.targets(2) <> gpio.io.mem
  decoder.io.targets(3) <> uart.io.mem
  decoder.io.targets(4) <> config.io.mem

  core.io.imem <> memory.io.imem
  memory.io.imemReadPort <> io.imem
  // core.io.dmem <> memory.io.dmem
  core.io.dmem <> decoder.io.initiator
  imem_dbus.io.read <> io.imemRead
  imem_dbus.io.write <> io.imemWrite

  // Debug signals
  io.debugSignals.core <> core.io.debug_signal
  io.debugSignals.raddr  := core.io.dmem.raddr  
  io.debugSignals.rdata  := decoder.io.initiator.rdata  
  io.debugSignals.ren    := core.io.dmem.ren    
  io.debugSignals.rvalid := decoder.io.initiator.rvalid 
  io.debugSignals.waddr  := core.io.dmem.waddr  
  io.debugSignals.wdata  := core.io.dmem.wdata
  io.debugSignals.wen    := core.io.dmem.wen    
  io.debugSignals.wready := decoder.io.initiator.wready 
  io.debugSignals.wstrb  := core.io.dmem.wstrb

  io.exit := core.io.exit
  io.gpio <> gpio.io.gpio
  io.uart_tx <> uart.io.tx
}

object ElaborateArtyA7 extends App {
  (new ChiselStage).emitVerilog(new RiscV(80000000), Array(
    "-o", "riscv.v",
    "--target-dir", "rtl/riscv_arty_a7",
  ))
}

object ElaborateRunber extends App {
  (new ChiselStage).emitVerilog(new RiscV(12000000), Array(
    "-o", "riscv.v",
    "--target-dir", "rtl/riscv_runber",
  ))
}

object ElaborateTangNano9K extends App {
  (new ChiselStage).emitVerilog(new RiscV(27000000), Array(
    "-o", "riscv.v",
    "--target-dir", "rtl/riscv_tangnano9k",
  ))
}

