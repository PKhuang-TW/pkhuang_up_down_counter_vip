`ifndef COUNTER_DRIVER_SV
`define COUNTER_DRIVER_SV

class counter_driver #(
    parameter   ADDR_WIDTH = counter_package::ADDR_WIDTH
) extends uvm_driver;
    `uvm_component_param_utils(counter_driver)

    typedef counter_seq_item #(ADDR_WIDTH)      TXN;

    counter_config #(ADDR_WIDTH)                cfg;
    virtual counter_interface #(ADDR_WIDTH)     vif;

    function new (string name = "counter_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function build_phase (uvm_phase phase);
        super.build_phase(phase);

        if ( !uvm_config_db #(counter_config #(ADDR_WIDTH)) :: get (this, "", "cfg", cfg) )
            `uvm_error( "NOCFG", $sformatf("No cfg set for %s.cfg", get_full_name()) )

        vif = cfg.vif;
    endfunction

    virtual task run_phase( uvm_phase phase );
        super.run_phase();
        TXN     txn;

        forever begin
            @ ( posedge vif.clk );
            if ( vif.rst_n ) begin
                txn = TXN :: type_id :: create("txn");
                seq_item_port.get_next_item(txn);
                vif.reverse <= txn.reverse;
                seq_item_port.item_done();
            end
        end
    endtask

endclass

`endif