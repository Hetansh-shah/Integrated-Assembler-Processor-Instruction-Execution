`timescale 1ns/1ps
module mux_2x1_2_bit(in0, in1, in2, out, s);
	
	input [31:0] in0, in1, in2;
	input [1:0] s;
	output reg [31:0] out;
	
	always @ (*)
	begin
		if (s == 2'b00) out = in0;
		else if (s == 2'b01) out = in1;
		else if (s == 2'b10) out = in2;
	end

endmodule