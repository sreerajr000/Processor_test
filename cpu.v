`timescale 1ns / 1ps
`include "alu.v"
`include "program_counter.v"
`include "instruction_memory.v"
`include "data_memory.v"
`include "register_file.v"
`include "control_unit.v"

module cpu(
	clk,
	rst,
	out
);
	input	clk;
	input	rst;
	output	reg [63:0]out;
	
	wire [31:0] 	pc_to_address;
	wire [31:0] 	instruction;
	wire 		signal_data_mem_wren;
	wire		signal_reg_file_wren;
	wire [4:0]	signal_alu_control;
	wire [2:0]	signal_pc_control;
	wire  [4:0] 	reg_waddr;
	
	wire [31:0]	reg_rdata0;
	wire [31:0]	reg_rdata1;
	reg  [31:0]	reg_wdata;
	wire [31:0] 	alu_operand1;
	wire [31:0]	alu_result0;
	wire [31:0]	alu_result1;
	wire		cin;
	wire		carry;
	wire 		alu_flag_overflow;
	wire 		alu_flag_zero;
	wire [31:0] 	datamemory_rdata;
	
	wire [15:0]	data_mem_add;
	
	wire [4:0] 	reg_radd0;
	wire [4:0] 	reg_radd1;
	
	//Program Counter
	program_counter prgmCounter(.clk(clk), 
		.rst(rst), 
		.pc(pc_to_address), 
		.pc_control(signal_pc_control),
		.jump_address(instruction[25:0]), 
		.branch_offset(instruction[15:0]), 
		.reg_address(reg_rdata0));
	
	//Instruction Memory
	instruction_memory insMemory(.address(pc_to_address), 
		.instruction(instruction));
	
	//Control Unit
	control_unit cntrlUnit(.clk(clk),
		.instruction(instruction), 
		.data_mem_write_en(signal_data_mem_wren), 
		.reg_file_write_en(signal_reg_file_wren), 
		.alu_opcode(signal_alu_control), 
		.alu_zero(alu_flag_zero), 
		.pc_control(signal_pc_control), 
		.reg_radd0(reg_radd0), 
		.reg_radd1(reg_radd1), 
		.reg_wadd(reg_waddr), 
		.data_mem_add(data_mem_add),
		.pc(pc_to_address),
		.alu_cin(cin));
	
	//Data Memory
	data_memory dataMemory(.clk(clk), 
		.address(data_mem_add), 
		.read_data(datamemory_rdata), 
		.write_data(reg_rdata1), 
		.write_enable(signal_data_mem_wren));
	

	//Register File
	register_file regFile(.clk(clk),
		.read_address0(reg_radd0),
		.read_data0(reg_rdata0), 
		.read_address1(reg_radd1), 
		.read_data1(reg_rdata1), 
		.write_address(reg_waddr), 
		.write_data(datamemory_rdata), 
		.write_enable(signal_reg_file_wren));
	
	//Arithmetic Logic Unit
	alu Alu(.opcode(signal_alu_control), 
		.operand0(reg_rdata0), 
		.operand1(reg_rdata1), 
		.cin(cin), 
		.result0(alu_result0), 
		.result1(alu_result1), 
		.carry(carry), 
		.overflow(alu_flag_overflow), 
		.zero(alu_flag_zero));
	
	
	always @(posedge clk)
	begin
		//if(instruction === 32'bx)	begin
		//	$finish;
		//end
		out = {alu_result1,alu_result0};
		$display($time," Instruction = %h DMemWen = %b RegWen =%b AluCode =%b PC =%b RegAddr0 =%d RegAdrr1 =%d RegWAddr =%b DMemAddr =%b Result =%d Out =%d\n ",instruction,signal_data_mem_wren,signal_reg_file_wren,signal_alu_control,signal_pc_control,reg_rdata0,reg_rdata1,reg_waddr,data_mem_add,alu_result0,out);
	end
	
	
	
endmodule
