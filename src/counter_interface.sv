`ifndef COUNTER_INTERFACE_SV
`define COUNTER_INTERFACE_SV

interface counter_interface #(
    parameter ADDR_WIDTH = 3
)(
    input   wire    clk,
    input   wire    rst_n
);
    logic                   reverse;
    logic[ADDR_WIDTH-1:0]   counter;
endinterface

`endif