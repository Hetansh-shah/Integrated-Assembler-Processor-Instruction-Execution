module controlUnit(ALUOp, func3, op5, func7_5, ALUControl, opcode, RegWrite, ALUSrc, MemWrite, Branch, PCSrc, jump, ResultSrc, ImmSrc, ALUop);
	input [1:0] ALUop;
	input [2:0] func3;
	input op5;
	input func7_5;
	output reg [2:0] ALUControl;
	
	input [6:0] opcode;
	output reg RegWrite, ALUSrc, MemWrite, Branch, PCSrc, jump;
	output reg [1:0] ResultSrc;
	output reg [1:0] ImmSrc, ALUOp;
	
	ALUDecoder aluDecod(ALUop, func3, op5, func7_5, ALUControl);
	mainDecoder main_decoder(Branch, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite, ALUOp, PCSrc, jump, opcode);

endmodule
	

	