// N bit Adder & Subtractor
`timescale 1ns/10ps

module Full_Adder_N(S_o, C_out_o, A_i, B_i, C_in_i);
    
    parameter   REGISTER_WIDTH              = 64;

    output  logic [REGISTER_WIDTH - 1 : 0]  S_o;
    output  logic [REGISTER_WIDTH - 1 : 0]  C_out_o;
    
    input   logic [REGISTER_WIDTH - 1 : 0]  A_i;
    input   logic [REGISTER_WIDTH - 1 : 0]  B_i;
    input   logic                           C_in_i;
     

    
    Full_Adder  fa_i    (.S_o(S_o[0]), .C_out_o(C_out_o[0]), .A_i(A_i[0]), .B_i(B_i[0]), .C_in_i(C_in_i));
    genvar i;
    generate
        for(i = 1; i < REGISTER_WIDTH; i++) begin
            Full_Adder  fa_i    (.S_o(S_o[i]), .C_out_o(C_out_o[i]), .A_i(A_i[i]), .B_i(B_i[i]), .C_in_i(C_out_o[i-1]));
        end
    endgenerate

endmodule

