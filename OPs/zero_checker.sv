// N Bit Zero Checker
`timescale 1ns/10ps

module zero_checker (flag_o, in_i);
    
    parameter   REGISTER_LENGTH     = 64;

    output  logic                               flag_o; 

    input   logic [REGISTER_LENGTH - 1 : 0]     in_i;

    logic [REGISTER_LENGTH : 0]             temp;

    
    assign temp[0] = 1'b0;
    
    not     not_one     (flag_o, temp[REGISTER_LENGTH]);
    
    genvar i;
    generate
        for (i = 0; i < REGISTER_LENGTH; i++) begin
            or  or_i    (temp[i+1], in_i[i], temp[i]);
        end
    endgenerate

endmodule

