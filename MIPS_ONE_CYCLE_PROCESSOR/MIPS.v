module MIPS(
input clk,
input rst
);

/*************************************************************************************************/
wire Branch, Zero;
wire PCSrc, Jump;

wire [31:0] Instruction;
reg [31:0] PC_input_one, input_pc;
wire [31:0] Sign_Immediate, PC_Plus_4, PCJump, PCBranch, instruction_address;
wire [27:0] Shifted_Instruction;

assign Shifted_Instruction = Instruction[25:0] << 2;
assign PCSrc = Branch & Zero;
assign PC_Plus_4 = instruction_address + 3'b100;
assign PCBranch = (Sign_Immediate[29:0] << 2 ) + PC_Plus_4;
assign PCJump = {PC_Plus_4[31:28],Shifted_Instruction};

always @(*) begin
	casez(PCSrc)
		1'b0: PC_input_one = PC_Plus_4;
		1'b1: PC_input_one = PCBranch;
	endcase
end

always @(*) begin
	casez(Jump)
		1'b0: input_pc = PC_input_one;
		1'b1: input_pc = PCJump;
	endcase
end
					
program_counter mips_program_counter(
				    .input_pc	(input_pc),
				    .output_pc	(instruction_address),
				    .rst	(rst),
				    .clk	(clk)
				    );
/*************************************************************************************************/
instruction_memory mips_instruction_memory(
					  .i_addr	(instruction_address),
					  .o_data	(Instruction)
					  );
/*************************************************************************************************/
wire [5:0] Op, Funct;
wire [4:0] A1, A2;
reg [4:0] WriteReg;
wire [31:0] data_A, data_B, ALU_Result, Read_Data;
reg [31:0] Write_Data;

wire RegDst;
wire RegWrite, MemtoReg;
wire [31:0] SrcA;
reg [31:0] SrcB;

assign Op 			= Instruction[31:26];
assign Funct			= Instruction[5:0];
assign A1			= Instruction[25:21];
assign A2			= Instruction[20:16];


always @(*) begin
	casez(RegDst)
		1'b0: WriteReg = Instruction[20:16];
		1'b1: WriteReg = Instruction[15:11];
	endcase
end

always @(*) begin
	casez(MemtoReg)
		1'b0: Write_Data = ALU_Result;
		1'b1: Write_Data = Read_Data;
	endcase
end

register_file mips_register_file(
				.Register_Adress_A	(A1),
				.Register_Adress_B	(A2),
				.Register_Write_Adress	(WriteReg),
				.Write_Data		(Write_Data),
				.RegWrite		(RegWrite),
				.data_A			(data_A),
				.data_B			(data_B),
				.clk			(clk),
				.rst			(rst)
				);
/*************************************************************************************************/				
sign_extender mips_sign_extender(
				.i_data		(Instruction[15:0]),
				.o_data		(Sign_Immediate)
				);
				
/*************************************************************************************************/				
wire [3:0] ALU_Control;
alu_control mips_alu_control(
			    .opcode	(Op),
			    .func	(Funct),
			    .alu_op	(ALU_Control)
			    );
/*************************************************************************************************/			
wire ALUSrc;
wire [4:0] Shift_Amount;

assign SrcA = data_A;
assign Shift_Amount = Instruction[10:6];
always @(*) begin
	casez(ALUSrc)
		1'b0: SrcB = data_B;
		1'b1: SrcB = Sign_Immediate;
	endcase
end

alu mips_alu(
	    .SrcA		(SrcA),
	    .SrcB		(SrcB),
	    .ALU_Control	(ALU_Control),
	    .Shift_Amount	(Shift_Amount),
	    .ALU_Result		(ALU_Result),
	    .Zero		(Zero)
	    );			    
/*************************************************************************************************/			    
wire MemWrite;

CU mips_main_control	(
			.OpCode		(Op),
			.RegDst		(RegDst), 
			.RegWrite	(RegWrite), 
			.ALUSrc		(ALUSrc),  
			.MemWrite	(MemWrite), 
			.MemtoReg	(MemtoReg),
			.Branch  	(Branch),
			.Jump		(Jump)
			);
			      
/*************************************************************************************************/		      		      	    					
data_memory mips_data_memory(
			    .Write_Data	(data_B),
			    .Address	(ALU_Result),
			    .MemWrite	(MemWrite),
			    .clk	(clk),
			    .rst	(rst),
			    .Read_Data	(Read_Data)
			    );
/*************************************************************************************************/		    
endmodule
