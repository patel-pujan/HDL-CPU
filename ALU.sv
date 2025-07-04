// ALU, ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110
`timescale 1ns/10ps

module ALU (result_o, zero_o, overflow_o, carryout_o, negative_o, ALUControl_i, A_i, B_i);
    
    parameter   REGISTER_LENGTH                 = 64;
    parameter   ALU_CONTROL_LENGTH              = 3;

    output  logic [REGISTER_LENGTH - 1 : 0]     result_o;
    output  logic                               zero_o;
    output  logic                               overflow_o;
    output  logic                               carryout_o;
    output  logic                               negative_o;

    input   logic [ALU_CONTROL_LENGTH - 1 : 0]  ALUControl_i;
    input   logic [REGISTER_LENGTH - 1 : 0]     A_i;
    input   logic [REGISTER_LENGTH - 1 : 0]     B_i;
    
    logic [REGISTER_LENGTH - 1 : 0]             B_not;
    logic [REGISTER_LENGTH - 1 : 0]             cout_add;
    logic [REGISTER_LENGTH - 1 : 0]             cout_sub;
    /* verilator lint_off UNUSEDSIGNAL */
    logic [REGISTER_LENGTH - 1 : 0]             cout;
    /* verilator lint_on UNUSEDSIGNAL */
    logic [7 : 0] [REGISTER_LENGTH - 1 : 0]     op_matrix;


    genvar i;
    generate
        for (i = 0; i < REGISTER_LENGTH; i++)
            not     not_b_i     (B_not[i], B_i[i]);
    endgenerate
    
    Full_Adder_N    add_res     (.S_o(op_matrix[2]), .C_out_o(cout_add), .A_i(A_i), .B_i(B_i), .C_in_i(1'b0));
    Full_Adder_N    sub_res     (.S_o(op_matrix[3]), .C_out_o(cout_sub), .A_i(A_i), .B_i(B_not), .C_in_i(1'b1));
    
    AND_N           and_res     (.out_o(op_matrix[4]), .A_i(A_i), .B_i(B_i));
    OR_N            or_res      (.out_o(op_matrix[5]), .A_i(A_i), .B_i(B_i));
    XOR_N           xor_res     (.out_o(op_matrix[6]), .A_i(A_i), .B_i(B_i));

    assign op_matrix[0] = B_i;
    assign op_matrix[1] = '0;
    assign op_matrix[7] = '0;

    MUX_Nx8x1       res_mux     (.outputs_o(result_o), .inputs_i(op_matrix), .selects_i(ALUControl_i));
    MUX_Nx2x1       cout_mux    (.outputs_o(cout), .inputs_i({cout_sub, cout_add}), .select_i(ALUControl_i[0]));
     
    zero_checker    zflag       (.flag_o(zero_o), .in_i(result_o));
    xor             xor_of      (overflow_o, cout[63], cout[62]);
    assign carryout_o = cout[63];
    assign negative_o = result_o[63];


endmodule

