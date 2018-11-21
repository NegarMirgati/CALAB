module EXE(
	input [1:0] branch_type, 
	input [31:0] src2_val, 
	input [31:0] val2, val1, 
	input [31:0] pc, 
	input [3:0] exe_cmd,
	input [1:0] src2_val_selector, val1_selector, val2_selector,
	input [31:0] mem_alu_result, wb_data,
	output [31:0] alu_result, 
	output [31:0] branch_address,
	output branch_taken, 
	output [31:0] src2_val_out
	);

	wire [31:0] selected_alu_inp1, selected_alu_inp2;

	MUX3INPUT #(32) alu_input1_mux (.value1(val1),.value2(mem_alu_result), .value3(wb_data), .selector(val1_selector), .out_val(selected_alu_inp1));
	MUX3INPUT #(32) alu_input2_mux (.value1(val2),.value2(mem_alu_result), .value3(wb_data), .selector(val2_selector), .out_val(selected_alu_inp2));
	MUX3INPUT #(32) src_2_val_mux (.value1(src2_val),.value2(mem_alu_result), .value3(wb_data), .selector(src2_val_selector), .out_val(src2_val_out));

  	wire[31:0] shifted_val2 = selected_alu_inp2 << 2;
	Adder pc_adder (.value1(shifted_val2), .value2(pc), .out_val(branch_address));
	ALU exe_alu (.input_val1(selected_alu_inp1), .input_val2(selected_alu_inp2), .exe_cmd(exe_cmd), .output_val(alu_result));
	ConditionCheck cc (.val1(selected_alu_inp1), .src2_val(src2_val_out), .branch_type(branch_type), .branch_taken(branch_taken)); 

endmodule