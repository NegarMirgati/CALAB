module ID (
	input clock, 
	input reset, 
	input [31:0] instruction, 
	input [31:0] PC, 
	input write_enable,
	input [4:0] dest_wb,
	input [31:0] result_wb,
	input freez, 
	output [3:0] exe_cmd_muxed, 
	output mem_write_muxed, 
	output mem_read_muxed, 
	output [1:0] br_type_muxed, 
	output writeback_en_muxed,
	output [31:0] alu_inp1,
	output [31:0] alu_inp2,
	output [4:0] idexe_dest,
	output [31:0] reg2
);

  	wire is_immediate;
  	wire [31:0] reg_out1, reg_out2;
  	wire [31:0] se_out;
  	wire mem_write,mem_read, writeback_en;
  	wire [3:0] exe_cmd; 
  	wire [1:0] br_type;
  
	
	Controller cUnit (.opcode(instruction[31:26]), .branch_type(br_type),.exe_cmd(exe_cmd),
	                 .mem_write(mem_write),.mem_read(mem_read),.writeback_en(writeback_en),
	                 .is_immediate(is_immediate));

	MUX #(1) hazard_read_mux (.value1(mem_read),.value2(1'b0), .selector(freez), .out_val(mem_read_muxed));
	MUX #(1) hazard_write_mux (.value1(mem_write),.value2(1'b0), .selector(freez), .out_val(mem_write_muxed));
	MUX #(1) hazard_wben_mux (.value1(writeback_en),.value2(1'b0), .selector(freez), .out_val(writeback_en_muxed));
	MUX #(2) hazard_brType_mux (.value1(br_type),.value2(2'b0), .selector(freez), .out_val(br_type_muxed));
	MUX #(4) hazard_exeCmd_mux (.value1(exe_cmd),.value2(4'b0), .selector(freez), .out_val(exe_cmd_muxed));

	Register_file reg_file(.clk(clock), .rst(reset), .src1(instruction[25:21]), .src2(instruction[20:16]), .dest(dest_wb), .Write_val(result_wb), .Write_EN(write_enable), .reg1(reg_out1), .reg2(reg_out2));
	
	SignExtend se(.input_value(instruction[15:0]),.extended(se_out));

	MUX #(32) mux1 (.value1(reg_out2),.value2(se_out), .selector(is_immediate), .out_val(alu_inp2));
	MUX #(5) dest_mux (.value1(instruction[15:11]),.value2(instruction[20:16]), .selector(is_immediate),.out_val(idexe_dest));
	
	assign alu_inp1 = reg_out1;
	assign reg2 = reg_out2;

endmodule