module MEM(
	input clock, 
	input reset,
	input mem_w_en, 
	input mem_r_en, 
	input [31:0] alu_result, 
	input [31:0] ST_value, 
	input wb_en,
	output [31:0] memory_result,
	inout[15:0] SRAM_DQ, output [17:0] SRAM_ADDR,
	output SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N,
	output sram_freeze,
	output mem_wb_en_out
);
	
	wire [31:0] address;
	wire ready;
	

	AddressMapping am (.input_val(alu_result), .address(address)); 

	//DataMemory dm (.clock(clock), .reset(reset), .address(address), .write_data(ST_value), .mem_r_en(mem_r_en), .mem_w_en(mem_w_en), .data(memory_result));

   MUX #(1) wb_en_mux ( .value1(wb_en), .value2(1'b0), .selector(sram_freeze), .out_val(mux_wb_en_out));
	Sram_Controller sram(.clk(clock), .rst(reset), .wr_en(mem_w_en), .rd_en(mem_r_en), .address(address), .write_data(ST_value) , .read_data(memory_result), 
	.ready(ready) , .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR), .SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N), .SRAM_WE_N(SRAM_WE_N), .SRAM_CE_N(SRAM_CE_N), .SRAM_OE_N(SRAM_OE_N) );
	
	assign sram_freeze = ready ? 1'b0 : 1'b1;
	assign mem_wb_en_out = mux_wb_en_out;

endmodule