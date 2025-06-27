// Enabled D_FF
`timescale 1ns/10ps

module E_D_FF (q_o, d_i, enable_i, reset_i, clk_i);
    
    output  logic   q_o;

    input   logic   d_i;
    input   logic   enable_i;
    input   logic   reset_i;
    input   logic   clk_i;

    logic           m_q;

    MUX_2x1     m1      (.out_o(m_q), .in_zero_i(q_o), .in_one_i(d_i), .select_i(enable_i));
    D_FF        d1      (.q(q_o), .d(m_q), .reset(reset_i), .clk(clk_i));

endmodule
