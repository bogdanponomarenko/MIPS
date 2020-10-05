module instruction_memory(
	rom_addr, 
	rom_rdata
);

`define ROM_FILE  "ROM_FILE.bin"

`ifndef __ROM__
`define __ROM__

localparam	DATA_WIDTH = 32'd32;
localparam	ADDR_WIDTH = 32'd32;
localparam	ROM_BLOCKS_NUM = 2**10;
localparam	[ADDR_WIDTH-1:0]	ROM_END_ADDR	= ROM_BLOCKS_NUM;
parameter	[DATA_WIDTH-1:0]	ROM_DEFLT_DATA	= {DATA_WIDTH{1'b0}};

input		[ADDR_WIDTH-1:0]	rom_addr;
output reg	[DATA_WIDTH-1:0]	rom_rdata;

reg		[DATA_WIDTH-1:0]	rom_mem [ROM_BLOCKS_NUM-1:0];

initial begin: INIT
	integer i;
	for (i = 0; i < ROM_BLOCKS_NUM; i = i + 1) begin
		rom_mem[i] = ROM_DEFLT_DATA;
	end
	$readmemh(`ROM_FILE, rom_mem);
end

always @(rom_addr) begin
	if (rom_addr > ROM_END_ADDR) rom_rdata = ROM_DEFLT_DATA;
	else rom_rdata = rom_mem[rom_addr];
end

endmodule
`endif
