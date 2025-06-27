#define MODULENAME RegisterFile

#define STRINGIFY(x) #x
#define TOSTRING(x) STRINGIFY(x)

// First level: just paste without expansion
#define CONCATENATE(a, b) a ## b

// Second level: expand macros before pasting
#define EXPAND_AND_CONCATENATE(a, b) CONCATENATE(a, b)

// Now build VMUX_Nx4x1
#define PREFIXED_NAME EXPAND_AND_CONCATENATE(V, MODULENAME)

// Build the full string "VMUX_Nx4x1.h"
#define HEADER_NAME TOSTRING(PREFIXED_NAME.h)

#include HEADER_NAME
#include "verilated.h"
#include <iostream>
#include <bitset>

#define MAX_SIM_TIME 1000 // Simulation time
#define module PREFIXED_NAME

void clk_tick(module* top);

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    module* top = new module{contextp};
    
    
    std::cout << "[ASSERTION #1]: Attempting to overwrite register 31 (should always be 0)" << std::endl;
    top->RR1_i = 31;
    top->RR2_i = 31;
    top->WR_i = 31;
    top->WD_i = 0x000000000000A0;
    clk_tick(top);
    top->RegWrite_i = 1;
    clk_tick(top);
    top->RegWrite_i = 0;
    clk_tick(top);
    assert(top->RD1_o == 0 && top->RD2_o == 0);

    std::cout << "[ASSERTION #2]: Writing & Validating each Registers" << std::endl;
    for (int i = 0; i < 31; i++) {
        top->RegWrite_i = 0;
        top->RR1_i = i - 1;
        top->RR2_i = i;
        top->WR_i = i;
        top->WD_i = -1;
        clk_tick(top);
        top->RegWrite_i = 1;
        top->WD_i = i;
        clk_tick(top);
    } 
    for (int i = 0; i < 31; i++) {
        top->RegWrite_i = 0;
        top->RR1_i = i - 1;
        top->RR2_i = i;
        top->WR_i = i;
        top->WD_i = -2;
        clk_tick(top);
        assert((i == 0 && top->RD1_o == 0) || top->RD1_o == i - 1);
        assert((i == 31 && top->RD2_o == 0) || top->RD2_o == i);
    } 
    

    top->final();
    delete top;
    delete contextp;
    return 0;
}

void clk_tick(module* top) {
    top->clk_i = 1;
    top->eval();
    top->clk_i = 0;
    top->eval();
}
