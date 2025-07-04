// N Bit OR
`timescale 1ns/10ps

module OR_N (out_o, A_i, B_i);
    
    parameter   REGISTER_LENGTH                 = 64;

    output  logic [REGISTER_LENGTH - 1 : 0]     out_o; 

    input   logic [REGISTER_LENGTH - 1 : 0]     A_i;
    input   logic [REGISTER_LENGTH - 1 : 0]     B_i;
    
   
    genvar i;
    generate
        for (i = 0; i < REGISTER_LENGTH; i++) begin
            or  or_i    (out_o[i], A_i[i], B_i[i]);
        end
    endgenerate

endmodule

