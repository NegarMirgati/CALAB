module MEMWB #(parameter len) (
	input clock, 
	input reset, 
	input wb_en, mem_r_en, 
	input [31:0] memory_data, 
	input [4:0] dest,
    input [31:0] alu_result, 
    input freez,
    output [31:0] alu_result_out, 
    output [31:0] memory_result_out,
    output mem_r_en_out, 
    output [4:0] dest_out,
    output wb_en_out
	);
	
	register_freezflush #(1) wb_en_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(wb_en), .output_value(wb_en_out));
    register_freezflush #(1) mem_read_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(mem_r_en), .output_value(mem_r_en_out));
    register_freezflush #(5) dest_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(dest), .output_value(dest_out));
    register_freezflush #(32) alu_result_reg (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(alu_result), .output_value(alu_result_out));
    register_freezflush #(32) memory_result (.clock(clock), .reset(reset), .flush(1'b0), .freez(freez), .input_value(memory_data), .output_value(memory_result_out));

	

    
endmodule