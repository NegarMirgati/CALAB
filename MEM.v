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
	wire ready, cache_ready, cache_write;
	wire [31:0] sram_address, sram_wdata;
	wire [63:0] sram_rdata;
	

	AddressMapping am (.input_val(alu_result), .address(address)); 

	//DataMemory dm (.clock(clock), .reset(reset), .address(address), .write_data(ST_value), .mem_r_en(mem_r_en), .mem_w_en(mem_w_en), .data(memory_result));

   	MUX #(1) wb_en_mux ( .value1(wb_en), .value2(1'b0), .selector(sram_freeze), .out_val(mux_wb_en_out));

   	cache_controller cacheController( .clk(clock), .rst(reset), .address(address), 
   							.wdata(ST_value), .MEM_R_EN(mem_r_en), .MEM_W_EN(mem_w_en), .rdata(memory_result), 
   							.ready(cache_ready), .sram_address(sram_address), .sram_wdata(sram_wdata), .write(cache_write), 
   							.sram_rdata(sram_rdata), .ram_ready(ready), .sram_mem_r_en(sram_mem_r_en)
	);

	Sram_Controller sram(.clk(clock), .rst(reset), .wr_en(cache_write), .rd_en(sram_mem_r_en), 
					.address(sram_address), .write_data(sram_wdata) , .read_data(sram_rdata), 
					.ready(ready) , .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR), .SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N), 
					.SRAM_WE_N(SRAM_WE_N), .SRAM_CE_N(SRAM_CE_N), .SRAM_OE_N(SRAM_OE_N) );
	
	assign sram_freeze = cache_ready ? 1'b0 : 1'b1;
	assign mem_wb_en_out = mux_wb_en_out;

endmodule