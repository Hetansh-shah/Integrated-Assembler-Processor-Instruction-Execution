`timescale 1ns/1ps
module PC(clk, rst, PCNext, PC);
	input clk, rst;
	input [31:0] PCNext;
	output reg [31:0] PC;
	
	always @ (posedge clk or posedge rst)
	begin
		if (rst) PC <= 0;
		else 
		begin
			PC <= PCNext;
		end
	end
	
endmodule




