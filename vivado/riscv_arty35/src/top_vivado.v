module top_vivado(
    input wire clock,
    input wire resetn,
    output wire [7:0] gpio_out,
    output wire uart_tx
);

top (
    .clock(clock),
    .resetn(resetn),
    .gpio_out(gpio_out),
    .uart_tx(uart_tx)
);

endmodule