module EXEMEM #(parameter len) (
	input clock, 
	input reset, 
	input wb_en, 
	input mem_write, 
	input mem_read, 
	input [len-1:0] pc, 
	input [len-1:0] instruction, 
	input [len-1:0] src2_val, 
	input [4:0] dest, 
	input [len-1:0] alu_result, 
	output [len-1:0] pc_out, 
	output [len-1:0] instruction_out, 
	output wb_en_out, 
	output mem_write_out, 
	output mem_read_out, 
	output [len-1:0] src2_val_out, 
	output [4:0] dest_out, 
	output [len-1:0] alu_result_out);

    register #(32) EXEMEM_PC(.clock(clock), .reset(reset), .input_value(pc), .output_value(pc_out));
    register #(32) EXEMEM_INST(.clock(clock), .reset(reset), .input_value(instruction), .output_value(instruction_out));

    register #(32) wb_en_reg (.clock(clock), .reset(reset), .input_value(wb_en), .output_value(wb_en_out));
    register #(32) mem_write_reg (.clock(clock), .reset(reset), .input_value(mem_write), .output_value(mem_write_out));
    register #(32) mem_read_reg (.clock(clock), .reset(reset), .input_value(mem_read), .output_value(mem_read_out));
    register #(32) src2_val_reg (.clock(clock), .reset(reset), .input_value(src2_val), .output_value(src2_val_out));
    register #(5) dest_reg (.clock(clock), .reset(reset), .input_value(dest), .output_value(dest_out));
    register #(32) alu_result_reg (.clock(clock), .reset(reset), .input_value(alu_result), .output_value(alu_result_out));

endmodule