module pipeline #(parameter LEN = 32)(input clock, input reset);

    // instruction fetch wires
    wire [LEN-1:0] instruction, pc;

    // IFID register wires
    wire [LEN-1:0] ifid_instruction_out, ifid_pc_out;

    // instruction decode wires
    wire [31:0] alu_inp1, alu_inp2, reg_out2;
    wire [4:0] dest_wb;
    wire[31:0] result_wb;
    wire wb_writeback_en;
    wire[3:0] exe_cmd;
    wire [1:0] branch_type;
    wire mem_write, mem_read, wb_en;
    wire[4:0] idexe_dest;

    // IDEXE register wires
    wire [LEN-1:0] idexe_pc_out, idexe_instruction_out;
    wire flush;

    
    wire [LEN-1:0] exemem_pc_out, exemem_instruction_out;
    wire [LEN-1:0] memwb_pc_out, memwb_instruction_out;



    IF instFetch(.clock(clock), .reset(reset), .instruction(instruction), .pc_value(pc)); 
    
    IFID #(LEN) ifidreg(.clock(clock), .reset(reset), .pc(pc), .instruction(instruction), .pc_out(ifid_pc_out), .instruction_out(ifid_instruction_out));

    ID instDecode(.clock(clock), .reset(reset), .instruction(ifid_instruction_out), .PC(ifid_pc_out), .write_enable(wb_writeback_en), .dest_wb(dest_wb), .result_wb(result_wb), .exe_cmd(exe_cmd), .mem_write(mem_write), .mem_read(mem_read), .br_type(branch_type), .writeback_en(wb_en), .alu_inp1(alu_inp1), .alu_inp2(alu_inp2), .idexe_dest(idexe_dest), .reg2(reg_out2));

    IDEXE #(LEN) idexereg(clock, reset, ifid_pc_out, ifid_instruction_out, 
                          wb_en, mem_read, mem_write, flush, branch_type, exe_cmd, reg_out2, alu_inp1, alu_inp2, idexe_dest, idexe_pc_out, idexe_instruction_out);
                            
    EXEMEM #(LEN) exememreg(clock, reset, idexe_pc_out, idexe_instruction_out, exemem_pc_out, exemem_instruction_out);
    MEMWB #(LEN) memwbreg(clock, reset, exemem_pc_out, exemem_instruction_out, memwb_pc_out, memwb_instruction_out);


endmodule