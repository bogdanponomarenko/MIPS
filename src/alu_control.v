module alu_control(
	func,
	OpCode,
	alu_shift_ctrl,
	alu_ctrl
);

localparam	OP_RTYPE = 6'b000000;	// R-type common instructions
localparam	ADD	= 6'b100000;	// ADD - Add (with overflow)	
localparam	SUB	= 6'b100010;	// SUB - Subtract
localparam	AND	= 6'b100100;	// AND - Bitwise 'AND'
localparam	OR	= 6'b100101;	// OR  - Bitwise 'OR'
localparam	XOR	= 6'b100110;	// XOR - Bitwise exclusive 'OR'
localparam	NOR	= 6'b100111;	// NOR - Bitwise negation of 'OR'
localparam	SLT	= 6'b101010;	// SLT - Set on less than (signed)	
localparam	SLL	= 6'b000000;	// SLL - Shift Left Logical	
localparam	SRL	= 6'b000010;	// SRL - Shift Right Logical
localparam	SRA	= 6'b000011; 	// SRA - Shift Right Arithmetic	
localparam	ROR	= 6'b000100;	// ROR - Rotate Right (Right circular shift)
localparam	ROL	= 6'b000101;	// ROL - Rotate Left (Left circular shift)
localparam	OP_ADDI  = 6'b001000;	// ADDI - Add immediate (with overflow)
localparam	OP_SLTI  = 6'b001010;	// SLTI - Set on less than immediate(signed)
localparam	OP_ANDI  = 6'b001100;	// ANDI - Bitwise and immediate
localparam	OP_ORI   = 6'b001101;	// ORI  - Bitwise or immediate
localparam	OP_XORI  = 6'b001110;	// XORI	- Bitwise exclusive or immediate
localparam	OP_J     = 6'b000010;	// J	- Jump
localparam	OP_BEQ   = 6'b000100;	// BEQ	- Branch on equal
localparam	OP_BNE   = 6'b000101;	// BNE	- Branch on not equal
localparam	OP_LW    = 6'b100011; 	// LW	- Load word
localparam	OP_SW    = 6'b101011;	// SW	- Store word

input		[5:0]	func;		// Function field for R-type instructions
input		[5:0]	OpCode;		// Operation code of the instruction
output reg	[3:0]	alu_ctrl;	// Signal for choosing operation to be executed
output reg		alu_shift_ctrl;	// Shift control signal

always @* begin		
	casez (OpCode)
		OP_RTYPE:	
			casez(func)
				ADD: begin
					alu_ctrl = 4'b0010;
					alu_shift_ctrl = 1'b0;
				end
				SUB: begin
					alu_ctrl = 4'b0110;	
					alu_shift_ctrl = 1'b0;
				end
				AND: begin
					alu_ctrl = 4'b0011;	
					alu_shift_ctrl = 1'b0;
				end
				OR: begin
					alu_ctrl = 4'b0111;
					alu_shift_ctrl = 1'b0;
				end
				XOR: begin
					alu_ctrl = 4'b1111;
					alu_shift_ctrl = 1'b0;
				end
				NOR: begin
					alu_ctrl = 4'b1011;
					alu_shift_ctrl = 1'b0;
				end
				SLT: begin
					alu_ctrl = 4'b0001;
					alu_shift_ctrl = 1'b0;
				end
				SLL: begin
					alu_ctrl = 4'b1000;
					alu_shift_ctrl = 1'b1;
				end
				SRL: begin
					alu_ctrl = 4'b1001;
					alu_shift_ctrl = 1'b1;
				end
				SRA: begin
					alu_ctrl = 4'b1010;
					alu_shift_ctrl = 1'b1;
				end
				ROR: begin
					alu_ctrl = 4'b1110;
					alu_shift_ctrl = 1'b1;
				end
				ROL: begin
					alu_ctrl = 4'b1101;
					alu_shift_ctrl = 1'b1;
				end
				default: begin
						alu_ctrl = 4'bx;
						alu_shift_ctrl = 1'bx;
				end
			endcase
		OP_ADDI: begin
				alu_ctrl = 4'b0010;	
				alu_shift_ctrl = 1'b0;
		end
		OP_SLTI: begin
				alu_ctrl = 4'b0001;	
				alu_shift_ctrl = 1'b0;
		end
		OP_ANDI: begin
				alu_ctrl = 4'b0011;
				alu_shift_ctrl = 1'b0;
			end
		OP_ORI:	begin
				alu_ctrl = 4'b0111;
				alu_shift_ctrl = 1'b0;
		end
		OP_XORI: begin
				alu_ctrl = 4'b1111;
				alu_shift_ctrl = 1'b0;
		end
		OP_J: begin
				alu_ctrl = 4'bx;
				alu_shift_ctrl = 1'b0;
		end
		OP_BEQ: begin
				alu_ctrl = 4'b0110;
				alu_shift_ctrl = 1'b0;
		end
		OP_BNE:	begin 
				alu_ctrl = 4'b0110;
				alu_shift_ctrl = 1'b0;
		end
		OP_LW: begin
				alu_ctrl = 4'b0010;
				alu_shift_ctrl = 1'b0;
		end
		OP_SW: begin
				alu_ctrl = 4'b0010;
				alu_shift_ctrl = 1'b0;
		end
		default:	begin
					alu_ctrl = 4'bx;
					alu_shift_ctrl = 1'bx;
		end
	endcase
end

endmodule
