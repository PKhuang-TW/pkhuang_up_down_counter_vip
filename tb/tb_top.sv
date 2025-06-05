`timescale 1ns/1ps

parameter   P_ADDR_WIDTH    = 3;

`include "counter_interface.sv"

`include "counter_package.svh"
import counter_package::*;

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

        uvm_config_db #(virtual counter_interface #(P_ADDR_WIDTH)) :: set :: ( uvm_root::get(), "uvm_test_top", "vif", vif );

        run_test("counter_test_base");
    end

endmodule