`ifndef NEVER_RERVERSE_SEQ_SV
`define NEVER_RERVERSE_SEQ_SV

import counter_package::*;

class never_reverse_seq #(
    parameter ADDR_WIDTH = P_ADDR_WIDTH
) extends uvm_sequence #(counter_seq_item #(ADDR_WIDTH));
    `uvm_object_param_utils(never_reverse_seq)

    typedef counter_seq_item #(ADDR_WIDTH)      TXN;

    function new ( string name = "never_reverse_seq" );
        super.new(name);
    endfunction

    virtual task body();
        TXN txn;

        for ( int i=0; i<100; i++ ) begin
            txn = TXN :: type_id :: create ("txn");
            if ( !txn.randomize() with {
                txn.reverse == 0;
            } ) begin
                `uvm_error( "RANDERR", "txn randomize error!")
            end
            // txn.print();
            start_item(txn);
            finish_item(txn);
        end
    endtask

endclass

`endif