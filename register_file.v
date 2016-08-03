`timescale 1ns / 1ps

module register_file
(
	clk,	//clock
	read_address0,
	read_data0,
	read_address1,
	read_data1,
	write_address,
	write_data,
	write_enable
);

	input				clk;
    	input 		[4:0]		read_address0;
	input 		[4:0]		read_address1;
	input 		[4:0]		write_address;
	input		[31:0]		write_data;
	input 				write_enable;
	

    	output 	reg	[31:0] 	read_data0;
	output	reg	[31:0]	read_data1;
		
 
    	reg		[31:0] reg_file	[31:0];
	always@(*)
	begin
		read_data0 <= reg_file[read_address0];
		read_data1 <= reg_file[read_address1];
	end
	integer i;
	
	initial
	begin	
	    for(i = 0; i < 32; i = i+1)
		begin
	        reg_file[i] = 0;
		end
	end
	
    	always @(posedge clk)
	begin
		if (write_enable == 1'b1) begin
			reg_file[write_address] = write_data;
			//$display($time," Reg Address = %b\tReg Data = %b\n",write_address,reg_file[write_address]);
		end
	end
	
 endmodule  



