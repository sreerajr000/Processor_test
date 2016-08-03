`timescale 1ns / 1ps

module alu(
	opcode,
	operand0,
	operand1,
	cin,
	result0,
	result1,
	carry,
	overflow,
	zero);
	
	input	[4:0]	opcode;
	input	[31:0]	operand0;
	input	[31:0]	operand1;
	input		cin;
	
	output		carry;
	output	[31:0]	result0;
	output	[31:0]	result1;
	output		overflow;
	output		zero;
	
	reg	[31:0]	result0;
	reg		carry;
	reg	[31:0]	result1;
	reg		overflow;
	reg		zero;
	reg	[63:0]	temp;
	initial
	begin
		result1 = 32'd0;
	end
	always@(opcode)
	begin
		case (opcode)
			5'b00000 :	//Add
				begin
					result0		= operand0 + operand1;
					overflow 	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b00001 :	//Add with Carry
				begin
					{carry,result0}	= operand0 + operand1 + cin;
					overflow 	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b00010 :	//Subtract
				begin
					result0 	= operand0 - operand1;
					overflow 	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b00011 :	//Multiplication
				begin
					{result1,result0}= operand0 * operand1;
					overflow 	= 0;
					zero		= (result0 == 0 & result1 == 0) ? 1 : 0;
				end
			5'b00100 :	//Shift Left
				begin
					result0		= operand0 << operand1;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b00101 :	//Shift Right
				begin
					result0		= operand0 >> operand1;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b00110 :	//Rotate Left
				begin
					temp		= {operand0, operand0} << operand1;
					result0		= temp[31:0];
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b00111 :	//Rotate Right
				begin
					temp		= {operand0, operand0} >> operand1;
					result0		= temp[31:0];
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b01000 :	//Logical AND
				begin
					result0		= operand0 & operand1;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b01001 :	//Logical OR
				begin
					result0		= operand0 | operand1;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b01010 :	//Logical NOT
				begin
					result0		= ~(operand0);
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b01011 :	//Logical NOR
				begin
					result0		= ~(operand0 | operand1);
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b01100 :	//Logical NAND
				begin
					result0		= ~(operand0 & operand1);
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b01101 :	//Logical XOR
				begin
					result0		= operand0 ^ operand1;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b01110 :	//Logical XNOR
				begin
					result0		= ~(operand0 ^ operand1);
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b01111 :	//Less than
				begin
					result0		= (operand0 < operand1) ? -1 : 0;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b10000 :	//Less than or equal to
				begin
					result0		= (operand0 <= operand1) ? -1 : 0;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b10001 :	//Greater than
				begin
					result0		= (operand0 > operand1) ? -1 : 0;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b10010 :	//Greater than or equal to
				begin
					result0		= (operand0 >= operand1) ? -1 : 0;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b10011 :	//Equal to
				begin
					result0		= (operand0 == operand1) ? -1 : 0;
					overflow	= 0;
					zero		= (result0 == 0) ? 1 : 0;
				end
			5'b10100 :	//Signed Addition
				begin
					result0 	= operand0 + operand1;
					if ((operand0 	>= 0 && operand1 >= 0 && result0 < 0) ||
						(operand0 < 0 && operand1 < 0 && result0 >= 0)) begin
						overflow = 1;
					end else begin
						overflow = 0;
					end					
					zero		 = (result0 == 0) ? 1 : 0;
				end
			5'b10101 :	//Signed Subtraction
				begin
					result0		= operand0 - operand1;
					if ((operand0 >= 0 && operand1 < 0 && result0 < 0) ||
						(operand0 < 0 && operand1 >= 0 && result0 >= 0)) begin
						overflow = 1;
					end else begin
						overflow = 0;
					end
					
					zero		= (result0 == 0) ? 1 : 0;
					
				end
			5'b10110 :	//Signed Multiplication
				begin
					{result1,result0}= operand0 * operand1;
					overflow 	= 0;
					zero		= (result0 == 0 & result1 == 0) ? 1 : 0;
				end
			default :
				begin
					overflow	= 0;
					zero 		= 0;
				end
		endcase	
	end
endmodule
