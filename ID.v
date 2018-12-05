module ID (
	input clock, 
	input reset, 
	input [31:0] instruction, 
	input [31:0] PC, 
	input write_enable,
	input [4:0] dest_wb,
	input [31:0] result_wb,
	input freez, 
	output [3:0] exe_cmd, 
	output mem_write, 
	output mem_read, 
	output [1:0] br_type, 
	output writeback_en,
	output [31:0] alu_inp1,
	output [31:0] alu_inp2,
	output [4:0] idexe_dest,
	output [31:0] reg2,
	output two_regs,
	output is_immediate
);

  	wire [31:0] reg_out1, reg_out2;
  	wire [31:0] se_out;
  	wire mem_write_muxed,mem_read_muxed, writeback_en_muxed;
  	wire [3:0] exe_cmd_muxed; 
  	wire [1:0] br_type_muxed;
  
	
	Controller cUnit (.opcode(instruction[31:26]), .branch_type(br_type_muxed),.exe_cmd(exe_cmd_muxed),
	                 .mem_write(mem_write_muxed),.mem_read(mem_read_muxed),.writeback_en(writeback_en_muxed),
	                 .is_immediate(is_immediate));

	MUX #(1) hazard_read_mux (.value1(mem_read_muxed),.value2(1'b0), .selector(freez), .out_val(mem_read));
	MUX #(1) hazard_write_mux (.value1(mem_write_muxed),.value2(1'b0), .selector(freez), .out_val(mem_write));
	MUX #(1) hazard_wben_mux (.value1(writeback_en_muxed),.value2(1'b0), .selector(freez), .out_val(writeback_en));
	MUX #(2) hazard_brType_mux (.value1(br_type_muxed),.value2(2'b0), .selector(freez), .out_val(br_type));
	MUX #(4) hazard_exeCmd_mux (.value1(exe_cmd_muxed),.value2(4'b0), .selector(freez), .out_val(exe_cmd));

	Register_file reg_file(.clk(clock), .rst(reset), .src1(instruction[25:21]), .src2(instruction[20:16]), .dest(dest_wb), .Write_val(result_wb), .Write_EN(write_enable), .reg1(reg_out1), .reg2(reg_out2));
	
	SignExtend se(.input_value(instruction[15:0]),.extended(se_out));

	MUX #(32) mux1 (.value1(reg_out2),.value2(se_out), .selector(is_immediate), .out_val(alu_inp2));
	MUX #(5) dest_mux (.value1(instruction[15:11]),.value2(instruction[20:16]), .selector(is_immediate),.out_val(idexe_dest));
	
	assign alu_inp1 = reg_out1;
	assign reg2 = reg_out2;
	assign two_regs = (is_immediate &&  (instruction[31:26] != 6'b101001 && instruction[31:26] != 6'b100101)) ? 1'b0 : 1'b1;

endmodule