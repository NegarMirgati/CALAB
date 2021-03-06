module IDEXE #(parameter len)(input clock, input reset, input [len-1:0] pc, input [len-1:0] instruction,
                              input wb_en, mem_read, mem_write, flush, freez,
                              input [1:0] branch_type,
                              input [3:0] exe_cmd,
                              input [31:0] reg2,
                              input [31:0] alu_inp1, alu_inp2,
                              input [4:0] dest, 
                              input two_regs,
                              output [len-1:0] pc_out, output [len-1:0] instruction_out,
                              output wb_en_out, mem_read_out, mem_write_out,
                              output [1:0] branch_type_out,
                              output [3:0] exe_cmd_out,
                              output [31:0] reg2_out,
                              output [31:0] alu_inp1_out, alu_inp2_out,
                              output [4:0] dest_out,
                              output two_regs_out);

    register_freezflush #(32) IDEXE_PC(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(pc), .output_value(pc_out));
    register_freezflush #(32) IDEXE_INST(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(instruction), .output_value(instruction_out));
    register_freezflush #(1) wb_en_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(wb_en), .output_value(wb_en_out));
    register_freezflush #(1) mem_read_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(mem_read), .output_value(mem_read_out));
    register_freezflush #(1) mem_write_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(mem_write), .output_value(mem_write_out));
    register_freezflush #(2) branch_type_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(branch_type), .output_value(branch_type_out));
    register_freezflush #(4) exe_cmd_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(exe_cmd), .output_value(exe_cmd_out));
    register_freezflush #(32) reg2_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(reg2), .output_value(reg2_out));
    register_freezflush #(32) alu_inp1_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(alu_inp1), .output_value(alu_inp1_out));
    register_freezflush #(32) alu_inp2_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(alu_inp2), .output_value(alu_inp2_out));
    register_freezflush #(5) dest_reg(.clock(clock), .reset(reset),.flush(flush), .freez(freez), .input_value(dest), .output_value(dest_out));
    register_freezflush #(1) two_regs_reg (.clock(clock), .reset(reset), .flush(flush), .freez(freez), .input_value(two_regs), .output_value(two_regs_out));


endmodule