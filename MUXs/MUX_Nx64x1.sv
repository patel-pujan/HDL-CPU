// N length 64x1 Mux
`timescale 1ns/10ps

module MUX_Nx64x1(outputs_o, inputs_i, selects_i);

    parameter   INPUT_LENGTH    = 64;
    parameter   INPUT_WIDTH     = 64;
    parameter   SELECT_WIDTH    = $clog2(INPUT_WIDTH);

    output  logic [INPUT_LENGTH - 1 : 0]                        outputs_o;

    input   logic [INPUT_WIDTH - 1 : 0] [INPUT_LENGTH - 1 : 0]  inputs_i;
    input   logic [SELECT_WIDTH - 1 : 0]                        selects_i;
    
    logic [1 : 0] [INPUT_LENGTH - 1 : 0]         temp;
    

    MUX_Nx32x1  m1  (.outputs_o(temp[0]), .inputs_i(inputs_i[31:0]), .selects_i(selects_i[4:0]));
    MUX_Nx32x1  m2  (.outputs_o(temp[1]), .inputs_i(inputs_i[63:32]), .selects_i(selects_i[4:0]));
    MUX_Nx2x1   m3  (.outputs_o(outputs_o), .inputs_i(temp), .select_i(selects_i[5]));

endmodule

