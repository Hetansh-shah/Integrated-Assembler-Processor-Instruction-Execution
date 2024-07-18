`timescale 1ns/1ps
module dMemory(clk, rst, A, WD, RD, writeEn);

	// addr is used both for reading and writing purposes
	input clk, rst, writeEn;
	input [31:0] A; //in order to access 256 register of 1KB memory, 8 bit number is required, you can take any bit number but atleast to access its address
	input [31:0] WD;
	output reg [31:0] RD;
	

	
	parameter noOfReg = 256;    //1KB data memory, becasue 32 bit register =4bytes and 256 * 4 = 1024 = 1KB
	parameter sizeofOneReg = 32;       //32-bit architecture
	
	reg [31:0] DataMemory [0:255];
	
	integer i;
	//assign RD = DataMemory[A];   //A = read Address, RD = data read from address A

	always @ (*)
	begin
		RD = DataMemory[A];
	end
	
always @ (*)
begin
if (rst == 0)
begin
if (writeEn == 1) DataMemory[A] <= WD;
		end
		
		else
		begin
			for (i = 0; i < 256; i = i + 1)
			begin
				DataMemory[i] <= 32'b0;
			end
		end
	end
endmodule
