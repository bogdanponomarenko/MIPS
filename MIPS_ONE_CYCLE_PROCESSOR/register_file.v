module register_file (Register_Adress_A, Register_Adress_B, Register_Write_Adress, Write_Data, RegWrite, data_A, data_B, rst, clk);

input	[4:0]	Register_Adress_A, Register_Adress_B;
input   [4:0]	Register_Write_Adress;
input		clk, rst, RegWrite;
input  	[31:0] 	Write_Data;
output 	[31:0]	data_A,data_B;

reg [31:0] Register [31:0];
integer i;

assign data_A  = Register[Register_Adress_A];
assign data_B  = Register[Register_Adress_B];
			
always @(posedge clk) 
	begin
		if (rst) begin
			for (i=0; i<31; i=i+1)
	                	Register[i] <= 0;
		end
	                
		else if(RegWrite) begin 
			Register[Register_Write_Adress] <= Write_Data;
		end
	end	
	
endmodule