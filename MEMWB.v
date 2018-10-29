module MEMWB #(parameter len) (
	input clock, 
	input reset, 
	input wb_en, mem_r_en, 
	input [31:0] memory_data, 
	input [4:0] dest,
    input [31:0] alu_result_out, 
    output [31:0] memory_result_out,
    output mem_r_en_out, 
    output [4:0] dest_out
	);

    register #(32) MEMWB_PC(clock, reset, pc, pc_out);
    register #(32) MEMWB_INST(clock, reset, instruction, instruction_out);
    
endmodule