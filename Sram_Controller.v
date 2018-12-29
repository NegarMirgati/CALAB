module Sram_Controller(
	input clk, 
	input rst, 
	input wr_en, 
	input rd_en,
	input [31:0] address, 
	input [31:0] write_data,
	output [63:0] read_data,
	output reg ready, 
	inout [15:0] SRAM_DQ, 
	output [17:0] SRAM_ADDR, 
	output SRAM_UB_N, 
	output SRAM_LB_N, 
	output SRAM_WE_N, 
	output SRAM_CE_N, 
	output SRAM_OE_N 
	);

	reg [2:0] cycle = 3'b0; 
	wire [15:0] val_out_0;
	wire [15:0] val_out_1;
	wire [15:0] val_out_2;
	wire [15:0] val_out_3;
	
	always @(posedge clk) begin
		if((cycle==3'd5) && (wr_en == 1'b1 || rd_en == 1'b1 )) cycle = 3'd0;
	   else if(wr_en == 1'b1 || rd_en == 1'b1) cycle = cycle + 1'b1; 
		else if(wr_en == 1'b0 && rd_en == 1'b0) cycle = 1'b0;
	
	end 

  always @(*) begin
		
		if(rd_en == 1'b0 && wr_en == 1'b0) ready = 1'b1;
		else if ((wr_en == 1'b1 || rd_en == 1'b1) && cycle==3'd5) ready = 1'b1;
		else if ((wr_en == 1'b1 || rd_en == 1'b1) && cycle!=3'd5) ready = 1'b0;
		else ready = 1'b1;
		
	end 

	// for write
	assign SRAM_DQ = (wr_en)? (cycle==3'd1)? write_data[15:0] :(cycle==3'd2) ? write_data[31:16] : 16'bzzzzzzzzzzzzzzzz :  16'bzzzzzzzzzzzzzzzz;

	// for read 
	assign SRAM_WE_N = (rd_en==1'b1)? 1'b1 : (wr_en==1'b1 && (cycle == 3'd1 || cycle == 3'd2))? 1'b0: 1'b1;
	
	
	assign SRAM_ADDR = (rd_en) ? 
	 (cycle==3'd1) ? {address[18:3] , 2'b00} 
	:(cycle==3'd2) ? {address[18:3] , 2'b01} 
	:(cycle==3'd3) ? {address[18:3] , 2'b10} 
	:(cycle==3'd4) ? {address[18:3] , 2'b11} 
	: 18'd0 :
	(wr_en)? (cycle==3'd1)? {address[18:2] , 1'b0} :(cycle==3'd2) ? {address[18:2] , 1'b1} : 18'd0
	: 18'd0;
	
	register_with_enable #(16) half0(.clock(clk), .reset(rst), .enable(cycle==3'd1 && rd_en), .input_value(SRAM_DQ), .output_value(val_out_0));
	register_with_enable #(16) half1(.clock(clk), .reset(rst), .enable(cycle==3'd2 && rd_en), .input_value(SRAM_DQ), .output_value(val_out_1));
	register_with_enable #(16) half2(.clock(clk), .reset(rst), .enable(cycle==3'd3 && rd_en), .input_value(SRAM_DQ), .output_value(val_out_2));
	register_with_enable #(16) half3(.clock(clk), .reset(rst), .enable(cycle==3'd4 && rd_en), .input_value(SRAM_DQ), .output_value(val_out_3));
			
	assign read_data = {val_out_3 , val_out_2, val_out_1, val_out_0};
	
	assign SRAM_UB_N = 1'b0;
	assign SRAM_LB_N = 1'b0; 
	assign SRAM_CE_N = 1'b0; 
	assign SRAM_OE_N = 1'b0; 


endmodule