`timescale 1ns/1ps
module RISC_controller(Ins, Branch, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite, ALUOp, ALUControl, PCSrc);
	input [31:0] Ins; 
	
	reg [6:0] opcode;
	reg [2:0] func3;
	reg func7;	
	
	output reg RegWrite, ALUSrc, MemWrite, ResultSrc, Branch, PCSrc;
	output reg [1:0] ImmSrc, ALUOp;
	output reg [2:0] ALUControl;
	
	always @ (*) 
	begin
		opcode <= Ins[6:0];
		func3 <= Ins[14:12];
		func7 <= Ins[30];
	end
	
	always @ (*)
	begin
	if (opcode == 7'b0000011)
	begin
		RegWrite = 1;
		ImmSrc = 2'b00;
		ALUSrc = 1;
		MemWrite = 0;
		ResultSrc = 1;
		Branch = 0;
		ALUOp = 2'b00;
	end

	if (opcode == 7'b0100011)
	begin
		RegWrite = 0;
		ImmSrc = 2'b01;
		ALUSrc = 1;
		MemWrite = 1;
		ResultSrc = 1'bx;
		Branch = 0;
		ALUOp = 2'b00;
	end	
	
	if (opcode == 7'b0110011)
	begin
		RegWrite = 1;
		ImmSrc = 2'bxx;
		ALUSrc = 0;
		MemWrite = 0;
		ResultSrc = 0;
		Branch = 0;
		ALUOp = 2'b10;
	end

	if (opcode == 7'b1100011)
	begin
		RegWrite = 0;
		ImmSrc = 2'b10;
		ALUSrc = 0;
		MemWrite = 0;
		ResultSrc = 1'bx;
		Branch = 1;
		ALUOp = 2'b01;
	end
	
	
	end

endmodule