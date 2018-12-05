module Sram_Controller(
	input clk, 
	input rst, 
	input wr_en, 
	input rd_en,
	input [31:0] address, 
	input [31:0] write_data,
	output [31:0] read_data,
	output ready, 
	inout [15:0] SRAM_DQ, 
	output [17:0] SRAM_ADDR, 
	output SRAM_UB_N, 
	output SRAM_LB_N, 
	output SRAM_WE_N, 
	output SRAM_CE_N, 
	output SRAM_OE_N 
	);

	wire cycle = 1'b0; 
	always @(clk) begin 
		cycle = cycle + 1'b1; 
	end 

	// for write
	assign SRAM_WE_N = 1'b0;
	// cycle 1
	assign SRAM_ADDR = {address[18:2] , 1'b0};
	assign SRAM_DQ = write_data[15:0];
	// cycle 2
	assign SRAM_ADDR = {address[18:2] , 1'b1};
	assign SRAM_DQ = write_data[31:15];

	// for read 
	
	assign SRAM_UB_N = 1'b0;
	assign SRAM_LB_N = 1'b0; 
	assign SRAM_CE_N = 1'b0; 
	assign SRAM_OE_N = 1'b0; 


endmodule