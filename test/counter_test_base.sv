`ifndef COUNTER_TEST_BASE_SV
`define COUNTER_TEST_BASE_SV

import counter_package::*;

class counter_test_base #(
    parameter ADDR_WIDTH = counter_package::P_ADDR_WIDTH
) extends uvm_test;
    `uvm_component_param_utils(counter_test_base #(ADDR_WIDTH))

    counter_config #(ADDR_WIDTH)    cfg;
    counter_env #(ADDR_WIDTH)       env;

    counter_sequence #(ADDR_WIDTH)  seq;

    function new ( string name = "counter_test_base", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
        env = counter_env #(ADDR_WIDTH) :: type_id :: create ("env", this);
        cfg = counter_config #(ADDR_WIDTH) :: type_id :: create ("cfg");

        if ( !uvm_config_db #(virtual counter_interface #(ADDR_WIDTH)) :: get (this, "", "vif", cfg.vif) )
            `uvm_error("NOVIF", $sformatf("No vif set for %s.cfg.vif", get_full_name()))

        uvm_config_db #(counter_config #(ADDR_WIDTH)) :: set (this, "*", "cfg", cfg);
    endfunction
endclass

`endif