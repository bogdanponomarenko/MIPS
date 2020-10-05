module barrel_shifter(
	i_data, 
	shift_amount, 
	shift_op, 
	o_data
);

localparam	SLL	= 3'b001;	// Shift Left Logical
localparam	SRL	= 3'b010;	// Shift Right Logical
localparam	SRA	= 3'b100;	// Shift Right Arithmetic
localparam	ROR	= 3'b110;	// Rotate Right (Right circular shift)
localparam	ROL	= 3'b111;	// Rotate Left (Left circular shift)
						
input	[31:0]  i_data;		// Input Data
input	[2:0]   shift_op;	// Shift operation mode
input	[4:0]   shift_amount;	// Shift amount constant
output	[31:0]	o_data;		// Shifted Input Data
	
wire	[63:0]	rshift = {i_data, i_data} >> shift_amount;
wire	[63:0]	lshift = {i_data, i_data} << shift_amount;
reg		[31:0]	shift_result;

always @* begin	
	casez (shift_op)
		SLL:	shift_result = lshift[31:0];	
		SRL:	shift_result = rshift[63:32];			
		SRA:   	shift_result = $signed(i_data) >>> shift_amount;		
		ROR:	shift_result = rshift[31:0];	
		ROL:	shift_result = lshift[63:32];
	endcase
end

assign o_data = shift_result;

endmodule
