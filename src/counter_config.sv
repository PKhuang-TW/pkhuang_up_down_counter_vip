`ifndef COUNTER_CONFIG_SV
`define COUNTER_CONFIG_SV

import counter_package::*;

class counter_config #(
    parameter ADDR_WIDTH = P_ADDR_WIDTH
) extends uvm_object;
    `uvm_object_param_utils(counter_config #(ADDR_WIDTH))
    
    // typedef counter_config #(ADDR_WIDTH)    cfg_t;

    virtual counter_interface #(ADDR_WIDTH) vif;

    function new (string name = "counter_config");
        super.new(name);
    endfunction
endclass

`endif