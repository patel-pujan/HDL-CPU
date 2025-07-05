// 1 bit Full Adder
`timescale 1ns/10ps

module Full_Adder(S_o, C_out_o, A_i, B_i, C_in_i);

    output  logic   S_o;
    output  logic   C_out_o;
    
    input   logic   A_i;
    input   logic   B_i;
    input   logic   C_in_i;

    logic           AB;
    logic           BC_in;
    logic           AC_in;


    and     and_ab      (AB, A_i, B_i);
    and     and_bc      (BC_in, B_i, C_in_i);
    and     and_ac      (AC_in, A_i, C_in_i);

    or      or_c_out    (C_out_o, AB, BC_in, AC_in);
    xor     xor_s       (S_o, A_i, B_i, C_in_i);

endmodule

