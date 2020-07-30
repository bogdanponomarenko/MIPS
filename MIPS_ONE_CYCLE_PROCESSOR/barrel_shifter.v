module barrel_shifter (i_data, sa, shift_op, o_data);

localparam	SLL	= 3'b001,
		SRL	= 3'b010,
		SRA	= 3'b100,
		ROR	= 3'b110,
		ROL	= 3'b111;
						
input  		[31:0]  i_data;
input		[2:0]   shift_op;
input		[4:0]   sa;

output  [31:0] o_data;
reg	[31:0] data;
	
wire [63:0] rshift = {i_data, i_data} >> sa;
wire [63:0] lshift = {i_data, i_data} << sa;

always @(*) begin	
	casez(shift_op)
		SLL:	data = lshift[31:0];			// shift left  logical
		SRL:	data = rshift[63:32];			// shift right logical		
		SRA:    data = $signed(i_data) >>> sa;		// shift right arithmetic		
		ROR:	data = rshift[31:0];			// shift right cyclic
		ROL:	data = lshift[63:32];			// shift left cyclic
	endcase
end

assign o_data = data;

endmodule