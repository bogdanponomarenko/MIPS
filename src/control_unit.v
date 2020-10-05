module control_unit(
	OpCode, 
	RegDst, 
	RegWrite, 
	ALUSrc, 
	MemWrite, 
	Beq,
	Bne, 
	Jump, 
	MemtoReg
);

localparam	OP_RTYPE = 6'b000000;	// R-type common instructions
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

input		[5:0]	OpCode;		// Instruction machine code
output reg   		RegDst;		// Selects the destination register
output reg   		RegWrite;	// Enables/disables writing to register file
output reg   		ALUSrc;		// Selects the second ALU source
output reg   		MemWrite;	// Enbales/disables writing to DataMemory
output reg   		Beq;		// Enbales/disables Beq instruction
output reg   		Bne;		// Enbales/disables Bne instruction
output reg   		Jump;		// Enbales/disables Jump inctruction
output reg   		MemtoReg;	// Selects Input Data source for register file

always @* begin
	// Initialize control signals with default values
	RegDst		= 1'b0;  
	RegWrite	= 1'b0;  
	ALUSrc		= 1'b0;  
	MemWrite	= 1'b0;
	Beq		= 1'b0;
	Bne		= 1'b0;
	Jump		= 1'b0;
	MemtoReg	= 1'b0;

	casez (OpCode)
		OP_RTYPE: begin               
				RegDst		= 1'b1;	// RW <= Rd
				RegWrite	= 1'b1;	// Enable writing to register file
				ALUSrc		= 1'b0;	// ALU_B <= BusB
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'b0;	// BusW <= ALU_output
		end           
		OP_ADDI: begin
				RegDst		= 1'b0;	// RW <= Rt
				RegWrite	= 1'b1;	// Enable writing to register file
				ALUSrc		= 1'b1;	// ALU_B <= Imm
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'b0;	// BusW <= ALU_output
		end			 
		OP_SLTI: begin
				RegDst		= 1'b0;	// RW <= Rt
				RegWrite	= 1'b1;	// Enable writing to register file
				ALUSrc		= 1'b1;	// ALU_B <= Imm
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'b0;	// BusW <= ALU_output
		end				
		OP_ANDI: begin
				RegDst		= 1'b0;	// RW <= Rt
				RegWrite	= 1'b1;	// Enable writing to register file
				ALUSrc		= 1'b1;	// ALU_B <= Imm
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'b0;	// BusW <= ALU_output
		end					
		OP_ORI: begin
				RegDst		= 1'b0;	// RW <= Rt
				RegWrite	= 1'b1;	// Enable writing to register file
				ALUSrc		= 1'b1;	// ALU_B <= Imm
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'b0;	// BusW <= ALU_output
		end	
		OP_XORI: begin
				RegDst		= 1'b0;	// RW <= Rt
				RegWrite	= 1'b1;	// Enable writing to register file
				ALUSrc		= 1'b1;	// ALU_B <= Imm
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'b0;	// BusW <= ALU_output
		end					
		OP_J: begin
				RegDst		= 1'bx;	// RW <= don't care
				RegWrite	= 1'b0;	// Disable writing to register file
				ALUSrc		= 1'b0;	// ALU_B <= don't care
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'bx;	// Disable Beq instruction
				Bne		= 1'bx;	// Disable Bne instruction
				Jump		= 1'b1;	// Enable Jump instruction
				MemtoReg	= 1'bx;	// BusW <= ALU_output
		end					
		OP_BEQ:	begin                                
				RegDst		= 1'bx;	// RW <= don't care
				RegWrite	= 1'b0;	// Disable writing to register file
				ALUSrc		= 1'b0;	// ALU_B <= BusB
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b1;	// Enable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'bx;	// BusW <= ALU_output
		end
		OP_BNE:	begin
				RegDst		= 1'bx;	// RW <= don't care
				RegWrite	= 1'b0;	// Disable writing to register file
				ALUSrc		= 1'b0;	// ALU_B <= BusB
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b1;	// Enable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'bx;	// BusW <= ALU_output
		end				
		OP_LW: begin
				RegDst		= 1'b0;	// RW <= Rt
				RegWrite	= 1'b1;	// Enable writing to register file
				ALUSrc		= 1'b1;	// ALU_B <= Imm
				MemWrite	= 1'b0;	// Don't store instructions
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'b1;	// BusW <= DataMemory_output
		end					
		OP_SW: begin
				RegDst		= 1'bx;	// RW <= don't care
				RegWrite	= 1'b0;	// Disable writing to register file
				ALUSrc		= 1'b1;	// ALU_B <= Imm
				MemWrite	= 1'b1;	// Store instructions to DataMemory
				Beq		= 1'b0;	// Disable Beq instruction
				Bne		= 1'b0;	// Disable Bne instruction
				Jump		= 1'b0;	// Disable Jump instruction
				MemtoReg	= 1'bx;	// BusW <= ALU_output
		end					
		default: begin
				RegDst		= 1'bx;
				RegWrite	= 1'bx;
				ALUSrc		= 1'bx;
				MemWrite	= 1'bx;
				Beq		= 1'bx;
				Bne		= 1'bx;
				Jump		= 1'bx;
				MemtoReg	= 1'bx;
		end
	endcase
end

endmodule
