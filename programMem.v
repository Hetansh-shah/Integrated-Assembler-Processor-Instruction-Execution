`timescale 1ns/1ps
module programMem(clk, InsOut, in, rst);    //InsOut = Output instruction
	
	//while instiating this module, we will give PC as input to this module
	
	//program memory or instruction memory is read only but we will make it write also because there is no way for us to load instructions in this memory to be executed the the processor
	
	//other way round is we can read data from external txt file which contains instructions and then these are loaded in instruction/program memory
	input [31:0] in;    //PC in place of it. actually it is read address.
	input clk;
	input rst;
	
	output reg [31:0] InsOut;
	reg [31:0] Registers [0:1023];   //1KB memory having each register of 32 bit, PC will be of 10-bits now.
	integer i;
	
	

	initial begin
		$readmemb("D://Nirma//Sem 6//CA//riscprocessor//machineCodeInBinary.txt", Registers);     //our own made assembler 
		//$readmemb("C://Users//Ahsan Ali//OneDrive//Desktop//Assembly-To-Machine-Code-RISC-V-master//machineCodeInBinary.txt", Registers);     //someone else's assembler
		
	end
	
	always @ (*)   //Do not change it to (posedge clk or posedge rst) otherwise, branch instruction will not work file. Just a matter of experience
	begin
		if (!rst) begin
			InsOut <= Registers[in];              //Instruction is coming out
		end
		
		else begin
			InsOut <= 0;
		end
	end
	
	/*
	always @ (posedge rst)
	begin
	for (i = 0; i<32; i = i + 1) begin 
		Registers[i] = 32'b0;
	end
	*/
	
	//comments may be wrongs because of swap of code lines, so verify first
	/*
	Registers[0] = 32'b00000000000100000000000010010011; //addi x1, x0, 1
	Registers[1] = 32'b00000000001000000000000100010011; //addi x2, x0, 2
	Registers[2] = 32'b00000000001100000000000110010011; //addi x3, x0, 3
	Registers[3] = 32'b00000000010000000000001000010011; //addi x4, x0, 4
	Registers[4] = 32'b00000000001000011000001000110011; //add  x4, x3, x2
	Registers[5] = 32'b00000000001000010000000110110011; //add  x3, x2, x2
	Registers[6] = 32'b00000000001000010000000100110011; //sw x2, 0(x3)
	Registers[7] = 32'b00000000001000011010000000100011; //lw x2, 0(x3)
	Registers[8] = 32'b11111110000000000000111011100011; //beq x0, x0, -4
*/

//00000000000000000000110001100011








/*
Registers[9] = 32'hFE8021A3;
Registers[10] = 32'h000004B3;
Registers[11] = 32'h40000433;
Registers[12] = 32'h00040363;
Registers[13] = 32'h00002403;
Registers[14] = 32'h00007513;
Registers[15] = 32'h00048363;
Registers[16] = 32'h000DA003;
Registers[17] = 32'h00048363;
Registers[18] = 32'h00092033;
Registers[19] = 32'h00A50363;
Registers[20] = 32'h000004B3;
Registers[21] = 32'h0060046F;
Registers[22] = 32'h00000493;
Registers[23] = 32'h00000413;
Registers[24] = 32'h0060056F;
Registers[25] = 32'h00050013;
Registers[26] = 32'h00000413;
Registers[27] = 32'h006004EF;
Registers[28] = 32'h00050513;
Registers[29] = 32'h00000493;
Registers[30] = 32'h0060056F;
Registers[31] = 32'h00000413;
Registers[32] = 32'h00000413;
Registers[33] = 32'h006004EF;
*/
	/*
	Registers[2] = 32'b00000001000010011000000000100100; //and $s0, $t0, $t1
	Registers[3] = 32'b00000001000010011000000000100101; //or $s0, $t0, $t1
	Registers[4] = 32'b10101100000100000000000000000100; //sw $s0, 4($zero)
	Registers[5] = 32'b10101100000010000000000000001000; //sw $t0, 8($zero)
	Registers[6] = 32'b00000001000010011000100000100000; //add $s1, $t0, $t1
	Registers[7] = 32'b00000001000010011001000000100010; //sub $s2, $t0, $t1
	Registers[8] = 32'b00010010001100100000000000001001; //beq $s1, $s2, error0
	Registers[9] = 32'b10001100000100010000000000000100; //lw $s1, 4($zero)
	Registers[10] = 32'b00110010001100100000000001001000; //andi $s2, $s1, 48
	Registers[11] = 32'b00010010001100100000000000001001; //beq $s1, $s2, error1
	Registers[12] = 32'b10001100000100110000000000001000; //lw $s3, 8($zero)
	Registers[13] = 32'b00010010000100110000000000001010; //beq $s0, $s3, error2
	Registers[14] = 32'b00000010010100011010000000101010; //slt $s4, $s2, $s1 (Last)
	Registers[15] = 32'b00010010100000000000000000001111; //beq $s4, $0, EXIT
	Registers[16] = 32'b00000010001000001001000000100000; //add $s2, $s1, $0
	Registers[17] = 32'b00001000000000000000000000001110; //j Last
	Registers[18] = 32'b00100000000010000000000000000000; //addi $t0, $0, 0(error0)
	Registers[19] = 32'b00100000000010010000000000000000; //addi $t1, $0, 0
	Registers[20] = 32'b00001000000000000000000000011111; //j EXIT
	Registers[21] = 32'b00100000000010000000000000000001; //addi $t0, $0, 1(error1)
	Registers[22] = 32'b00100000000010010000000000000001; //addi $t1, $0, 1
	Registers[23] = 32'b00001000000000000000000000011111; //j EXIT
	Registers[24] = 32'b00100000000010000000000000000010; //addi $t0, $0, 2(error2)
	Registers[25] = 32'b00100000000010010000000000000010; //addi $t1, $0, 2
	Registers[26] = 32'b00001000000000000000000000011111; //j EXIT
	Registers[27] = 32'b00100000000010000000000000000011; //addi $t0, $0, 3(error3)
	Registers[28] = 32'b00100000000010010000000000000011; //addi $t1, $0, 3
	Registers[29] = 32'b00001000000000000000000000011111; //j EXIT 
*/	
	//end
endmodule 