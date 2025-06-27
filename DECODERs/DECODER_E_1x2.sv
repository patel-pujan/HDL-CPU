// 1x2 Enabled Decoder
`timescale 1ns/10ps

module DECODER_E_1x2 (out_o, in_i, enable_i);
    
    // parameter   DELAY           = 50; 
    parameter   INPUT_LENGTH    = 1;
    parameter   OUTPUT_WIDTH    = 2 ** INPUT_LENGTH; 
    
    output  logic   [OUTPUT_WIDTH - 1 : 0]  out_o;
    
    input   logic   [INPUT_LENGTH - 1 : 0]  in_i;
    input   logic                           enable_i;

    logic           not_in;
    
    not     NOT_IN      (not_in, in_i);
    
    and     AND_ZERO    (out_o[0], not_in, enable_i);
    and     AND_ONE     (out_o[1], in_i, enable_i);

endmodule

