`ifndef COUNTER_TEST_SV
`define COUNTER_TEST_SV

import counter_package::*;

class rand_reverse_test extends counter_test_base #(P_ADDR_WIDTH);
    `uvm_component_utils(rand_reverse_test)

    rand_reverse_seq #(ADDR_WIDTH)  seq;

    function new ( string name = "rand_reverse_test", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
    endfunction

    virtual task run_phase ( uvm_phase phase );
        // rand_reverse_seq #(ADDR_WIDTH) seq;
        seq = rand_reverse_seq #(ADDR_WIDTH) :: type_id :: create ("seq");

        phase.raise_objection(this);
        seq.start ( env.agt_active.seqr );
        #100ns;
        phase.drop_objection(this);
    endtask
endclass

`endif