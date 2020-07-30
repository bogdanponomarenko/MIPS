module alu_control(opcode, func, alu_op);

input      [5:0] func, opcode;
output reg [3:0] alu_op;

always @(*) begin		
		casez (opcode)
			6'b000000: // if we have R-type opetations
				casez(func)
					6'b100000: //add
						alu_op = 4'b0010;
					6'b100100: //and
						alu_op = 4'b0011;	
					6'b100111: //nor
						alu_op = 4'b1011;		
					6'b100101://or
						alu_op = 4'b0111;	
					6'b101010://slt
						alu_op = 4'b0001;	
					6'b100010://sub
						alu_op = 4'b0110;	
					6'b100110://xor
						alu_op = 4'b1111;	
					6'b110000://SLL				
						alu_op = 4'b1000;	
					6'b101000://SRL
						alu_op = 4'b1001;	
					6'b101111://SRA
						alu_op = 4'b1010;	
					6'b100001://ROR
						alu_op = 4'b1110;	
					6'b110001://ROL
						alu_op = 4'b1101;	
					default:
					   	alu_op = 4'bx;
				endcase
			6'b001000: //addi
				alu_op = 4'b0010;
			6'b001010: //slti
				alu_op = 4'b0001;
			6'b001100: //andi
				alu_op = 4'b0011;
			6'b001101: //ori
				alu_op = 4'b0111;
			6'b001110: //xori
				alu_op = 4'b1111;
			6'b100011://lw
				alu_op = 4'b0010;
			6'b101011://sw
				alu_op = 4'b0010; 
			6'b000101://bne
				alu_op = 4'b0110;
			6'b000100://beq
				alu_op = 4'b0110;
			default:
				alu_op = 4'bx;
		endcase
end
endmodule