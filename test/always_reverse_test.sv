`ifndef ALWAYS_REVERSE_TEST_SV
`define ALWAYS_REVERSE_TEST_SV

import counter_package::*;

class always_reverse_test extends counter_test_base #(P_ADDR_WIDTH);
    `uvm_component_utils(always_reverse_test)

    always_reverse_seq #(ADDR_WIDTH)  seq;

    function new ( string name = "always_reverse_test", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
    endfunction

    virtual task run_phase ( uvm_phase phase );
        // counter_sequence #(ADDR_WIDTH) seq;
        seq = always_reverse_seq #(ADDR_WIDTH) :: type_id :: create ("seq");

        phase.raise_objection(this);
        seq.start ( env.agt_active.seqr );
        phase.drop_objection(this);
    endtask
endclass

`endif