`ifndef COUNTER_SCOREBOARD_SV
`define COUNTER_SCOREBOARD_SV

class counter_scoreboard #(
    parameter   ADDR_WIDTH = counter_package::ADDR_WIDTH
) extends uvm_scoreboard;
    `uvm_component_param_utils(counter_scoreboard)

    typedef counter_seq_item #(ADDR_WIDTH)      TXN;

    bit                                         up_en;
    bit[ADDR_WIDTH-1:0]                         counter;
    TXN                                         q_passive[$];
    uvm_analysis_imp#(TXN, counter_scoreboard)  imp_active, imp_passive;

    function new ( string name = "counter_scoreboard", uvm_component parent );
        super.new(name, parent);
    endfunction

    function build_phase ( uvm_phase phase );
        super.build_phase(phase);
        imp_active = new("imp_active", this);
        imp_passive = new("imp_passive", this);
        up_en = 1;
        counter = 0;
    endfunction

    virtual function write_imp_active ( TXN txn );
        if ( txn.rst ) begin
            up_en   = 'd1;
            counter = 'd0;
        end else begin
            // counter
            if ( (up_en && counter != 'd7) || (!up_en && counter == 'd0) ) begin
                counter = counter + 1;
            end else begin
                counter = counter - 1;
            end
            
            // up_en
            if ( txn.reverse ) begin
                up_en = ~up_en;
            end else if (up_en && counter == 'd7) begin
                up_en = 0;
            end else if (!up_en && counter == 'd0) begin
                up_end = 1;
            end
        end

        check_result();
    endfunction

    virtual function write_imp_passive ( TXN txn );
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