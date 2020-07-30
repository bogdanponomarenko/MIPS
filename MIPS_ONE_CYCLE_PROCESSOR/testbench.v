`timescale 1ns / 1ns
module testbench();

reg clk, rst;

MIPS mips(
	 .clk	(clk),
	 .rst	(rst)
	 );

initial begin
#0
  clk = 0;
  forever #10 
		clk = ~clk; 
end

initial begin
#0 
	rst = 1;

#10 	
	rst = 0;

#240
	$finish;
end

endmodule