module alu(
	alu_srcA, 
	alu_srcB,
	alu_control, 
	alu_result, 
	Zero
);

// Parameters
localparam	SLL	= 4'b1000;	// SLL - Shift Left Logical
localparam	SRL	= 4'b1001;	// SRL - Shift Right Logical
localparam	SRA	= 4'b1010;	// SRA - Shift Right Arithmetic
localparam	ROR	= 4'b1110;	// ROR - Rotate Right (Right circular shift)
localparam	ROL	= 4'b1101;	// ROL - Rotate Left (Left circular shift)
localparam	SLT	= 4'b0001;	// SLT - Set on less than (signed)
localparam	ADD	= 4'b0010;	// ADD - Add (with overflow)	
localparam	SUB	= 4'b0110;	// SUB - Subtract
localparam	AND	= 4'b0011;	// AND - Bitwise 'AND'
localparam	OR	= 4'b0111; 	// OR  - Bitwise 'OR'	
localparam	NOR	= 4'b1011;	// NOR - Bitwise negation of 'OR'	
localparam	XOR	= 4'b1111;	// XOR - Bitwise exclusive 'OR'	

input		[31:0]	alu_srcA;		// A operand
input		[31:0]	alu_srcB;		// B operand
input		[3:0]	alu_control;	// Control signal (derived from the OpCode)
output reg	[31:0]	alu_result;		// Output result of ALU
output				Zero;			// Zero flag for examining ALU

wire		[31:0]	shifted_data;	// Shifted Data (from barrel_shifter)
wire		[4:0]	shift_amount;	// Shift amount constant

reg			[2:0]	shift_op;		// Shift operation mode

integer	i;

assign Zero = ~|alu_result;
assign shift_amount = alu_srcA[4:0];

barrel_shifter barrel_shifter_inst(
	.i_data			(alu_srcB),
	.shift_amount	(shift_amount),
	.shift_op		(shift_op),
	.o_data			(shifted_data)
);
	
always @* begin 	
	casez (alu_control) 	
		SLL: begin
				shift_op	= 3'b001;			
				alu_result	= shifted_data;
		end		
		SRL: begin	
				shift_op	= 3'b010;			
				alu_result 	= shifted_data; 
		end		
		SRA: begin	
				shift_op	= 3'b100;			
				alu_result 	= shifted_data; 
		end			
		ROR: begin	
				shift_op	= 3'b110;			
				alu_result 	= shifted_data; 
		end		
		ROL: begin	
				shift_op	= 3'b111;			
				alu_result 	= shifted_data;  				
		end
		SLT: begin
				alu_result = alu_srcA < alu_srcB ? 32'd1 : 32'd0;		
		end
		ADD: begin
				alu_result = alu_srcA + alu_srcB;						
		end
		SUB: begin
				alu_result = alu_srcA - alu_srcB;					
		end
		AND: begin
				alu_result = alu_srcA & alu_srcB;						
		end
		OR:	begin
				alu_result = alu_srcA | alu_srcB;					
		end
		NOR: begin
				for (i = 31; i >= 0; i = i - 1) begin
					if ((alu_srcA[i]) || (alu_srcB[i]) == 1'b1) begin
						alu_result[i] = ((alu_srcA[i] || alu_srcB[i]) == 1'b1) ? 1'b0 : 1'b1;
						i = i - 1;
					end	
				end
		end
		XOR: begin
				alu_result = alu_srcA ^ alu_srcB;						
		end
		default:	alu_result = 32'bx; 	
	endcase				
end

endmodule