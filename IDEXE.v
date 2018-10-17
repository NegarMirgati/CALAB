module IDEXE #(parameter len)(input clock, input reset, input [len-1:0] pc, input [len-1:0] instruction,
                              input wb_en, mem_read, mem_write, flsuh, 
                              input [1:0] branch_type,
                              input [3:0] exe_cmd,
                              input [31:0] reg2,
                              input [31:0] alu_inp1, alu_inp2,
                              input [4:0] dest, 
                              output [len-1:0] pc_out, output [len-1:0] instruction_out);

    register #(32) IDEXE_PC(clock, reset, pc, pc_out);
    register #(32) IDEXE_INST(clock, reset, instruction, instruction_out);

endmodule