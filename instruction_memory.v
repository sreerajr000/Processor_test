`timescale 1ns / 1ps

module instruction_memory

(
	address,
	instruction
);

	input	[31:0]	address;

    	output 	[31:0] 	instruction;

    	reg	[31:0] instruction_memory	[255:0];
		
	initial
	begin
		$readmemb("/home/pandora/My/program1",instruction_memory);
		//instruction_memory[0]=32'b11111100000000000000000000000000;
		//instruction_memory[1]=32'b11111100001000000000000000000100;
		//instruction_memory[2]=32'b00000000010000000000110000000000;
		//instruction_memory[3]=32'b00001000011000100000110000000000;
	end
	
	assign instruction = instruction_memory[address[9:2]];
	
 endmodule  



