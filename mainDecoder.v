`timescale 1ns/1ps
module mainDecoder(RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, PCSrc, Branch, jump, ALUOp, opcode);

	input [6:0] opcode;	
	output reg RegWrite;
	output reg [1:0] ALUOp;
	output reg [1:0] ImmSrc;
	output reg ALUSrc;
	output reg MemWrite;
	output reg [1:0] ResultSrc;
	output reg PCSrc;
	output reg Branch;
	output reg jump;

	always @ (*)   //This always block is not triggered on clock, so use blocking assignments 
	begin
	
	if (opcode == 7'b0000011)  //lw
	begin
		RegWrite = 1;
		ImmSrc = 2'b00;
		ALUSrc = 1'b1;
		MemWrite = 1'b0;
		ResultSrc = 1'b1;
		PCSrc = 1'b0;
		ResultSrc = 2'b01;
		/*
		ResultSrc = 2'b01;
		Branch = 0;
		jump = 0;
		*/
		ALUOp = 2'b00;
	end

	else if (opcode == 7'b0100011)  //sw
	begin
		RegWrite = 0;
		ImmSrc = 2'b01;
		ALUSrc = 1'b1;
		MemWrite = 1'b1;

		PCSrc = 1'b0;
		/*
		ResultSrc = 2'b01;   //2'bxx
		Branch = 0;
		jump = 0;
		*/
		ALUOp = 2'b00;
		
	end	
	
	else if (opcode == 7'b0110011)  //R
	begin
		RegWrite = 1;
		ImmSrc = 2'bxx;   //2'bxx
		ALUSrc = 1'b0;
		MemWrite = 1'b0;
		ResultSrc = 1'b0;
		PCSrc = 1'b0;
		ResultSrc = 2'b00;
		/*
		ResultSrc = 2'b00;
		Branch = 0;
		jump = 0;
		*/
		ALUOp = 2'b10;
	end

	else if (opcode == 7'b1100011)  //beq
	begin 
		RegWrite = 0;
		ImmSrc = 2'b10;
		ALUSrc = 1'b0;
		MemWrite = 1'b0;

		PCSrc = 1'b1;
		Branch = 1'b1;
		/*
		ResultSrc = 2'b10;  //2'bxx
		
		jump = 0;
		*/
		ALUOp = 2'b01;
	end
	
	else if (opcode == 7'b0010011)  //addi , I-type
	begin
	
		RegWrite = 1;
		ImmSrc = 2'b00;
		ALUSrc = 1'b1;
		MemWrite = 1'b0;
		ResultSrc = 2'b00;
		PCSrc = 1'b0;
		/*
		ResultSrc = 2'b00;
		Branch = 0;
		jump = 0;
		*/
		ALUOp = 2'b10;
	end

	else if (opcode == 7'b1101111)  //jal
	begin
		RegWrite = 1;
		ImmSrc = 2'b11;
		ALUSrc = 1'b?;   //don't care, QuestaSim will make it z. i.e., high impedance state
		MemWrite = 1'b0;
		PCSrc = 1'b1;
		ResultSrc = 2'b10;
		ALUOp = 2'b10;    //2'bxx
		jump = 1'b1;
		Branch = 1'b0;
		
	end

	else
	begin
		RegWrite = 1;
		ImmSrc = 2'b11;
		ALUSrc = 1'b0;
		MemWrite = 1'b0;
		PCSrc = 1'b0;
		Branch = 1'b0;
		/*
		ResultSrc = 2'b10;
		
		jump = 0;
		*/
		ALUOp = 2'b10;
	end
	
	end
	
endmodule