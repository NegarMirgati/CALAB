module IFID #(parameter len) (
	input clock, 
	input reset, 
	input flush, 
	input [len-1:0] pc, 
	input [len-1:0] instruction, 
	output [len-1:0] pc_out, 
	output [len-1:0] instruction_out);

    register #(len) IFID_PC(clock, reset, pc, pc_out);
    register #(len) IFID_INST(clock, reset, instruction, instruction_out);

endmodule