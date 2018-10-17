module ID (
	input clock, 
	input reset, 
	input [31:0] instruction, 
	input [31:0] PC, 
	output exe_cmd, 
	ouput mem_write, 
	ouput mem_read, 
	output br_type, 
	output writeback_EN,
);
	
	Controller cUnit (instruction[31:26], );

	Register_file reg_file(clock, reset, instruction[25:21], instruction[20:16], instruction[15:11]);

	SignExtend se ();

	MUX  ();
	MUX dest_mux ();

endmodule