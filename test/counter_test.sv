`ifndef COUNTER_TEST_SV
`define COUNTER_TEST_SV

import counter_package::*;

class counter_test extends counter_test_base #(P_ADDR_WIDTH);
    `uvm_component_utils(counter_test)

    function new ( string name = "counter_test", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
    endfunction

    virtual task run_phase ( uvm_phase phase );
        // counter_sequence #(ADDR_WIDTH) seq;
        seq = counter_sequence #(ADDR_WIDTH) :: type_id :: create ("seq");

        phase.raise_objection(this);
        seq.start ( env.agt_active.seqr );
        #100ns;
        phase.drop_objection(this);
    endtask
endclass

`endif