module pipeline #(parameter LEN = 32)(input clock, input reset, input en_fwd);

    // instruction fetch wires
    wire [LEN-1:0] instruction, pc;

    // IFID register wires
    wire [LEN-1:0] ifid_instruction_out, ifid_pc_out;

    // instruction decode wires
    wire [31:0] alu_inp1, alu_inp2, reg_out2;
    wire [4:0] dest_wb;
    wire wb_writeback_en;
    wire[3:0] exe_cmd;
    wire [1:0] branch_type;
    wire mem_write, mem_read, wb_en;
    wire[4:0] idexe_dest;

    // IDEXE register wires
    wire idexe_wb_en_out, idexe_mem_read_out,idexe_mem_write_out;
    wire [LEN-1:0] idexe_pc_out, idexe_instruction_out;
    wire flush; 
    wire [1:0] idexe_branch_type_out;
    wire [3:0] idexe_exe_cmd_out;
    wire [31:0] idexe_reg2_out, idexe_alu_inp1_out, idexe_alu_inp2_out;
    wire [4:0] idexe_dest_out;

    // EXE wires
    wire [31:0] alu_result, exe_src2_val_out;
    wire [31:0] branch_address;
    wire branch_taken;

    // EXEMEM register wires
    wire [31:0] exemem_pc_out, exemem_instruction_out;
    wire exemem_wb_en_out, exemem_mem_write_out, exemem_mem_read_out; 
    wire [31:0] exemem_src2_val_out; 
    wire [4:0] exemem_dest_out;
    wire [31:0] exemem_alu_result_out;

    wire [LEN-1:0] memwb_pc_out, memwb_instruction_out;

    // MEM wires 
    wire [31:0] memory_result;
    wire [31:0] memwb_alu_result, memwb_memory_result;
    wire memwb_mem_r_en;
    wire [4:0] memwb_dest;
    wire memwb_wb_en_out;

    // WB wires 
    wire [31:0] result_wb;


    wire hazard_detected;
    wire [1:0] src2_val_selector, val1_selector, val2_selector;
    wire is_immidiate;

    assign flush = branch_taken;


    HazardDU hdu (.src1(ifid_instruction_out[25:21]), .src2(ifid_instruction_out[20:16]), .exe_dest(idexe_dest_out), .exe_wb_en(idexe_wb_en_out), .mem_dest(exemem_dest_out), .mem_wb_en(exemem_wb_en_out),.exe_is_immidiate(), .mem_mem_r_en(memwb_mem_r_en), .en_fwd(en_fwd), .hazard_detected(hazard_detected));


    ForwardingUnit(.src1(ifid_instruction_out[25:21]), .src2(ifid_instruction_out[20:16]), .idexe_dest(idexe_dest_out), .exemem_dest(exemem_dest_out), .wb_dest(memwb_dest), .mem_wb_en(exemem_wb_en_out), .wb_wb_en(memwb_wb_en_out), .src2_val_selector(src2_val_selector), .val1_selector(val1_selector), .val2_selector(val2_selector), .enable_forward(enable_forward));


    IF instFetch(.clock(clock), .reset(reset), .instruction(instruction), .branch_address(branch_address), .branch_taken(branch_taken), .pc_value(pc), .hazard_detected(hazard_detected)); 
    
    IFID #(LEN) ifidreg(.clock(clock), .reset(reset), .pc(pc), .instruction(instruction), .pc_out(ifid_pc_out), .instruction_out(ifid_instruction_out), .flush(flush), .freez(hazard_detected));

    ID instDecode(.clock(clock), .reset(reset), .instruction(ifid_instruction_out), .PC(ifid_pc_out), .write_enable(wb_writeback_en), .dest_wb(dest_wb), .result_wb(result_wb), .exe_cmd(exe_cmd), .mem_write(mem_write), .mem_read(mem_read), .br_type(branch_type), .writeback_en(wb_en), .alu_inp1(alu_inp1), .alu_inp2(alu_inp2), .idexe_dest(idexe_dest), .reg2(reg_out2), .freez(hazard_detected), .is_immediate_out(exe_is_immediate));

    IDEXE #(LEN) idexereg(.clock(clock), .reset(reset), .pc(ifid_pc_out), 
                .instruction(ifid_instruction_out), 
                .wb_en(wb_en), .mem_read(mem_read),.mem_write(mem_write), .flush(flush), .branch_type(branch_type),
                .exe_cmd(exe_cmd), .reg2(reg_out2), .alu_inp1(alu_inp1), .alu_inp2(alu_inp2), 
                .dest(idexe_dest), .pc_out(idexe_pc_out), .instruction_out(idexe_instruction_out),
                .wb_en_out(idexe_wb_en_out), .mem_read_out(idexe_mem_read_out), 
                .mem_write_out(idexe_mem_write_out),
                .branch_type_out(idexe_branch_type_out),.exe_cmd_out(idexe_exe_cmd_out),
                .reg2_out(idexe_reg2_out), .alu_inp1_out(idexe_alu_inp1_out), .alu_inp2_out(idexe_alu_inp2_out),.dest_out(idexe_dest_out));
                          

    EXE execution_stage (.branch_type(idexe_branch_type_out), .src2_val(idexe_reg2_out),
                .val2(idexe_alu_inp2_out), .val1(idexe_alu_inp1_out), 
                .pc(idexe_pc_out), .exe_cmd(idexe_exe_cmd_out), .alu_result(alu_result), .branch_address(branch_address),
                .branch_taken(branch_taken).mem_alu_result(exemem_alu_result_out), .wb_data(result_wb), .src2_val_out(exe_src2_val_out));

                            
    EXEMEM #(LEN) exememreg( .clock(clock), .reset(reset), .wb_en(idexe_wb_en_out), 
            .mem_write(idexe_mem_write_out), .mem_read(idexe_mem_read_out), 
            .pc(idexe_pc_out), .instruction(idexe_instruction_out),
            .src2_val(exe_src2_val_out), .dest(idexe_dest_out), .alu_result(alu_result),
            .pc_out(exemem_pc_out), .instruction_out(exemem_instruction_out),
            .wb_en_out(exemem_wb_en_out), .mem_write_out(exemem_mem_write_out),
            .mem_read_out(exemem_mem_read_out), .src2_val_out(exemem_src2_val_out), 
            .dest_out(exemem_dest_out),
            .alu_result_out(exemem_alu_result_out));

    MEM mem_state(.clock(clock), 
        .reset(reset),
        .mem_w_en(exemem_mem_write_out), 
        .mem_r_en(exemem_mem_read_out), 
        .alu_result(exemem_alu_result_out), 
        .ST_value(exemem_src2_val_out), 
        .memory_result(memory_result), 
        .src2_val_selector(src2_val_selector), .val1_selector(val1_selector), .val2_selector(val2_selector));

    MEMWB #(LEN) memwbreg(.clock(clock), .reset(reset), .wb_en(exemem_wb_en_out), .mem_r_en(exemem_mem_read_out), .memory_data(memory_result), .dest(exemem_dest_out), 
    .alu_result_out(memwb_alu_result), 
    .alu_result(exemem_alu_result_out), 
    .memory_result_out(memwb_memory_result),
    .mem_r_en_out(memwb_mem_r_en), 
    .wb_en_out(memwb_wb_en_out),
    .dest_out(memwb_dest));
    

    WB write_back_stage(.mem_r_en(memwb_mem_r_en), 
        .alu_result(memwb_alu_result), 
        .memory_result(memwb_memory_result), 
        .result_wb(result_wb));

    assign dest_wb = memwb_dest;
    assign wb_writeback_en = memwb_wb_en_out;

endmodule