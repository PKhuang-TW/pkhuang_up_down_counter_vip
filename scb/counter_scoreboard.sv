`ifndef COUNTER_SCOREBOARD_SV
`define COUNTER_SCOREBOARD_SV

import counter_package::*;

`uvm_analysis_imp_decl(_active)
`uvm_analysis_imp_decl(_passive)

class counter_scoreboard #(
    parameter ADDR_WIDTH = P_ADDR_WIDTH
) extends uvm_scoreboard;
    `uvm_component_param_utils(counter_scoreboard)

    typedef counter_seq_item #(ADDR_WIDTH)      TXN;

    counter_config #(ADDR_WIDTH)                cfg;
    virtual counter_interface #(ADDR_WIDTH)     vif;

    bit                                         up_en, rst_n;
    bit[ADDR_WIDTH-1:0]                         counter;
    TXN                                         q_passive[$];
    uvm_analysis_imp_active #(TXN, counter_scoreboard #(ADDR_WIDTH))  imp_active;
    uvm_analysis_imp_passive #(TXN, counter_scoreboard #(ADDR_WIDTH))  imp_passive;

    function new ( string name = "counter_scoreboard", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
        imp_active = new("imp_active", this);
        imp_passive = new("imp_passive", this);
        rst_n   = 1;
        up_en   = 1;
        counter = 0;

        if ( !uvm_config_db #(counter_config #(ADDR_WIDTH)) :: get (this, "", "cfg", cfg) )
            `uvm_error ("NOCFG", $sformatf("No cfg set for %s.cfg", get_full_name()) )

        vif = cfg.vif;
    endfunction

    virtual task void run_phase ( uvm_phase phase );
        forever begin
            @ ( posedge vif.clk );
            
            if ( rst_n ) begin
                // counter
                if ( (up_en && counter != 'd7) || (!up_en && counter == 'd0) ) begin
                    counter <= counter + 1;
                end else begin
                    counter <= counter - 1;
                end
                
                // up_en
                if (up_en && counter == 'd7) begin
                    up_en <= 0;
                end else if (!up_en && counter == 'd0) begin
                    up_en <= 1;
                end
            end else begin
                up_en   <= 'd1;
                counter <= 'd0;
            end

            check_result();
        end
    endtask

    virtual function void write_active ( TXN txn );
        if ( rst_n && txn.reverse ) begin
            up_en <= ~up_en;
        end
    endfunction

    virtual function void write_passive ( TXN txn );
        rst_n = txn.rst_n;
        q_passive.push_back(txn);
    endfunction

    function void check_result();
        TXN txn;
        if (q_passive.size()) begin
            txn = q_passive.pop_front();

            if ( txn.counter != counter ) begin
                `uvm_error(
                    "SCB",
                    $sformatf("Counter mismatch! Expected: %0d, Got: %0d", counter, txn.counter)
                )
            end
        end
    endfunction
endclass


`endif