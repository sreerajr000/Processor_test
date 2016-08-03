`timescale 1ns / 1ps
module control_unit(
		clk,
		instruction,
		data_mem_write_en,
		reg_file_write_en,
		alu_opcode,
		pc_control,
		alu_zero,
		reg_radd0,
		reg_radd1,
		reg_wadd,
		data_mem_add,
		pc,
		alu_cin
	);
	input	[31:0]	instruction;
	input		alu_zero;
	input 		clk;
	
	output	[4:0]	reg_radd0;
	output	[4:0]	reg_radd1;
	output	[4:0]	reg_wadd;
	output	[15:0]	data_mem_add;
	output          alu_cin;
	
	output		data_mem_write_en;
	output		reg_file_write_en;
	output	[4:0]	alu_opcode;
	output	[2:0]	pc_control;
	//output	[31:0]	reg_file_wdata;
	reg	[4:0]	reg_radd0;
	reg	[4:0]	reg_radd1;
	reg	[4:0]	reg_wadd;
	reg	[15:0]	data_mem_add;
	reg		data_mem_write_en;
	reg		reg_file_write_en;
	reg	[4:0]	alu_opcode;
	reg	[2:0]	pc_control;
	reg	[31:0]	reg_file_wdata;
	reg	[25:0]	address;
	output	[31:0]		pc;
	reg	[4:0]	opcode;
	reg         alu_cin;
	
	
	always@(posedge clk)
	begin
		$display($time," Opcode = %b\n",opcode);
		
		if(instruction[31] == 1'b0)
		begin	
			opcode <= instruction[30:26];
			reg_radd0 <= instruction[20:16];
			reg_radd1 <= instruction[15:11];
			reg_wadd  <= instruction[25:21];
			alu_opcode <= opcode;
			alu_cin   <= instruction[10];
		end
		else
		begin
			if(instruction[30:26] == 5'b11111)
			begin
				reg_file_write_en <= 1'b1;
				data_mem_write_en <= 1'b0;
				reg_wadd <= instruction[25:21];
				data_mem_add <= instruction[17:2];				
			end
			else if(instruction[30:26] == 5'b00000)
			begin
				reg_file_write_en <= 1'b0;
				data_mem_write_en <= 1'b1;
				reg_radd0 <= instruction[20:16];
				data_mem_add <= instruction[17:2];
			end
		end
		//PC Control
		opcode <= instruction[30:26];
		#0.5
		if(opcode == 5'b11001)	begin
			pc_control <= 3'b001;
		end
		else if(opcode == 5'b11010)	begin
			pc_control <= 3'b010;
		end
		else if(opcode == 5'b11011 & alu_zero == 1'b1)	begin
			pc_control <= 3'b011;
		end
		else	begin
			pc_control <= 3'b000;
		end
			
	end	

endmodule
