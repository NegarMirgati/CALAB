module IDEXE #(parameter len) (intput clock, intput reset, input [len-1:0] pc, input [len-1:0] instruction, output [len-1:0] pc_out, output [len-1:0] instruction_out);

    register #(32) IDEXE_PC(clock, reset, pc, pc_out);
    register #(32) IDEXE_INST(clock, reset, instruction, instruction_out);

endmodule