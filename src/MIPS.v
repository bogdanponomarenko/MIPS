module MIPS(
	clk, 
	rst
);

/******************************************************************************/
// Clock and reset signals
input		clk;
input		rst;

// 'alu.v' signals
reg	[31:0]	alu_srcA;
reg	[31:0]	alu_srcB;
wire	[3:0]	alu_ctrl;
wire	[31:0]	alu_result;
wire		Zero;

// 'alu_control.v' signals
wire 	[5:0]	OpCode;
wire 	[5:0]	func;
wire		alu_shift_ctrl;

// 'control_unit.v' signals
wire		RegDst;
wire		RegWrite;
wire		ALUSrc;
wire		MemWrite;
wire		Beq;
wire		Bne;
wire		Jump;
wire		MemtoReg;

// 'data_memory.v' signals
wire	[31:0]	dm_wdata;
wire	[31:0]	dm_addr;
wire	[31:0]	dm_rdata;

// 'instruction_memory.v' signals
wire	[31:0]	instr_addr;
wire	[31:0]	Instruction;	// Instruction Memory Output Instruction - Imm32

// 'program_counter.v' signals
reg	[31:0]	pc_next_addr;
wire	[31:0]	pc_curr_addr;

// 'register_file.v' signals
wire 	[4:0]	regfile_addr1;
wire 	[4:0]	regfile_addr2;
reg  	[4:0]	regfile_addr3;
wire	[31:0]	regfile_wdata;
wire	[31:0]	regfile_rdata1;
wire	[31:0]	regfile_rdata2;

// 'sign_extender.v' signals
wire	[15:0]	se_input_instr;	// SignExtender input - Imm16
wire	[31:0]	se_ext_instr;	// SignExtender output

/*******************************/

// Program Counter

wire	[31:0]	pc_plus_4;
wire	[31:0]	pc_jump_0;
wire	[31:0]	pc_jump_1;
wire		PCSrc;

assign pc_plus_4 = pc_curr_addr + 32'd4;
assign pc_jump_0 = pc_plus_4 + {se_ext_instr[29:0], 2'b0};
assign pc_jump_1 = {pc_plus_4[31:28], {Instruction[25:0], 2'b0}};

assign PCSrc = (Beq & Zero) | (Bne & ~Zero);

always @* begin
	casez(Jump)
		1'b0:	begin
				casez(PCSrc)
					1'b0:	pc_next_addr = pc_plus_4;
					1'b1:	pc_next_addr = pc_jump_0;
				endcase
		end
		1'b1:	begin
				pc_next_addr = pc_jump_1;
		end
	endcase
end
				
program_counter program_counter_inst(
	.pc_next_addr		(pc_next_addr),
	.clk			(clk),
	.rst			(rst),
	.pc_curr_addr		(pc_curr_addr)
);

// Instruction Memory

assign instr_addr = pc_curr_addr;

instruction_memory instruction_memory_inst(
	.rom_addr	(instr_addr),
	.rom_rdata	(Instruction)
);

// ALU Control

assign OpCode = Instruction[31:26];
assign func = Instruction[5:0];

always @(*) begin
	casex(alu_shift_ctrl)
		1'b0: begin
				alu_srcA = regfile_rdata1;
		end
		1'b1: begin
				alu_srcA = {27'b0, Instruction[10:6]};
		end
	endcase
end

alu_control	alu_control_inst(
	.func		(func),
	.OpCode		(OpCode),
	.alu_shift_ctrl	(alu_shift_ctrl),
	.alu_ctrl	(alu_ctrl)
);

// Register File

reg		[31:0]	regfile_rw;

assign regfile_addr1 = Instruction[25:21];
assign regfile_addr2 = Instruction[20:16];
assign regfile_wdata = regfile_rw;

always @* begin
	casez(RegDst)
		1'b0:	regfile_addr3 = Instruction[20:16];
		1'b1:	regfile_addr3 = Instruction[15:11];
	endcase
end

always @* begin
	casez(MemtoReg)
		1'b0:	regfile_rw = alu_result;
		1'b1:	regfile_rw = dm_rdata;
	endcase
end

register_file register_file_inst(
	.regfile_addr1	(regfile_addr1),
	.regfile_addr2	(regfile_addr2),
	.regfile_addr3	(regfile_addr3),
	.regfile_wdata	(regfile_wdata),
	.RegWrite	(RegWrite),
	.clk		(clk),
	.rst		(rst),
	.regfile_rdata1	(regfile_rdata1),
	.regfile_rdata2	(regfile_rdata2)
);

// Sign Extender

assign se_input_instr = Instruction[15:0];

sign_extender sign_extender_inst(
	.i_data	(se_input_instr),
	.o_data	(se_ext_instr)
);

always @* begin
	casez(ALUSrc)
		1'b0:	alu_srcB = regfile_rdata2;
		1'b1:	alu_srcB = se_ext_instr;
	endcase
end

// ALU

alu alu_inst(
	.alu_srcA	(alu_srcA),
	.alu_srcB	(alu_srcB),
	.alu_control	(alu_ctrl),
	.alu_result	(alu_result),
	.Zero		(Zero)
);			    

// Control Unit

control_unit control_unit_inst(
	.OpCode		(OpCode),
	.RegDst		(RegDst), 
	.RegWrite	(RegWrite), 
	.ALUSrc		(ALUSrc),  
	.MemWrite	(MemWrite), 
	.Beq  		(Beq),
	.Bne  		(Bne),
	.Jump		(Jump),
	.MemtoReg	(MemtoReg)
 );

// Data Memory

assign dm_wdata = regfile_rdata2;
assign dm_addr = alu_result;

data_memory	data_memory_inst(
	.dm_wdata	(dm_wdata),
	.dm_addr	(dm_addr),
	.MemWrite	(MemWrite),
	.clk		(clk),
	.rst		(rst),
	.dm_rdata	(dm_rdata)
);

endmodule
