`include "data_memory.v"

module tb;
	reg			clk;
   	reg 		[31:0]	address;
	reg		[31:0]	write_data;
	reg 			write_enable;

    	wire 		[31:0] 	read_data;
    	data_memory f(.clk(clk),.address(address),.write_data(write_data),.write_enable(write_enable),.read_data(read_data));
    	
    	always 
		#5 clk = ~clk;
	initial
	begin
		clk    = 1'b0      ; // time = 0 
		write_enable = 1'b0;
		address[31:0] =32'h0;	
	end
	
endmodule
