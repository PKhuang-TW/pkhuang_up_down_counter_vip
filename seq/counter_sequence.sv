`ifndef COUNTER_SEQUENCE_SV
`define COUNTER_SEQUENCE_SV

class counter_sequence #(
    parameter   ADDR_WIDTH = counter_package::ADDR_WIDTH
) extends uvm_sequence #(counter_seq_item #(ADDR_WIDTH));
    `uvm_object_param_utils(counter_sequence)

    typedef counter_seq_item #(ADDR_WIDTH)      TXN;

    function new ( string name = "counter_sequence" );
        super.new(name);
    endfunction

    virtual task body();
        TXN txn;

        for ( int i=0; i<50; i++ ) begin
            txn = TXN :: type_id :: create ("txn");
            if ( !txn.randomize() )
                `uvm_error( "RANDERR", "txn randomize error!")
            start_item(txn);
            finish_item(txn);
        end
    endtask

endclass

`endif