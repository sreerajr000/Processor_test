`timescale 1ns / 1ps
`include "cpu.v"
module tb(select,out_to_board);	
	wire	[63:0]out_from_cpu;
	//reg	clk;
	//inout wire clk;
	reg clk;
	//reg reset;
	//reg clk;
	//wire clk;
	//wire locked;
	reg	rst;
	input	[2:0]select;
	output	[7:0]out_to_board;
	reg	[7:0]out_to_board;
	//clk_wiz_0 clK
     //(
     //.clk_in1(clk_in1),
      //.clk_out1(clk)
    // );

	cpu CPU(.clk(clk), .rst(rst), .out(out_from_cpu));
	
	always 
		#5 clk = !clk;
	
	initial
	begin
		#1 clk    = 1'b0; // time = 0 
		rst    = 1'b1;
		#6 rst=1'b0;
		#120
		$finish;		
	end
	always@(select)
	begin
		case(select)
			3'b000:	begin
				out_to_board <= out_from_cpu[7:0];
			end
			3'b001:	begin
				out_to_board <= out_from_cpu[15:8];
			end
			3'b010:	begin
				out_to_board <= out_from_cpu[23:16];
			end
			3'b011:	begin
				out_to_board <= out_from_cpu[31:24];
			end
			3'b100:	begin
				out_to_board <= out_from_cpu[39:32];
			end
			3'b101:	begin
				out_to_board <= out_from_cpu[47:40];
			end
			3'b110:	begin
				out_to_board <= out_from_cpu[55:48];
			end
			3'b111:	begin
				out_to_board <= out_from_cpu[63:56];
			end
			default:begin
				out_to_board <= 8'b0;
			end
		endcase
	end
/*	initial
	begin		
		repeat(1)
			@(posedge clk);	
		rst = 1'b0;		
		repeat(10)
			@(posedge clk);
		//$stop();
		$finish;
	end*/
endmodule
