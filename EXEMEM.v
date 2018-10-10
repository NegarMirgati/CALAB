module EXEMEM #(parameter len) (input clock, input reset, input [len-1:0] pc, input [len-1:0] instruction, output [len-1:0] pc_out, output [len-1:0] instruction_out);

    register #(32) EXEMEM_PC(clock, reset, pc, pc_out);
    register #(32) EXEMEM_INST(clock, reset, instruction, instruction_out);

endmodule