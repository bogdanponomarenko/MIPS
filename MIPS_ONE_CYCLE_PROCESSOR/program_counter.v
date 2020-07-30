module program_counter (input_pc, output_pc, rst, clk);

input	[31:0]		input_pc;
input			clk, rst;

output	reg [31:0]	output_pc;

always @(posedge clk)
	begin
		if (rst) begin
			output_pc <= 32'h00000000;
      		end
      		else 	output_pc <= input_pc;
	end

endmodule