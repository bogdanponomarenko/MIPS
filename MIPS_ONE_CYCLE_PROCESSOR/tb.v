`timescale 1ns/1ns
module tb();

reg clk, rst;

MIPS mips(
	 .clk	(clk),
	 .rst	(rst)
	 );

initial begin
#0
  clk = 0;
  forever 
  #5 clk = ~clk; 
end

initial begin
#0 
  rst = 1;
end

initial begin
#10 
  rst = 0;
end

 initial begin
#240
  $finish;
end

endmodule