`ifndef COUNTER_MONITOR_SV
`define COUNTER_MONITOR_SV

class counter_monitor #(
    parameter ADDR_WIDTH = 3
) extends uvm_monitor;
    `uvm_component_param_utils(counter_monitor)

    typedef counter_seq_item #(ADDR_WIDTH)  TXN;
    
    uvm_active_passive_enum                 agt_mode;
    counter_config #(ADDR_WIDTH)            cfg;
    virtual counter_interface #(ADDR_WIDTH) vif;

    uvm_analysis_port #(TXN)                port;

    TXN                                     txn;

    function new (string name = "counter_monitor", uvm_component parent);
        super.new(name, parent);
        port = new("port", this);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if ( !uvm_config_db #(uvm_active_passive_enum) :: get (this, "", "agt_mode", agt_mode) )
            `uvm_error( "NOCFG", $sformatf("No agt_mode set for %s.agt_mode", get_full_name()) )

        if ( !uvm_config_db #(counter_config #(ADDR_WIDTH)) :: get (this, "", "cfg", cfg) )
            `uvm_error( "NOCFG", $sformatf("No cfg set for %s.cfg", get_full_name()) )
        
        vif = cfg.vif;
    endfunction

    virtual task run_phase ( uvm_phase phase );
        // TXN     txn;
        forever begin
            @(posedge vif.clk);
            txn = TXN :: type_id :: create ("txn");

            if ( vif.rst_n ) begin
                if ( agt_mode == UVM_ACTIVE ) begin
                    txn.reverse = vif.reverse;
                end else begin  // agt_mode == UVM_PASSIVE
                    txn.counter = vif.counter;
                end
            end else begin
                txn.rst = 1;
            end
            port.write(txn);
        end
    endtask
endclass

`endif