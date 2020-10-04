module data_memory(
	dm_wdata, 
	dm_addr, 
	MemWrite, 
	clk, 
	rst, 
	dm_rdata
);

input	[31:0]	dm_wdata;	// Input Data to be written into the Memory
input	[31:0]	dm_addr;	// dm_addr for writing/reading Data into/from Memory
input			MemWrite;	// Enables writing of Write_Data
input			clk;		// Clock signal
input			rst;		// Reset
output	[31:0]	dm_rdata;	// Output Data to be read from the Memory

reg		[31:0]	ram[127:0];	// 128 cells, each of them has 32-bit width

integer i;

assign dm_rdata = ram[dm_addr];

always @(posedge clk, posedge rst) begin
	if (rst) begin
		for (i = 0; i < 128; i = i + 1)
			ram[i] <= 32'b0;
	end else if (MemWrite) begin
		ram[dm_addr] <= dm_wdata;
	end
end

endmodule