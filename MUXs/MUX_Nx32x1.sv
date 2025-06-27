// N length 32x1 Mux
`timescale 1ns/10ps

module MUX_Nx32x1(outputs_o, inputs_i, selects_i);

    parameter   INPUT_LENGTH    = 64;
    parameter   INPUT_WIDTH     = 32;
    parameter   SELECT_WIDTH    = $clog2(INPUT_WIDTH);

    output  logic [INPUT_LENGTH - 1 : 0]                        outputs_o;

    input   logic [INPUT_WIDTH - 1 : 0] [INPUT_LENGTH - 1 : 0]  inputs_i;
    input   logic [SELECT_WIDTH - 1 : 0]                        selects_i;
    
    logic [1 : 0] [INPUT_LENGTH - 1 : 0]         temp;
    

    MUX_Nx16x1  m1  (.outputs_o(temp[0]), .inputs_i(inputs_i[15:0]), .selects_i(selects_i[3:0]));
    MUX_Nx16x1  m2  (.outputs_o(temp[1]), .inputs_i(inputs_i[31:16]), .selects_i(selects_i[3:0]));
    MUX_Nx2x1   m3  (.outputs_o(outputs_o), .inputs_i(temp), .select_i(selects_i[4]));

endmodule

