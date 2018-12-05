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
	input freez,  
	output [len-1:0] pc_out, 
	output [len-1:0] instruction_out, 
	output wb_en_out, 
	output mem_write_out, 
	output mem_read_out, 
	output [len-1:0] src2_val_out, 
	output [4:0] dest_out, 
	output [len-1:0] alu_result_out);

    register_freezflush #(32) EXEMEM_PC(.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(pc), .output_value(pc_out));
    register_freezflush #(32) EXEMEM_INST(.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(instruction), .output_value(instruction_out));

    register_freezflush #(1) wb_en_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(wb_en), .output_value(wb_en_out));
    register_freezflush #(1) mem_write_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez),  .input_value(mem_write), .output_value(mem_write_out));
    register_freezflush #(1) mem_read_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez),  .input_value(mem_read), .output_value(mem_read_out));
    register_freezflush #(32) src2_val_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(src2_val), .output_value(src2_val_out));
    register_freezflush #(5) dest_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(dest), .output_value(dest_out));
    register_freezflush #(32) alu_result_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(alu_result), .output_value(alu_result_out));

endmodule