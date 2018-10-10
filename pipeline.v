module pipeline(input clock, input reset, output [LEN-1:0] ifid_pc_output, output [LEN-1:0] idexe_pc_output, output [LEN-1:0] exemem_pc_output, output [LEN-1:0] memwb_pc_output);

    parameter LEN = 32; 

    wire [LEN-1:0] instruction, pc;
    wire [LEN-1:0] ifid_instruction_out, ifid_pc_out;
    wire [LEN-1:0] idexe_pc_out, idexe_instruction_out;
    wire [LEN-1:0] exemem_pc_out, exemem_instruction_out;
    wire [LEN-1:0] memwb_pc_out, memwb_instruction_out;

    wire [6:0] ss_ifid_pc;
    wire [6:0] ss_idexe_pc;
    wire [6:0] ss_exemem_pc;
    wire [6:0] ss_memwb_pc;


    IF instFetch(clock, reset, instruction, pc); 
    
    IFID ifidreg #(LEN) (clock, reset, pc, instruction, ifid_pc_out, ifid_instruction_out);
    IDEXE idexereg #(LEN) (clock, reset, ifid_pc_out, ifid_instruction_out, idexe_pc_out, idexe_instruction_out);
    EXEMEM exememreg #(LEN) (clock, reset, idexe_pc_out, idexe_instruction_out, exemem_pc_out, exemem_instruction_out);
    MEMWB memwbreg #(LEN) (clock, reset, exemem_pc_out, exemem_instruction_out, memwb_pc_out, memwb_instruction_out);

    assign ifid_pc_output = ifid_pc_out;
    assign idexe_pc_output = idexe_pc_out;
    assign exemem_pc_output = exemem_pc_out;
    assign memwb_pc_output = memwb_pc_out;

    SevenSegmentConverter sscIFID(ifid_pc_out[5:2], ss_ifid_pc);
    SevenSegmentConverter sscIDEXE(idexe_pc_out[5:2], ss_idexe_pc);
    SevenSegmentConverter sscEXEMEM(exemem_pc_out[5:2], ss_exemem_pc);
    SevenSegmentConverter sscMEMWB(memwb_pc_out[5:2], ss_memwb_pc);

endmodule