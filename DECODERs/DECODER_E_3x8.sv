// 3x8 Enabled Decoder
`timescale 1ns/10ps

module DECODER_E_3x8 (out_o, in_i, enable_i);
    
    parameter   INPUT_LENGTH    = 3;
    parameter   OUTPUT_WIDTH    = 2 ** INPUT_LENGTH; 
    
    output  logic   [OUTPUT_WIDTH - 1 : 0]  out_o;
    
    input   logic   [INPUT_LENGTH - 1 : 0]  in_i;
    input   logic                           enable_i;
    
    logic   [1 : 0]                         temp;


    DECODER_E_1x2   d1  (.out_o(temp), .in_i(in_i[2]), .enable_i(enable_i));
    DECODER_E_2x4   d2  (.out_o(out_o[3:0]), .in_i(in_i[1:0]), .enable_i(temp[0]));
    DECODER_E_2x4   d3  (.out_o(out_o[7:4]), .in_i(in_i[1:0]), .enable_i(temp[1]));
     
endmodule

