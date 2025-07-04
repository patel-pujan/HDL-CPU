// Test bench for Register file - TA version
`timescale 1ns/10ps

module regdemo();

	parameter ClockDelay = 512000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	regfile dut (.ReadData1, .ReadData2, .WriteData, .ReadRegister1, .ReadRegister2, .WriteRegister, .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd31;
		ReadRegister2 <= 5'd31;
		WriteRegister <= 5'd31;
		WriteData <= 64'h000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);
		RegWrite <= 0;
		@(posedge clk);
		assert(ReadData1 == '0 && ReadData2 == '0);

		$display("%t Writing pattern to all registers.", $time);
		// Write a value into each  register.
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= 'x;
			@(posedge clk);
			
			RegWrite <= 1; WriteData <= i*64'h0000010204080001;
			@(posedge clk);
		end

		$display("%t Checking pattern.", $time);
		// Go back and verify that the registers
		// retained the data.
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
			assert((i == 0 && ReadData1 == '0) || (i != 0 && ReadData1 == (i-1)*64'h0000010204080001));
			assert((i == 31 && ReadData2 == '0) || (i != 31 && ReadData2 == i*64'h0000010204080001));
		end

		// See if I can cause the register file to glitch.  I'm going to
		// do LOTS of changes during the active period of the clock.  For
		// some labs, that use the write enable to alter the clock, this
		// will write to random locations in the register file.
		$display("%t Injecting glitches to show bogus clock enables.", $time);
		#(ClockDelay/4);  // Go into positive portion of clock.
		RegWrite <= 1;
		WriteData <= '1;
		for (i=0; i<32; i=i+1) begin
			#(ClockDelay/256);
			WriteRegister <= i;
		end
		@(negedge clk); #(ClockDelay/4);	// Go into negative portion of the clock.
		for (i=0; i<32; i=i+1) begin
			#(ClockDelay/256);
			WriteRegister <= i;
		end
		RegWrite <= 0;
		@(posedge clk);
		
		// Go back and verify that the registers
		// retained the data.
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
			assert((i == 0 && ReadData1 == '0) || (i != 0 && ReadData1 == (i-1)*64'h0000010204080001));
			assert((i == 31 && ReadData2 == '0) || (i != 31 && ReadData2 == i*64'h0000010204080001));
		end

		$stop;
	end
endmodule

