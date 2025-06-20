`ifndef COUNTER_INTERFACE_SV
`define COUNTER_INTERFACE_SV

import counter_package::*;

interface counter_interface #(
    parameter ADDR_WIDTH = P_ADDR_WIDTH
)(
    input   wire    clk,
    input   wire    rst_n
);
    logic                   reverse;
    logic[ADDR_WIDTH-1:0]   counter;
endinterface

`endif