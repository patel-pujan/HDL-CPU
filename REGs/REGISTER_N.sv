// Enabled N bit Register
`timescale 1ns/10ps

module REGISTER_N (q_o, d_i, enable_i, reset_i, clk_i);

    parameter   REG_LENGTH    = 64;

    output  logic   [REG_LENGTH - 1 : 0]     q_o; 
    
    input   logic   [REG_LENGTH - 1 : 0]     d_i;
    input   logic                            enable_i;
    input   logic                            reset_i;
    input   logic                            clk_i;


    genvar i;
    generate
        
        for (i = 0; i < REG_LENGTH; i++)
            
            E_D_FF  e_d_ff_i (.q_o(q_o[i]), .d_i(d_i[i]), .enable_i(enable_i), .reset_i(reset_i), .clk_i(clk_i));
            
    endgenerate

endmodule

