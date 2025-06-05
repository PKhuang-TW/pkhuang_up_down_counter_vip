`ifndef COUNTER_SEQ_ITEM_SV
`define COUNTER_SEQ_ITEM_SV

class counter_seq_item #(
    parameter ADDR_WIDTH = 3
) extends uvm_sequence_item;

    rand    bit             reverse;

    bit                     rst;
    bit[ADDR_WIDTH-1:0]     counter;

    `uvm_object_param_utils_begin(counter_seq_item #(ADDR_WIDTH))
        `uvm_field_int(rst, UVM_ALL_ON)
        `uvm_field_int(reverse, UVM_ALL_ON)
        `uvm_field_int(counter, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name = "counter_seq_item");
        super.new(name);
    endfunction
endclass

`endif