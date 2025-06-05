`ifndef COUNTER_PACKAGE_SV
`define COUNTER_PACKAGE_SV

package counter_package;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "counter_config.sv"
    `include "counter_seq_item.sv"
    `include "counter_monitor.sv"
    `include "counter_driver.sv"
    `include "counter_agent.sv"
    `include "counter_scoreboard.sv"
    `include "counter_env.sv"
    `include "counter_sequence.sv"
    `include "counter_test_base.sv"

endpackage

`endif