/*
	Function for extension nuumber. 
	It extends input 16-bit code to 32-bit code. 
	It consists of the same 16 elder bits, 
	that are equal to eldest bit of input 16-bit code, 
	and of input 16-bit code itself.
*/

module sign_extender(i_data, o_data);

input  [15:0] i_data;
output [31:0] o_data;

assign o_data = {{16{i_data[15]}}, i_data};

endmodule