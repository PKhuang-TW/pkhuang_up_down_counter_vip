module up_down_counter (
    input   wire        clk,
    input   wire        rst_n,
    input   wire        reverse,
    output  reg[2:0]    counter
);
    reg     up_en;

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n)
            up_en   <= 1'b1;
        else if (reverse)
            up_en <= ~up_en;
        else if (up_en && counter == 3'd7)
            up_en <= 1'b0;
        else if (!up_en && counter == 3'd0)
            up_en <= 1'b1;
    end
    
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n)
            counter <= 0;
        else if ( (up_en && counter != 3'd7) || (!up_en && counter == 3'd0) )
            counter <= counter + 3'd1;
        else
            counter <= counter - 3'd1;
    end
endmodule