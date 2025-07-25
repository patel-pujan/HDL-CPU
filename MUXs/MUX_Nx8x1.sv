// N length 8x1 Mux
`timescale 1ns/10ps

module MUX_Nx8x1(outputs_o, inputs_i, selects_i);

    parameter   INPUT_LENGTH    = 64;
    parameter   INPUT_WIDTH     = 8;
    parameter   SELECT_WIDTH    = $clog2(INPUT_WIDTH);

    output  logic [INPUT_LENGTH - 1 : 0]                        outputs_o;

    input   logic [INPUT_WIDTH - 1 : 0] [INPUT_LENGTH - 1 : 0]  inputs_i;
    input   logic [SELECT_WIDTH - 1 : 0]                        selects_i;
    
    // logic [SELECT_WIDTH - 1 : 0] [INPUT_LENGTH - 1 : 0]         temp;
    logic [1 : 0] [INPUT_LENGTH - 1 : 0]         temp;
    

    MUX_Nx4x1   m1  (.outputs_o(temp[0]), .inputs_i(inputs_i[3:0]), .selects_i(selects_i[1:0]));
    MUX_Nx4x1   m2  (.outputs_o(temp[1]), .inputs_i(inputs_i[7:4]), .selects_i(selects_i[1:0]));
    MUX_Nx2x1   m3  (.outputs_o(outputs_o), .inputs_i(temp), .select_i(selects_i[2]));

endmodule

