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
    wire idexe_wb_en_out, idexe_mem_read_out,idexe_mem_write_out, idexe_flush_out;
    wire [LEN-1:0] idexe_pc_out, idexe_instruction_out;
    wire flush; 
    wire [1:0] idexe_branch_type_out;
    wire [3:0] idexe_exe_cmd_out;
    wire [31:0] idexe_reg2_out, idexe_alu_inp1_out, idexe_alu_inp2_out;
    wire [4:0] idexe_dest_out;

    // EXE wires
    reg [31:0] alu_result;
    wire [31:0] branch_address;
    wire branch_tacken;

    // EXEMEM register wires
    wire [31:0] exemem_pc_out, exemem_instruction_out;
    wire exemem_wb_en_out, exemem_mem_write_out, exemem_mem_read_out; 
    wire [31:0] exemem_src2_val_out; 
    wire [4:0] exemem_dest_out;
    wire [31:0] exemem_alu_result_out;

    wire [LEN-1:0] memwb_pc_out, memwb_instruction_out;

    IF instFetch(.clock(clock), .reset(reset), .instruction(instruction), .pc_value(pc)); 
    
    IFID #(LEN) ifidreg(.clock(clock), .reset(reset), .pc(pc), .instruction(instruction), .pc_out(ifid_pc_out), .instruction_out(ifid_instruction_out));

    ID instDecode(.clock(clock), .reset(reset), .instruction(ifid_instruction_out), .PC(ifid_pc_out), .write_enable(wb_writeback_en), .dest_wb(dest_wb), .result_wb(result_wb), .exe_cmd(exe_cmd), .mem_write(mem_write), .mem_read(mem_read), .br_type(branch_type), .writeback_en(wb_en), .alu_inp1(alu_inp1), .alu_inp2(alu_inp2), .idexe_dest(idexe_dest), .reg2(reg_out2));

    IDEXE #(LEN) idexereg(.clock(clock), .reset(reset), .pc(ifid_pc_out), 
                .instruction(ifid_instruction_out), 
                .wb_en(wb_en), .mem_read(mem_read),.mem_write(mem_write), .flush(flush), .branch_type(branch_type),
                .exe_cmd(exe_cmd), .reg2(reg_out2), .alu_inp1(alu_inp1), .alu_inp2(alu_inp2), 
                .dest(idexe_dest), .pc_out(idexe_pc_out), .instruction_out(idexe_instruction_out),
                .wb_en_out(idexe_wb_en_out), .mem_read_out(idexe_mem_read_out), 
                .mem_write_out(idexe_mem_write_out), .flush_out(idexe_flush_out),
                .branch_type_out(idexe_branch_type_out),.exe_cmd_out(idexe_exe_cmd_out),
                .reg2_out(idexe_reg2_out), .alu_inp1_out(idexe_alu_inp1_out), .alu_inp2_out(idexe_alu_inp2_out),.dest_out(idexe_dest_out));
                          

    EXE execution_stage (.branch_type(idexe_branch_type_out), .src2_val(idexe_reg2_out),
                .val2(idexe_alu_inp2_out), val1(idexe_alu_inp1_out), 
                .pc(idexe_pc_out), .exe_cmd(idexe_exe_cmd_out), .alu_result(alu_result), .branch_address(branch_address),
                .branch_tacken(branch_tacken)); 

                            
    EXEMEM #(LEN) exememreg( .clock(clock), .reset(reset), .wb_en(idexe_wb_en_out), 
            .mem_write(idexe_mem_write_out), .mem_read(idexe_mem_read_out), 
            .pc(idexe_pc_out), .instruction(idexe_instruction_out),
            .src2_val(idexe_reg2_out), .dest(idexe_dest), .alu_result(alu_result),
            .pc_out(exemem_pc_out), .instruction_out(exemem_instruction_out),
            .wb_en_out(exemem_wb_en_out), .mem_write_out(exemem_mem_write_out),
            .mem_read_out(exemem_mem_read_out), .src2_val_out(exemem_src2_val_out), 
            .dest_out(exemem_dest_out),
            .alu_result_out(exemem_alu_result_out));


    MEMWB #(LEN) memwbreg(clock, reset, exemem_pc_out, exemem_instruction_out, memwb_pc_out, memwb_instruction_out);


endmodule