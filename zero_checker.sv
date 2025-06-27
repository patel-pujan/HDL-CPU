// N Bit Zero Checker
module zero_checker (flag_o, in_i);
    
    parameter   REGISTER_LENGTH     = 64;

    output  logic                               flag_o; 

    input   logic [REGISTER_LENGTH - 1 : 0]     in_i;



endmodule

