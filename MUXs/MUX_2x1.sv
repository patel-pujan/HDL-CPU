// 2x1 Mux
`timescale 1ns/10ps

module MUX_2x1 (out_o, in_zero_i, in_one_i, select_i);

    // parameter   DELAY   = 0;

    output  logic   out_o;
    
    input   logic   in_zero_i;
    input   logic   in_one_i;
    input   logic   select_i;

    logic           not_select;
    logic           and_zero;
    logic           and_one;
    

    not     NOT_SELECT  (not_select, select_i);
    
    and     AND_ZERO    (and_zero, in_zero_i, not_select);
    and     AND_ONE     (and_one, in_one_i, select_i);

    or      OR_OUT      (out_o, and_zero, and_one);

endmodule

