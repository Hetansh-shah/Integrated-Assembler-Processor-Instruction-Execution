`timescale 1ns/1ps
module RegFile(clk, rst, data_in, writeEn, addr, data_out1, data_out2, readAddr1, readAddr2);      //double port Register File      //32-bit
	input clk, rst, writeEn;
	input [4:0] addr, readAddr1, readAddr2;            //addr is write address
	input [31:0] data_in;
	output reg [31:0] data_out1, data_out2;
	
	parameter noOfReg = 32;
	parameter sizeofOneReg = 32;       //32-bit architecture
	
	reg [0:sizeofOneReg - 1] GPRs [0:noOfReg - 1];
	integer j;
	

	always @ (*)
	begin
		data_out1 = GPRs[readAddr1];
		data_out2 = GPRs[readAddr2];
	end
	
	always @ (*)
	begin
		if (rst == 0)
		begin
			if (writeEn) 
			begin 
				if (addr != 5'b00000)    //don't want to write at 0 address
					GPRs[addr] <= data_in;
			end
		end
		
		else if (rst == 1) 
		begin
			for (j = 0; j < 32; j = j + 1) 
			begin
				GPRs[j] <= 32'b0;
			end
		end
	end
endmodule