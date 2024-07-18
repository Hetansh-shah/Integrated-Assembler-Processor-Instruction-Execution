/*`timescale 1ns/1ps
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
		#300; $stop;
	end

endmodule
*/