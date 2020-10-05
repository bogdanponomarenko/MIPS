`timescale 1ns / 1ns

module testbench;

localparam PERIOD = 20;	

reg	rst;
reg	clk;
													
MIPS MIPS_i(
	.rst	(rst),
	.clk	(clk)
);

initial begin
	#10	clk = 0;
	
	forever #(PERIOD/2) clk = ~clk;
end

initial begin
	#0	rst = 1;
	
	#10	rst = 0;
	
	#620	$finish;  
end
  
endmodule