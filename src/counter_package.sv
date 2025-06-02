`ifndef COUNTER_PACKAGE_SV
`define COUNTER_PACKAGE_SV

package counter_package;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "counter_config.sv"
    `include "counter_interface.sv"
    `include "counter_seq_item.sv"
    `include "counter_agent.sv"

    const int ADDR_WIDTH = 3;

endpackage

`endif