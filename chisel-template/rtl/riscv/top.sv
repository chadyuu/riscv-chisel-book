module top(
    input wire clock,
    input wire resetn,
    output logic [7:0] gpio_out,
    output logic uart_tx
);

logic io_exit;
logic [8:0] io_imem_address;
logic [31:0] io_imem_data;
logic io_imem_enable;
(* mark_debug = "true" *) logic [8:0]  io_imemRead_address;
(* mark_debug = "true" *) logic [31:0] io_imemRead_data;
(* mark_debug = "true" *) logic        io_imemRead_enable;
(* mark_debug = "true" *) logic [8:0]  io_imemWrite_address;
(* mark_debug = "true" *) logic [31:0] io_imemWrite_data;
(* mark_debug = "true" *) logic        io_imemWrite_enable;
(* mark_debug = "true" *) logic [31:0] io_debugSignals_core_mem_reg_pc;
(* mark_debug = "true" *) logic [31:0] io_debugSignals_core_csr_rdata;
(* mark_debug = "true" *) logic [31:0] io_debugSignals_core_mem_reg_csr_addr;
(* mark_debug = "true" *) logic [63:0] io_debugSignals_core_cycle_counter;
(* mark_debug = "true" *) logic [31:0] io_debugSignals_raddr;
(* mark_debug = "true" *) logic [31:0] io_debugSignals_rdata;
(* mark_debug = "true" *) logic        io_debugSignals_ren;
(* mark_debug = "true" *) logic        io_debugSignals_rvalid;
(* mark_debug = "true" *) logic [31:0] io_debugSignals_waddr;
(* mark_debug = "true" *) logic        io_debugSignals_wen;
(* mark_debug = "true" *) logic        io_debugSignals_wready;
(* mark_debug = "true" *) logic [3:0]  io_debugSignals_wstrb;
(* mark_debug = "true" *) logic [31:0] io_debugSignals_wdata;

RiscV core(
    .reset(!resetn),
    .io_gpio(gpio_out),
    .io_uart_tx(uart_tx),
    .*
);

logic [31:0] imem [0:511];
initial begin
    $readmemh("bootrom.hex", imem);
end

// imem instruction bus access
always @(posedge clock) begin
    if( !resetn ) begin
        io_imem_data <= 0;
    end
    else begin
        if( io_imem_enable ) begin
            io_imem_data <= imem[io_imem_address];
        end
    end
end
// imem data bus access
always @(posedge clock) begin
    if( !resetn ) begin
        io_imemRead_data <= 0;
    end
    else begin
        if( io_imemRead_enable ) begin
            io_imemRead_data <= imem[io_imemRead_address[$bits(io_imemRead_address)-1:2]];
        end
        if( io_imemWrite_enable ) begin
            imem[io_imemWrite_address[$bits(io_imemWrite_address)-1:2]] <= io_imemWrite_data;
        end
    end
end

endmodule