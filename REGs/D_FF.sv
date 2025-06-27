// D Flip Flop
`timescale 1ns/10ps

module D_FF (q, d, reset, clk);

    output  reg     q;
    
    input   reg     d;
    input   reg     reset;
    input   reg     clk;


    always_ff @(posedge clk)
        
        if (reset)
            q <= 0;
        else
            q <= d;

endmodule
