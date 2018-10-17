module pipeline #(parameter LEN = 32)(input clock, input reset, output test_mem_read, output test_mem_write, output[3:0] test_exe_cmd, output [1:0] test_branch_type, output[4:0] test_src1, test_src2);

    wire [LEN-1:0] instruction, pc;
    wire [LEN-1:0] ifid_instruction_out, ifid_pc_out;
    wire [LEN-1:0] idexe_pc_out, idexe_instruction_out;
    wire [LEN-1:0] exemem_pc_out, exemem_instruction_out;
    wire [LEN-1:0] memwb_pc_out, memwb_instruction_out;

    wire [6:0] ss_ifid_pc;
    wire [6:0] ss_idexe_pc;
    wire [6:0] ss_exemem_pc;
    wire [6:0] ss_memwb_pc;
    wire [4:0] dest_wb;
    wire[31:0] result_wb;
    wire wb_writeback_en;
    wire[3:0] exe_cmd;
    wire [1:0] branch_type;
    wire mem_write, mem_read, wb_en;
    wire [31:0] alu_inp1, alu_inp2, reg_out2;
    wire[4:0] idexe_dest;
    wire flush;
  
    
    


    IF instFetch(clock, reset, instruction, pc); 
    
    IFID #(LEN) ifidreg(clock, reset, pc, instruction, ifid_pc_out, ifid_instruction_out);

    ID instDecode(clock, reset, ifid_instruction_out, ifid_pc_out,
                 wb_writeback_en, dest_wb, result_wb, exe_cmd, mem_write, mem_read, 
                 branch_type, wb_en, alu_inp1, alu_inp2, idexe_dest, reg_out2);

    IDEXE #(LEN) idexereg(clock, reset, ifid_pc_out, ifid_instruction_out, 
                          wb_en, mem_read, mem_write, flush, branch_type, exe_cmd, reg_out2, alu_inp1, alu_inp2, idexe_dest, idexe_pc_out, idexe_instruction_out);
                            
    EXEMEM #(LEN) exememreg(clock, reset, idexe_pc_out, idexe_instruction_out, exemem_pc_out, exemem_instruction_out);
    MEMWB #(LEN) memwbreg(clock, reset, exemem_pc_out, exemem_instruction_out, memwb_pc_out, memwb_instruction_out);

	 assign  test_mem_read = mem_read;
	 assign  test_mem_write = mem_write;
	 assign  test_exe_cmd =exe_cmd;
	 assign  test_branch_type = branch_type;
	 assign test_src1 = ifid_instruction_out[25:21];
	 assign test_src2 =  ifid_instruction_out[20:16];


    SevenSegmentConverter sscIFID(ifid_pc_out[5:2], ss_ifid_pc);
    SevenSegmentConverter sscIDEXE(idexe_pc_out[5:2], ss_idexe_pc);
    SevenSegmentConverter sscEXEMEM(exemem_pc_out[5:2], ss_exemem_pc);
    SevenSegmentConverter sscMEMWB(memwb_pc_out[5:2], ss_memwb_pc);
	 SevenSegmentConverter sscEXECMD(exe_cmd, ss_exe_cmd);

endmodule