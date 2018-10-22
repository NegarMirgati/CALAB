module ID (
	input clock, 
	input reset, 
	input [31:0] instruction, 
	input [31:0] PC, 
	input write_enable,
	input [4:0] dest_wb,
	input [31:0] result_wb,
	output [3:0] exe_cmd, 
	output mem_write, 
	output mem_read, 
	output [1:0] br_type, 
	output writeback_en,
	output [31:0] alu_inp1,
	output [31:0] alu_inp2,
	output [4:0] idexe_dest,
	output [31:0] reg2
);

  wire is_immediate;
  wire [31:0] reg_out1, reg_out2;
  wire [31:0] se_out;
  
	
	Controller cUnit (.opcode(instruction[31:25]), .branch_type(br_type),.exe_cmd(exe_cmd),
	                 .mem_write(mem_write),.mem_read(mem_read),.writeback_en(writeback_en),
	                 .is_immediate(is_immediate));

	Register_file reg_file(clock, reset, instruction[25:21], instruction[20:16], dest_wb, result_wb, write_enable, reg_out1, reg_out2);
	SignExtend se(instruction[15:0], se_out);
	MUX mux1 (reg_out2, se_out, is_immediate, alu_inp2);
	MUX dest_mux (instruction[15:11], instruction[20:16], is_immediate,idexe_dest);
	
	assign alu_inp1 = reg_out1;
	assign reg2 = reg_out2;

endmodule