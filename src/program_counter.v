module program_counter(
	pc_next_addr, 
	clk, 
	rst, 
	pc_curr_addr
);

input		[31:0]	pc_next_addr;
input			clk;
input			rst;
output reg	[31:0]	pc_curr_addr;

always @(posedge clk, posedge rst) begin
	if (rst) begin
		pc_curr_addr <= 32'b0;
    end	else begin
		pc_curr_addr <= pc_next_addr;
	end
end

endmodule
