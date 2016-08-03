`timescale 1ns / 1ps

module data_memory

(
	clk,		//clock
	address,
	read_data,
	write_data,
	write_enable
);

	input			clk;
   	input 		[15:0]	address;
	input		[31:0]	write_data;
	input 			write_enable;

    	output 	reg	[31:0] 	read_data;

   	reg		[31:0]	memory_block	[65535:0];
	
	
	initial
	begin
		$readmemh("/home/pandora/My/memory.dat",memory_block);
		//memory_block[0]=32'hf7;
		//memory_block[1]=32'h5;
	end
	always@(*)
	begin
		read_data = memory_block[address[15:0]];
		//$display($time," Read Data = %h\n",read_data);			
	end
	// Sequential Logic
		
   	always @(posedge clk)
	begin
		if (write_enable)
			memory_block[address[15:0]] <= write_data[31:0];
	end
	
	//17:2
 endmodule  



