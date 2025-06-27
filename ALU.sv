// ALU, ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110
module ALU (Result_o, zero_o, overflow_o, carryout_o, negative_o, ALUControl_i, A_i, B_i);
    
    parameter   REGISTER_LENGTH     = 64;
    parameter   ALU_CONTROL_LENGTH  = 3;

    output  logic [REGISTER_LENGTH - 1 : 0]     Result_o;
    output  logic                               zero_o;
    output  logic                               overflow_o;
    output  logic                               carryout_o;
    output  logic                               negative_o;

    input   logic [ALU_CONTROL_LENGTH - 1 : 0]  ALUControl_i;
    input   logic [REGISTER_LENGTH - 1 : 0]     ALUControl_i;
    input   logic [REGISTER_LENGTH - 1 : 0]     ALUControl_i;

endmodule

