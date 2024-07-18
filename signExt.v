`timescale 1ns/1ps
module signExt(in, out, ImmSrc);

	input [31:0] in;   //this will be actually instruction out
	input [1:0] ImmSrc;
	output reg [31:0] out;
	
	always @ (*)
	begin
	
	if (ImmSrc == 2'b00)          //I-instructions
	begin
	
		out = {{20{in[31]}}, in[31:20]};
		
	end
	
	if (ImmSrc == 2'b01)            //S-type
	begin

		out = {{20{in[31]}}, in[31:25], in[11:7]};
	
	end
	
	if (ImmSrc == 2'b10)    //beq
	begin

		out = {{20{in[31]}}, in[7], in[30:25], in[11:8], 1'b1};
	end
	
	if (ImmSrc == 2'b11) //jal
	begin

		out = {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0};
	end

	end
endmodule