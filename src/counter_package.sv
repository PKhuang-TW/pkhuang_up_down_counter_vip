`ifndef COUNTER_PACKAGE_SV
`define COUNTER_PACKAGE_SV

package counter_package;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    const int ADDR_WIDTH = 3;

    `include "counter_interface.sv"
    `include "counter_config.sv"
    `include "counter_seq_item.sv"
    `include "counter_monitor.sv"
    `include "counter_driver.sv"
    `include "counter_agent.sv"
    `include "counter_env.sv"
    `include "counter_test_base.sv"

endpackage

`endif