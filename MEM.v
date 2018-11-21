module MEM(
	input clock, 
	input reset,
	input mem_w_en, 
	input mem_r_en, 
	input [31:0] alu_result, 
	input [31:0] ST_value, 
	output [31:0] memory_result
);
	
	wire [31:0] address;

	AddressMapping am (.input_val(alu_result), .address(address)); 

	DataMemory dm (.clock(clock), .reset(reset), .address(address), .write_data(ST_value), .mem_r_en(mem_r_en), .mem_w_en(mem_w_en), .data(memory_result));

endmodule