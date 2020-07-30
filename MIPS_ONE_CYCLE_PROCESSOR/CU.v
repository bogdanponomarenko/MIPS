module CU(OpCode, RegDst, RegWrite, ALUSrc, MemWrite, Branch, Jump, MemtoReg);

localparam	OP_RTYPE = 6'b000000, 
		OP_ADDI  = 6'b001000, 
		OP_SLTI  = 6'b001010,
		OP_ANDI  = 6'b001100,
		OP_ORI   = 6'b001101,
		OP_XORI  = 6'b001110,
		OP_J     = 6'b000010, 
		OP_BEQ   = 6'b000100, 
		OP_BNE   = 6'b000101,
		OP_LW    = 6'b100011, 
		OP_SW    = 6'b101011;

input	[5:0] OpCode;
output	reg   RegDst, RegWrite, ALUSrc, MemWrite, Branch, Jump, MemtoReg;

always @(*) begin
  // Default values placeholder
    		  RegDst    = 1'b0;  
                  RegWrite  = 1'b0;  
                  ALUSrc    = 1'b0;  
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
  // Match logic
  casez(OpCode)
    // R-type common instructions
    OP_RTYPE  : begin               
                  RegDst    = 1'b1; // 1: RW<=Rd
                  RegWrite  = 1'b1; // 1: Write RW
                  ALUSrc    = 1'b0; // 0: ALU_B<=BusB
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                  end
                
    // I-type instructions
    OP_ADDI   : begin
                  RegDst    = 1'b0; // 0: RW<=Rt
                  RegWrite  = 1'b1; // 1: Write RW
                  ALUSrc    = 1'b1; // 1: ALU_B<=Imm
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                end
         
    OP_SLTI   : begin
                  RegDst    = 1'b0; // 0: RW<=Rt
                  RegWrite  = 1'b1; // 1: Write RW
                  ALUSrc    = 1'b1; // 1: ALU_B<=Imm
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                end
                
    OP_ANDI   : begin
                  RegDst    = 1'b0; // 0: RW<=Rt
                  RegWrite  = 1'b1; // 1: Write RW
                  ALUSrc    = 1'b1; // 1: ALU_B<=Imm
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                end
                
    OP_ORI    : begin
                  RegDst    = 1'b0; // 0: RW<=Rt
                  RegWrite  = 1'b1; // 1: Write RW
                  ALUSrc    = 1'b1; // 1: ALU_B<=Imm
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                end
                
    OP_XORI   : begin
                  RegDst    = 1'b0; // 0: RW<=Rt
                  RegWrite  = 1'b1; // 1: Write RW
                  ALUSrc    = 1'b1; // 1: ALU_B<=Imm
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                end
                
    // Special instructions
    OP_J      : begin
                  RegDst    = 1'bx; // RW<= dont care
                  RegWrite  = 1'b0; // 0: No write
                  ALUSrc    = 1'bx; // ALU_B<= dont care
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b1;
                  MemtoReg  = 1'b0;
                end
                
    OP_BEQ    : begin                                
                  RegDst    = 1'bx; // RW<= dont care
                  RegWrite  = 1'b0; // 0: No write
                  ALUSrc    = 1'b0; // 0: ALU_B<=BusB
                  MemWrite  = 1'b0;
                  Branch    = 1'b1;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                end
                
    OP_BNE    : begin
                  RegDst    = 1'bx; // RW<= dont care
                  RegWrite  = 1'b0; // 0: No write
                  ALUSrc    = 1'b0; // 0: ALU_B<=BusB
                  MemWrite  = 1'b0;
                  Branch    = 1'b1;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                end
                
    OP_LW     : begin
                  RegDst    = 1'b0; // 0: RW<=Rt
                  RegWrite  = 1'b1; // 1: Write RW
                  ALUSrc    = 1'b1; // 1: ALU_B<=Imm
                  MemWrite  = 1'b0;
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b1;
                end
                
    OP_SW     : begin
                  MemWrite  = 1'b1;
                  RegDst    = 1'bx; // RW<= dont care
                  RegWrite  = 1'b0; // 0: No write
                  ALUSrc    = 1'b1; // 1: ALU_B<=Imm
                  Branch    = 1'b0;
                  Jump      = 1'b0;
                  MemtoReg  = 1'b0;
                end
                
    // No match placeholder
    default: 	begin
                  // Set all as X - 
                  // error visible during simultaion,
                  // full case during synthesis.
                  RegDst    = 1'bx;
                  RegWrite  = 1'bx;
                  ALUSrc    = 1'bx;
                  MemWrite  = 1'bx;
                  Branch    = 1'bx;
                  Jump      = 1'bx;
		  MemtoReg  = 1'bx;
                end
  endcase
end
endmodule