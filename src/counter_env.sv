`ifndef COUNTER_ENV_SV
`define COUNTER_ENV_SV

import counter_package::*;

class counter_env #(
    parameter ADDR_WIDTH = P_ADDR_WIDTH
) extends uvm_env;
    `uvm_component_param_utils(counter_env)

    counter_agent #(ADDR_WIDTH)         agt_active, agt_passive;
    counter_scoreboard #(ADDR_WIDTH)    scb;
    counter_coverage #(ADDR_WIDTH)      cov;

    function new ( string name = "counter_env", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);

        uvm_config_db #(uvm_active_passive_enum) :: set (this, "agt_active", "agt_mode", UVM_ACTIVE);
        uvm_config_db #(uvm_active_passive_enum) :: set (this, "agt_passive", "agt_mode", UVM_PASSIVE);

        agt_active  = counter_agent #(ADDR_WIDTH) :: type_id :: create ("agt_active", this);
        agt_passive = counter_agent #(ADDR_WIDTH) :: type_id :: create ("agt_passive", this);
        scb         = counter_scoreboard #(ADDR_WIDTH) :: type_id :: create ("scb", this);
        cov         = counter_coverage #(ADDR_WIDTH) :: type_id :: creage ("cov", this);
    endfunction

    function void connect_phase ( uvm_phase phase );
        super.connect_phase(phase);

        agt_active.mon.port.connect(scb.imp_active);
        agt_passive.mon.port.connect(scb.imp_passive);

        agt_active.mon.port.connect(cov.imp_active);
        agt_passive.mon.port.connect(cov.imp_passive);
    endfunction

endclass

`endif