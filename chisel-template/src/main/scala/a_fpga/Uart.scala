package fpga

import chisel3._
import chisel3.util._

class UartTx(numberOfBits: Int, baudDivider: Int) extends Module {
    val io = IO(new Bundle{
        val in = Flipped(Decoupled(UInt(numberOfBits.W)))
        val tx = Output(Bool())
    })

    val rateCounter = RegInit(0.U(log2Ceil(baudDivider).W))
    val bitCounter = RegInit(0.U(log2Ceil(numberOfBits + 2).W))
    val bits = Reg(Vec(numberOfBits + 2, Bool()))

    io.tx := bitCounter === 0.U || bits(0)
    io.in.ready := bitCounter === 0.U
    
    when(io.in.valid && io.in.ready) {
        bits := Cat(1.U, io.in.bits, 0.U).asBools   // STOP(1), DATA, START(0)
        bitCounter := (numberOfBits + 2).U
        rateCounter := (baudDivider - 1).U
    }

    when( bitCounter > 0.U ) {
        when(rateCounter === 0.U) {
            // Shift out from LSB
            (0 to numberOfBits).foreach(i => bits(i) := bits(i + 1))
            bitCounter := bitCounter - 1.U
            rateCounter := (baudDivider - 1).U
        } .otherwise {
            rateCounter := rateCounter - 1.U
        }
    }
}

class UartRx(numberOfBits: Int, baudDivider: Int, rxSyncStages: Int) extends Module {
    val io = IO(new Bundle{
        val out = Decoupled(UInt(numberOfBits.W))
        val rx = Input(Bool())
        val overrun = Output(Bool())
    })

    val rateCounter = RegInit(0.U(log2Ceil(baudDivider*3/2).W))
    val bitCounter = RegInit(0.U(log2Ceil(numberOfBits).W))
    val bits = Reg(Vec(numberOfBits, Bool()))
    val rxRegs = RegInit(VecInit((0 to rxSyncStages + 1 - 1).map(_ => false.B)))
    val overrun = RegInit(false.B)
    val running = RegInit(false.B)

    val outValid = RegInit(false.B)
    val outBits = Reg(UInt(numberOfBits.W))
    val outReady = WireDefault(io.out.ready)
    io.out.valid := outValid
    io.out.bits := outBits

    when(outValid && outReady) {
        outValid := false.B
    }

    // Synchronize RX signal
    rxRegs(rxSyncStages) := io.rx
    (0 to rxSyncStages - 1).foreach(i => rxRegs(i) := rxRegs(i + 1))

    io.overrun := overrun

    when(!running) {
        when(!rxRegs(1) && rxRegs(0)) {    // START bit is detected.
            rateCounter := (baudDivider * 3 / 2 - 1).U // Wait until the center of LSB.
            bitCounter := (numberOfBits - 1).U
            running := true.B
        }
    } .otherwise {
        when(rateCounter === 0.U) {
            bits(numberOfBits-1) := rxRegs(0)
            (0 to numberOfBits - 2).foreach(i => bits(i) := bits(i + 1))
            when(bitCounter === 0.U) {
                outValid := true.B
                outBits := Cat(rxRegs(0), Cat(bits.slice(1, numberOfBits).reverse))
                overrun := outValid // A new data has arrived while previous data is not consumed.
                running := false.B
            } .otherwise {
                rateCounter := (baudDivider - 1).U
                bitCounter := bitCounter - 1.U
            }
        } .otherwise {
            rateCounter := rateCounter - 1.U
        }
    }

}

class Uart(clockHz: Int, baudRate: Int = 115200) extends Module {
  val io = IO(new Bundle {
    val mem = new DmemPortIo
    val tx = Output(Bool())
    val rx = Input(Bool())
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

  val rx = Module(new UartRx(8, clockHz/baudRate, 2))
  val rxValid = RegInit(false.B)
  rx.io.out.ready := true.B
  val rxData = RegInit(0.U(8.W))
  rx.io.rx := io.rx
  
  when(io.mem.ren && io.mem.raddr(2, 2) === 0.U) {
    rxValid := false.B
  }
  when(rx.io.out.valid && !rxValid) {
    rxValid := true.B
    rxData := rx.io.out.bits
  }

  io.mem.rdata := MuxLookup(io.mem.raddr(2, 2), "xDEADBEEF".U, Seq(
    0.U -> Cat(0.U(24.W), rxData),
    1.U -> Cat(0.U(30.W), rxValid.asUInt, txValid.asUInt),
  ))
  
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