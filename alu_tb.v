`timescale 1ns / 1ps
`include "alu.v"
module tb;
	reg	[4:0]	opcode;
	reg	[31:0]	operand0;
	reg	[31:0]	operand1;
	wire	[31:0]	result0;
	wire	[31:0]	result1;
	wire		zero;
	wire		overflow;
	reg		cin;
	wire		carry;
	
	alu alu1(opcode[4:0],
		operand0[31:0],
		operand1[31:0],
		cin,
		result0[31:0],
		result1[31:0],
		carry,
		overflow,
		zero);
	initial begin
		opcode = 5'b00011;
		operand0 = 32'hffffff;
		operand1 = 32'hefefe;
		cin	 = 1'b0;
	end
	initial begin
		$monitor($time," Opcode = %b\tOperand1 = %h\tOperand2 = %h\tResult[31:0] = %h\tResult[63:32] = %h\n",opcode[4:0],operand0[31:0],operand1[31:0],result0[31:0],result1[31:0]);	
	end	
	
endmodule
