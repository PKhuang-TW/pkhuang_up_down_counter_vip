`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "counter_interface.sv"
`include "counter_package.svh"
import counter_package::*;

`include "counter_config.sv"
`include "counter_seq_item.sv"
`include "counter_monitor.sv"
`include "counter_driver.sv"
`include "counter_agent.sv"
`include "counter_scoreboard.sv"
`include "counter_env.sv"
`include "counter_sequence.sv"
`include "counter_test_base.sv"

module tb_top;

    logic clk, rst_n;

    always #5 clk = ~clk;

    counter_interface #(P_ADDR_WIDTH)     vif ( clk, rst_n );

    up_down_counter dut (
        .clk        ( clk ),
        .rst_n      ( rst_n ),
        .reverse    ( vif.reverse ),
        .counter    ( vif.counter )
    );

    initial begin
        clk = 0;
        rst_n = 0;

        #10;
        rst_n = 1;

        uvm_config_db #(virtual counter_interface #(P_ADDR_WIDTH)) :: set ( null, "uvm_test_top", "vif", vif );

        run_test("counter_test_base");
    end

    initial begin
        $fsdbDumpfile("wave.fsdb");
        $fsdbDumpvars;
    end

endmodule