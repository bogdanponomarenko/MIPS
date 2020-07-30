module alu (SrcA, SrcB, ALU_Control, ALU_Result, Zero, Shift_Amount);
							
input   [31:0] SrcA, SrcB;
input   [3:0]  ALU_Control;
input	[4:0]  Shift_Amount;

output  reg [31:0] ALU_Result;
output  reg Zero;

wire    [31:0] shift;
reg	[2:0]  shift_op;

barrel_shifter barrel_shifter_inst	(
					.i_data   	(SrcA),
					.sa       	(Shift_Amount),
					.shift_op 	(shift_op),
					.o_data   	(shift)
					);
										
always@ (*)    begin 
        casez(ALU_Control) 
		4'b1000:	begin
				shift_op	= 3'b001;			//SLL
				ALU_Result	= shift;
				end
		
		4'b1001:	begin
				shift_op	= 3'b010;			//SRL
				ALU_Result 	= shift; 
				end
		
		4'b1010:	begin
				shift_op	= 3'b100;			//SRA
				ALU_Result 	= shift; 
				end
				
		4'b1110:	begin
				shift_op	= 3'b110;			//ROR
				ALU_Result 	= shift; 
				end
		
		4'b1101:	begin
				shift_op	= 3'b111;			//ROL
				ALU_Result 	= shift;  				
				end

		4'b0001:	ALU_Result = (SrcA < SrcB) ?  32'd1 : 32'd0;	// slt
			
		4'b0010:	ALU_Result = SrcA + SrcB;			// Add, addi, lw, sw
			
		4'b0110:	ALU_Result = SrcA - SrcB;			// Sub, bne, beq

		4'b0011:	ALU_Result = SrcA & SrcB;			//  Logical 'and', andi
			
		4'b0111:	ALU_Result = SrcA | SrcB;			//  Logical 'or', ori
			
		4'b1011:	ALU_Result = ~(SrcA | SrcB);			//  Logical 'nor'
			
		4'b1111:	ALU_Result = SrcA ^ SrcB;			//  Logical 'xor', xori
		
		default:	ALU_Result = 32'bx; 	
		
	endcase
		 Zero = ~|ALU_Result;				
end
endmodule