// Single Cycle CPU
`timescale 1ns / 10ps

import cpu_types::*;

module SingleCycleCPU (
    clk_i,
    rst_i
);

  /* ---------- */
  /* IO Signals */
  /* ---------- */
  input logic clk_i;
  input logic rst_i;

  /* ------------- */
  /* Local Signals */
  /* ------------- */
  // Program Counter
  logic    [REGISTER_LENGTH_64 - 1 : 0] PC;
  // Instruction Memory
  logic    [REGISTER_LENGTH_64 - 1 : 0] address_im;
  logic    [ INSTRUCTION_WIDTH - 1 : 0] instruction;
  // Register File
  logic    [REGISTER_LENGTH_64 - 1 : 0] read_data_1;
  logic    [REGISTER_LENGTH_64 - 1 : 0] read_data_2;
  logic    [      REGISTER_SEL - 1 : 0] read_register_1;
  logic    [      REGISTER_SEL - 1 : 0] read_register_2;
  logic    [      REGISTER_SEL - 1 : 0] write_register;
  logic    [REGISTER_LENGTH_64 - 1 : 0] write_data_rf;
  logic                                 reg_write;
  // ALU
  logic    [REGISTER_LENGTH_64 - 1 : 0] result;
  logic                                 zero;
  logic                                 overflow;
  logic                                 carryout;
  logic                                 negative;
  logic    [ALU_CONTROL_LENGTH - 1 : 0] alu_control;
  logic    [REGISTER_LENGTH_64 - 1 : 0] A;
  logic    [REGISTER_LENGTH_64 - 1 : 0] B;
  // Data Memory
  logic    [REGISTER_LENGTH_64 - 1 : 0] address_dm;
  logic                                 write_enable;
  logic                                 read_enable;
  logic    [REGISTER_LENGTH_64 - 1 : 0] write_data_dm;
  logic    [REGISTER_LENGTH_64 - 1 : 0] read_data_dm;
  // Control Signals
  opcode_t                              instruction_type;


  /* ------------------- */
  /* Combinational Logic */
  /* ------------------- */
  assign address_im = PC;
  assign read_register_1 = instruction[20:16];
  assign read_register_2 = instruction[9:5];
  assign write_register = instruction[4:0];

  /* ---------------- */
  /* Sequential Logic */
  /* ---------------- */

  /* -------------- */
  /* Instantiations */
  /* -------------- */
  control control_unit (
      .instruction_i(instruction),
      .instruction_type_o(instruction_type)
  );

  REGISTER_N program_counter (
      .q_o(PC),
      .d_i(PC + 'h4),
      .enable_i(1'b1),
      .reset_i(rst_i),
      .clk_i(clk_i)

  );

  instructmem instruction_memory (
      .address(address_im),
      .instruction(instruction),
      .clk(clk_i)
  );

  RegisterFile register_file (
      .RD1_o(read_data_1),
      .RD2_o(read_data_2),
      .RR1_i(read_register_1),
      .RR2_i(read_register_2),
      .WR_i(write_register),
      .WD_i(write_data_rf),
      .RegWrite_i(reg_write),
      .reset_i(rst_i),
      .clk_i(clk_i)
  );

  ALU alu (
      .result_o(result),
      .zero_o(zero),
      .overflow_o(overflow),
      .carryout_o(carryout),
      .negative_o(negative),
      .ALUControl_i(alu_control),
      .A_i(A),
      .B_i(B)
  );

  datamem data_memory (
      .address(address_dm),
      .write_enable(write_enable),
      .read_enable(read_enable),
      .write_data(write_data_dm),
      .clk(clk_i),
      .xfer_size(4'b0000),
      .read_data(read_data_dm)
  );

endmodule

