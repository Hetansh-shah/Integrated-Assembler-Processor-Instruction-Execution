`timescale 1ns/1ps
module ALUDecoder(ALUop, func3, op5, func7_5, ALUControl);
	input [1:0] ALUop;
	input [2:0] func3;
	input op5;
	input func7_5;
	output reg [2:0] ALUControl;
	
	
	always @ (*)
	begin
	
	if (ALUop == 2'b00)   //LW
	begin
		ALUControl = 3'b000;
	end
	
	if (ALUop == 2'b01)  //BEQ
	begin
		ALUControl = 3'b001;
	end


	if (ALUop == 2'b10) 
	begin
	
		if (func3 == 3'b000)
		begin
			if ({op5, func7_5} == 2'b00 || {op5, func7_5} == 2'b01 || {op5, func7_5} == 2'b10)
			begin
				ALUControl = 3'b000;   //ADD
			end
		end
		
		
		if (func3 == 3'b000)
		begin
			if ({op5, func7_5} == 2'b11)
			begin
				ALUControl = 3'b001;  //SUB
			end
		end	


		else if (func3 == 3'b010)
		begin
			ALUControl = 3'b101;  //SLT
		end	
	
		else if (func3 == 3'b110)
		begin
			ALUControl = 3'b011;  //OR
		end	
	
		else if (func3 == 3'b111)
		begin
			ALUControl = 3'b010;  //AND
		end	
	end
	
	else 
	begin
		ALUControl = 3'b111;
	end
	
	end

	
endmodule