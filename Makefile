<<<<<<< HEAD
# Makefile for Verilator C++ simulation
V 			:= verilator
LINT-FLAGS 	:= --lint-only -Wall --no-timing
SIM-FLAGS 	:= --no-timing --cc --exe --build -j 0 -Wall
TOP 		:= $(word 2, $(MAKECMDGOALS))
V-FILE 		:= $(TOP).sv
SIM-FILE 	:= sim_main.cpp
SRC-DIR		:= -IMUXs -IDECODERs -IREGs -IOPs
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
=======
CC := gcc
CFLAGS := -Wall -Wextra -Werror -O0 -g
CFILES := $(wildcard *.c)
OBJFILES := $(CFILES:.c=.o)
TARGET := CPU

$(TARGET): $(OBJFILES)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm $(OBJFILES) $(TARGET)
>>>>>>> dc11569 (working Makefile)
