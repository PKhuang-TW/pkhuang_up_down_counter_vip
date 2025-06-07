`ifndef COUNTER_AGENT_SV
`define COUNTER_AGENT_SV

import counter_package::*;

class counter_agent #(
    parameter ADDR_WIDTH = P_ADDR_WIDTH
) extends uvm_agent;
    `uvm_component_param_utils(counter_agent #(ADDR_WIDTH))

    uvm_active_passive_enum             agt_mode;

    counter_monitor #(ADDR_WIDTH)       mon;
    counter_driver #(ADDR_WIDTH)        drv;
    uvm_sequencer #(counter_seq_item #(ADDR_WIDTH))   seqr;

    function new (string name = "counter_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if ( !uvm_config_db #(uvm_active_passive_enum) :: get (this, "", "agt_mode", agt_mode) )
            `uvm_error ("NOCFG", $sformatf("No agt_mode set for %s.agt_mode", get_full_name()) )

        uvm_config_db #(uvm_active_passive_enum) :: set (this, "mon", "agt_mode", agt_mode);

        mon = counter_monitor #(ADDR_WIDTH) :: type_id :: create ("mon", this);
        if (agt_mode == UVM_ACTIVE) begin
            drv = counter_driver #(ADDR_WIDTH) :: type_id :: create ("drv", this);
            seqr = uvm_sequencer #(counter_seq_item #(ADDR_WIDTH)) :: type_id :: create ("seqr", this);
        end
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        if (agt_mode == UVM_ACTIVE)
            drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
endclass

`endif