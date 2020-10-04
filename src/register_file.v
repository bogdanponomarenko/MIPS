module register_file(
	regfile_addr1, 
	regfile_addr2, 
	regfile_addr3, 
	regfile_wdata, 
	RegWrite,  
	clk,
	rst, 
	regfile_rdata1, 
	regfile_rdata2
);

input	[4:0]	regfile_addr1;	 
input	[4:0]	regfile_addr2;
input  	[4:0]	regfile_addr3;
input	[31:0]	regfile_wdata;
input			RegWrite;
input			clk; 
input			rst;
output	[31:0]	regfile_rdata1;
output 	[31:0]	regfile_rdata2;

reg		[31:0]	Register [31:0];

integer i;

initial begin
	for(i = 0; i < 32; i = i + 1) begin
		Register[i] = 32'b0;	// Initialize all cells with '0'
	end
end

assign regfile_rdata1 = (0 == regfile_addr1) ? 32'b0: Register[regfile_addr1];
assign regfile_rdata2 = (0 == regfile_addr2) ? 32'b0: Register[regfile_addr2];

always @(posedge clk, posedge rst) begin
	if (rst) begin
		for (i = 0; i < 32; i = i + 1)
			Register[i] <= 32'b0;
	end else if(RegWrite) begin 
		Register[regfile_addr3] <= (0 == regfile_addr3) ? 32'b0: regfile_wdata;
	end
end	
	
endmodule