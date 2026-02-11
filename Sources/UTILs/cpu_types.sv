
package cpu_types;

  parameter int REGISTER_LENGTH_64 = 64;
  parameter int REGISTER_WIDTH = 32;
  parameter int INSTRUCTION_WIDTH = 32;
  parameter int REGISTER_SEL = $clog2(REGISTER_WIDTH);
  parameter int ALU_CONTROL_LENGTH = 3;
  parameter int CONTROL_WIDTH = 3;
  parameter int OPCODE_RD = 11;
  parameter int OPCODE_I = 10;
  parameter int OPCODE_B = 6;
  parameter int OPCODE_CB = 8;

  typedef enum logic [3:0] {
    INVALID,
    ADDI,
    ADDS,
    B,
    B_LT,  // MISSING
    CBZ,
    LDUR,
    LSL,
    LSR,
    MUL,  // MISSING
    STUR,
    SUBS
  } opcode_t;

  typedef struct packed {
    logic [ALU_CONTROL_LENGTH - 1 : 0] alu_op;
    logic B_mux;
    logic RW_mux;
    logic RW;
  } control_t;

endpackage

