// 32 x 64 Register File
`timescale 1ns/10ps

module RegisterFile (RD1_o, RD2_o, RR1_i, RR2_i, WR_i, WD_i, RegWrite_i, reset_i, clk_i);

    parameter   REGISTER_LENGTH     = 64;
    parameter   REGISTER_WIDTH      = 32;
    parameter   REGISTER_SEL        = $clog2(REGISTER_WIDTH);

    output  logic [REGISTER_LENGTH - 1 : 0]                     RD1_o;
    output  logic [REGISTER_LENGTH - 1 : 0]                     RD2_o;
    
    input   logic [REGISTER_SEL - 1 : 0]                        RR1_i;
    input   logic [REGISTER_SEL - 1 : 0]                        RR2_i;
    input   logic [REGISTER_SEL - 1 : 0]                        WR_i;
    input   logic [REGISTER_LENGTH - 1 : 0]                     WD_i;
    input   logic                                               RegWrite_i;
    input   logic                                               reset_i;
    input   logic                                               clk_i;

    logic [REGISTER_WIDTH - 1 : 0] [REGISTER_LENGTH - 1 : 0]    regFile;
    /* verilator lint_off UNUSEDSIGNAL */
    logic [REGISTER_WIDTH - 1 : 0]                              regEnables;
    /* verilator lint_on UNUSEDSIGNAL */
    
    genvar i;
    generate
        
        for (i = 0; i < REGISTER_WIDTH - 1; i++) begin
            
            REGISTER_N  reg_i   (.q_o(regFile[i]), .d_i(WD_i), .enable_i(regEnables[i]), .reset_i(reset_i), .clk_i(clk_i));

        end

    endgenerate
    
    assign regFile[31] = '0;

    DECODER_E_5x32  d1  (.out_o(regEnables), .in_i(WR_i), .enable_i(RegWrite_i));
    MUX_Nx32x1      m1  (.outputs_o(RD1_o), .inputs_i(regFile), .selects_i(RR1_i));
    MUX_Nx32x1      m2  (.outputs_o(RD2_o), .inputs_i(regFile), .selects_i(RR2_i));

endmodule

