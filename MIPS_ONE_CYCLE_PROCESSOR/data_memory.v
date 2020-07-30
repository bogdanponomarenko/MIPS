// Quartus II Verilog Template
// Single port RAM with single read/write Addressess 

module data_memory (Write_Data, Address, MemWrite, clk, rst, Read_Data);

input	[31:0]	Write_Data;
input	[31:0]	Address;
input		MemWrite, clk, rst;

output	[31:0]	Read_Data;

reg	[31:0]	ram[1024:0];
integer i;
	
assign Read_Data = ram[Address];
		 
always @ (posedge clk) begin
	if (rst) begin
		for (i=0; i<1024; i=i+1)
			ram[i] <= 32'b0;
	end
	else if (MemWrite) begin
		ram[Address] <= Write_Data;
	end
end	
	
endmodule