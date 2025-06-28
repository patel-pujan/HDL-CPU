// N Bit AND
module AND_N (out_o, in_i);
    
    parameter   GATE_WIDTH  = 64;

    output  logic                       out_o; 

    input   logic [GATE_WIDTH - 1 : 0]  in_i;

    logic [GATE_WIDTH : 0]              temp;

    
    assign temp[0] = 1'b1;
    
    assign out_o = temp[GATE_WIDTH]; 
    
    genvar i;
    generate
        for (i = 0; i < GATE_WIDTH; i++) begin
            and     and_i   (temp[i+1], in_i[i], temp[i]);
        end
    endgenerate

endmodule

