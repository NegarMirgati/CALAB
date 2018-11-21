module IFID #(parameter len) (
	input clock, 
	input reset, 
	input flush, 
	input freez,
	input [len-1:0] pc, 
	input [len-1:0] instruction, 
	output [len-1:0] pc_out, 
	output [len-1:0] instruction_out);

    register_freezflush #(len) IFID_PC(.clock(clock), .reset(reset), .flush(flush), .freez(freez) .input_value(pc), .output_value(pc_out));
    register_freezflush #(len) IFID_INST(.clock(clock), .reset(reset), .flush(flush), .freez(freez), .input_value(instruction), .output_value(instruction_out));

endmodule