`timescale 1ns/1ps
module ALU(ALUout, ALUin1, ALUin2, control, zFlag, cFlag, OvFlag);

	input [2:0] control;
	input [31:0] ALUin1, ALUin2;
	output reg [31:0] ALUout;
	output reg zFlag;
	output reg cFlag;
	output reg OvFlag;
	reg [32:0]sum;
	
	always @ (*)
	begin
		
		case (control)
			3'b000: begin
					sum <= ALUin1 + ALUin2;    
					ALUout <= ALUin1 + ALUin2;    //add
					cFlag = sum[32];
					OvFlag = (ALUin1[31] & ALUin2[31] & ~ALUout[31]) |((~ALUin1[31] & ~ALUin2[31] & ALUout[31]));
			end
			3'b001: begin                          //for subtraction
					sum <= ALUin1 - ALUin2;
					ALUout <= ALUin1 - ALUin2;
					cFlag = sum[32];
					OvFlag = (ALUin1[31] & ALUin2[31] & ~ALUout[31]) |((~ALUin1[31] & ~ALUin2[31] & ALUout[31]));

			end			
			3'b010: begin
			
			       ALUout <= ALUin1 & ALUin2;     //and
					 cFlag = 1'b0;
			end
			3'b011: begin
					ALUout <= ALUin1 | ALUin2;     //or
					cFlag = 1'b0;
			end
			3'b101: begin //SLT instruction, checking whether ALUin1 in > or not
						
					if((ALUin1 - ALUin2) >= 32'h80000000) 
						ALUout <= 32'b1; 			                //slt
					else ALUout <= 32'b0;                 //Implementing signed number comparison
			end
			
			3'b100: begin

					if ((ALUin1 - ALUin2) >= 32'b0) ALUout <= 32'b0;
					else ALUout <= 32'b1;
			end
			
			3'b110: begin
					ALUout <= ALUin1 ^ ALUin2;           //XOR
					cFlag = 1'b0;
			end 


			
			default: begin ALUout <= ALUin1 + ALUin2; 
								cFlag = sum[32];
								OvFlag = (ALUin1[31] & ALUin2[31] & ~ALUout[31]) |((~ALUin1[31] & ~ALUin2[31] & ALUout[31]));
			end
			
		endcase
		zFlag = (ALUout == 32'b0);
		
	end
endmodule 