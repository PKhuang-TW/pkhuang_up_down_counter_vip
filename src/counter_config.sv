`ifndef COUNTER_CONFIG_SV
`define COUNTER_CONFIG_SV

class counter_config #(
    parameter ADDR_WIDTH = counter_package::ADDR_WIDTH
) extends uvm_object;
    `uvm_object_param_utils(counter_config #(ADDR_WIDTH))
    
    typedef counter_config #(ADDR_WIDTH)    cfg_t;
    typedef counter_interface #(ADDR_WIDTH) vif_t;

    vif_t   vif;

    function new (string name = "counter_config");
        super.new(name);
    endfunction
endclass

`endif