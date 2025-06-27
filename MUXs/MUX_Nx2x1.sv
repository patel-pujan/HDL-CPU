// N length 2x1 Mux
`timescale 1ns/10ps

module MUX_Nx2x1(outputs_o, inputs_i, select_i);

    parameter   INPUT_LENGTH    = 64;
    parameter   INPUT_WIDTH     = 2;

    output  logic [INPUT_LENGTH - 1 : 0]                        outputs_o;

    input   logic [INPUT_WIDTH - 1 : 0] [INPUT_LENGTH - 1 : 0]  inputs_i;
    input   logic                                               select_i;

    
    genvar i;
    generate

        for (i = 0; i < INPUT_LENGTH; i++)
            MUX_2x1  mux_i   (.out_o(outputs_o[i]), .in_zero_i(inputs_i[0][i]), .in_one_i(inputs_i[1][i]), .select_i(select_i));
 
    endgenerate

endmodule

