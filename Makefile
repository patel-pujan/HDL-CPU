# Makefile for Verilator C++ simulation
V 			:= verilator
LINT-FLAGS 	:= --lint-only -Wall --timing
SIM-FLAGS 	:= --no-timing --cc --exe --build -j 0 -Wall
TOP 		:= $(word 2, $(MAKECMDGOALS))
V-FILE 		:= $(TOP).sv
SIM-FILE 	:= sim_main.cpp
SRC-DIR		:= -IMUXs -IDECODERs -IREGs
BUILD_DIR 	:= obj_dir
EXECUTABLE 	:= $(BUILD_DIR)/V$(TOP)

.PHONY: sim lint clean

sim: $(EXECUTABLE)

$(EXECUTABLE): $(V-FILE) $(SIM-FILE)
	$(V) $(SRC-DIR) $(SIM-FLAGS) $(SIM-FILE) $(V-FILE)

lint:
	$(V) $(SRC-DIR) $(LINT-FLAGS) $(V-FILE)

clean:
	rm -rf $(BUILD_DIR)
