`timescale 1ns/1ps
module mux_2x1(in0, in1, out, s);
	
	input [31:0] in0, in1;
	input s;
	output [31:0] out;
	
	assign out = (s) ? in1 : in0;

endmodule