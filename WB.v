module WB(
	input mem_r_en, 
	input [31:0] alu_result, 
	input [31:0] memory_result, 
	output [31:0] result_wb
);

	MUX wb_m(.value2(memory_result), .value1(alu_result),  .selector(mem_r_en), .out_val(result_wb));

endmodule