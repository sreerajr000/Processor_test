module tb;
	reg [7:0]a[3:0];
	//reg [7:0]b;
	integer i;
	initial
	begin
		$readmemb("/home/pandora/My/test.dat",a);
	end
	initial begin

        $display("rdata:");

        for (i=0; i < 4; i=i+1)

        $display("%d:%b",i,a[i]);

	end
endmodule
