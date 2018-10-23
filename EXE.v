module EXE(
	input [1:0] branch_type, 
	input [31:0] src2_val, 
	input [31:0] val2, val1, 
	input [31:0] pc, 
	input [3:0] exe_cmd,
	output reg [31:0] alu_result, 
	output [31:0] branch_address,
	output branch_tacken
	);

	Adder pc_adder (.value1(val2), .value2(pc), .out_val(branch_address));
	ALU exe_alu (.input_val1(val1), .input_val2(val2), .exe_cmd(exe_cmd), .output_val(alu_result));

endmodule