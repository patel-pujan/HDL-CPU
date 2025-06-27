// 5x32 Enabled Decoder
`timescale 1ns/10ps

module DECODER_E_5x32 (out_o, in_i, enable_i);
    
    parameter   INPUT_LENGTH    = 5;
    parameter   OUTPUT_WIDTH    = 2 ** INPUT_LENGTH; 
    
    output  logic   [OUTPUT_WIDTH - 1 : 0]  out_o;
    
    input   logic   [INPUT_LENGTH - 1 : 0]  in_i;
    input   logic                           enable_i;
    
    logic   [1 : 0]                         temp;


    DECODER_E_1x2   d1  (.out_o(temp), .in_i(in_i[4]), .enable_i(enable_i));
    DECODER_E_4x16  d2  (.out_o(out_o[15:0]), .in_i(in_i[3:0]), .enable_i(temp[0]));
    DECODER_E_4x16  d3  (.out_o(out_o[31:16]), .in_i(in_i[3:0]), .enable_i(temp[1]));
     
endmodule

