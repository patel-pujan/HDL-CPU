// Control Unit for CPU
`timescale 1ns / 10ps

import cpu_types::*;

module control (
    instruction_i,
    instruction_type_o,
    control_o
);

  /* ---------- */
  /* Parameters */
  /* ---------- */

  /* ---------- */
  /* IO Signals */
  /* ---------- */
  output opcode_t instruction_type_o;
  output control_t control_o;

  input logic [INSTRUCTION_WIDTH - 1 : 0] instruction_i;

  /* ------------- */
  /* Local Signals */
  /* ------------- */
  logic [OPCODE_RD - 1 : 0] opcode_rd;
  logic [ OPCODE_I - 1 : 0] opcode_i;
  logic [ OPCODE_B - 1 : 0] opcode_b;
  logic [OPCODE_CB - 1 : 0] opcode_cb;

  /* ------------------- */
  /* Combinational Logic */
  /* ------------------- */
  assign opcode_rd = instruction_i[31 : 21];
  assign opcode_i  = instruction_i[31 : 22];
  assign opcode_b  = instruction_i[31 : 26];
  assign opcode_cb = instruction_i[31 : 24];

  always_comb begin
    instruction_type_o = INVALID;

    unique case (1'b1)
      (opcode_i == 10'b1001000100): begin  // ADDI
        instruction_type_o = ADDI;
      end
      (opcode_i == 11'b10101011000): begin  // ADDS
        instruction_type_o = ADDS;
      end
      (opcode_b == 6'b000101): begin  // B
        instruction_type_o = B;
      end
      (opcode_cb == 8'b10110100): begin  // CBZ
        instruction_type_o = CBZ;
      end
      (opcode_rd == 11'b11111000010): begin  // LDUR
        instruction_type_o = LDUR;
      end
      (opcode_rd == 11'b11010011011): begin  // LSL
        instruction_type_o = LSL;
      end
      (opcode_rd == 11'b11010011010): begin  // LSR
        instruction_type_o = LSR;
      end
      (opcode_rd == 11'b11010011010): begin  // LSR
        instruction_type_o = LSR;
      end
      (opcode_rd == 11'b11111000000): begin  // STUR
        instruction_type_o = STUR;
      end
      (opcode_rd == 11'b11101011000): begin  // SUBS
        instruction_type_o = SUBS;
      end
      default: ;
    endcase
  end

endmodule

