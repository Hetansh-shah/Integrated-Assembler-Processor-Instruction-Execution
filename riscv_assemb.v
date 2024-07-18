`timescale 1ns/1ps
module riscv_assemb(clk, rst);
	input clk, rst;

	
	wire [31:0] ALUout;   //data to be shown on SSD

	wire PCSrc;
	
	wire [31:0] PCNext;
	wire [31:0] PC;
	wire [31:0] PCPlus4;
	wire [31:0] PCTarget;
	
	wire [31:0] InsOut;  //instruction out, encoded one
	//wire [31:0] ALUin1;
	wire [31:0] ALUin2;
	
	
	wire [6:0] opcode;
	//wire [31:0] wrData;        //write back data


	
	wire RegWrite;   //write enable of reg file
	
	
	wire [2:0] func3;
	wire func7_5;
	
	wire [2:0] ALUControl;
	
	assign func3 = InsOut[14:12];
	assign opcode = InsOut[6:0];
	assign op5 = InsOut[5];
	assign func7_5 = InsOut[30];
	
	wire [1:0] ALUOp;
	
	wire [31:0] ImmExt;
	wire [1:0] ImmSrc;
	
	wire [31:0] RD1;   //data output 1 from Reg file
	wire [31:0] RD2;	//data output 2 from Reg file
	
	wire [31:0] WD3;   //data in of Reg file
	
	wire ALUSrc;
	wire [31:0] RD;    //data output from data memory
	wire MemWrite;
	wire [1:0] ResultSrc;
	wire Branch;
	wire jump;

	wire zFlag;
	wire cFlag;
	wire OvFlag;
	PC pc1(clk, rst, PCNext, PC);
	
	programMem InstructionMemory(.clk(clk), .InsOut(InsOut), .in(PC), .rst(rst)); //Instruction Memory

	mainDecoder main_decoder(.RegWrite(RegWrite), .ImmSrc(ImmSrc), .ALUSrc(ALUSrc), .MemWrite(MemWrite), .ResultSrc(ResultSrc), .PCSrc(PCSrc), .Branch(Branch), .jump(jump), .ALUOp(ALUOp), .opcode(opcode));
	
	signExt extend(.in(InsOut), .out(ImmExt), .ImmSrc(ImmSrc));
	
	ALUDecoder aluDecod(.ALUop(ALUOp), .func3(func3), .op5(op5), .func7_5(func7_5), .ALUControl(ALUControl));
	
	
	
	dMemory dataMem(.clk(clk), .rst(rst), .A(ALUout), .WD(RD2), .RD(RD), .writeEn(MemWrite));
	RegFile regFile(.clk(clk), .rst(rst), .data_in(WD3), .writeEn(RegWrite), .addr(InsOut[11:7]), .data_out1(RD1), .data_out2(RD2), .readAddr1(InsOut[19:15]), .readAddr2(InsOut[24:20]));

	ALU alu(.ALUout(ALUout), .ALUin1(RD1), .ALUin2(ALUin2), .control(ALUControl), .zFlag(zFlag), .cFlag(cFlag), .OvFlag(OvFlag));
	
	mux_2x1 mux1(.in0(RD2), .in1(ImmExt), .out(ALUin2), .s(ALUSrc));
	
	mux_2x1_2_bit mux2(.in0(ALUout), .in1(RD), .in2(PCPlus4), .out(WD3), .s(ResultSrc));
	
	
	adder ADDER_for_PC(.in(PC), .out(PCPlus4));   //1 adding adder
	normalAdder adder_beq(.in1(PC), .in2(ImmExt), .out(PCTarget));        //Adder for BEQ
	mux_2x1 mux3(.in0(PCPlus4), .in1(PCTarget), .out(PCNext), .s(PCSrc));   //MUX near PC
	
	
endmodule

`timescale 1ns/1ps
module tb_RISC();
	reg clk, rst;
	
	initial begin
		clk = 0;
	end
	
	always #5 clk = ~clk;
	
	riscv_assemb my_RISC(clk, rst);
	
	initial begin
		rst = 0;
		#2; rst = 1;
		#4; rst = 0;
		#50; $stop;
	end

endmodule

