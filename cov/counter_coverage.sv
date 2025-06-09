`ifndef COUNTER_COVERAGE_SV
`define COUNTER_COVERAGE_SV

import counter_package::*;

class counter_coverage #(
    parameter ADDR_WIDTH = P_ADDR_WIDTH
) extends uvm_component;
    `uvm_component_param_utils(counter_coverage #(ADDR_WIDTH))

    `uvm_analysis_imp_decl(_active)
    `uvm_analysis_imp_decl(_passive)

    typedef counter_seq_item #(ADDR_WIDTH)                          TXN;

    bit                                                             reverse, rst_n;
    bit[ADDR_WIDTH-1:0]                                             counter;

    uvm_analysis_imp_active #(TXN, counter_coverage #(ADDR_WIDTH))  imp_active;
    uvm_analysis_imp_passive #(TXN, counter_coverage #(ADDR_WIDTH)) imp_passive;

    counter_config #(ADDR_WIDTH)                                    cfg;

    covergroup  cg;
        cp_counter: coverpoint counter;
        cp_reverse: coverpoint reverse;
        cp_rst:     coverpoint rst_n;
        cross cp_counter, cp_reverse;
    endgroup

    function new ( string name = "counter_coverage", uvm_component parent );
        super.new(name, parent);
        imp_active = new ("imp_active", this);
        imp_passive = new ("imp_passive", this);
        cg = new();

        if ( !uvm_config_db #(counter_config #(ADDR_WIDTH)) :: get (this, "", "cfg", cfg) )
            `uvm_error ("NOCFG", $sformatf("No cfg set for %s.cfg", get_full_name()) )
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
        rst_n   = 1;
        reverse = 0;
        counter = 0;
    endfunction

    function void write_active (TXN txn);
        reverse = txn.reverse;
    endfunction

    function void write_passive (TXN txn);
        rst_n   = txn.rst_n;
        counter = txn.counter;
    endfunction

    virtual task run_phase ( uvm_phase phase );
        forever begin
            @ ( posedge cfg.vif.clk );
            cg.sample();
        end
    endtask

endclass

`endif