#define MODULENAME Full_Adder_N

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
    
    top->A_i = 16;
    top->B_i = 16;
    top->C_in_i = 0;
    
    top->eval();
        
    
    std::cout << "[A]: " << top->A_i << std::endl;
    std::cout << "[B]: " << top->B_i << std::endl;
    
    std::cout << "[S]: " << top->S_o << std::endl;
    std::cout << "[C]: " << std::bitset<64>(top->C_out_o) << std::endl;

    top->final();
    delete top;
    delete contextp;
    return 0;
}

void clk_tick(module* top) {
    // top->clk_i = 1;
    // top->eval();
    // top->clk_i = 0;
    // top->eval();
}
