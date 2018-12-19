module cache_controller (
	input clk, 
	input rst, 
	input [31:0] address, 
	input [31:0] wdata, 
	input MEM_R_EN, 
	input MEM_W_EN, 
	output [31:0] rdata, 
	output ready, 
	output [31:0] sram_address, 
	output [31:0] sram_wdata, 
	output write, 
	output reg sram_mem_r_en,
	input [63:0] sram_rdata, 
	input sram_ready
	);

	wire LRU, hit, hit_0, hit_1; 
	wire [5:0] index; 
	wire [8:0] tag_addr, tag_cache_way_0, tag_cache_way_1; 
	wire [63:0][64:0] way_0, way_1;
	wire [63:0][8:0] tag_cache_way_0, tag_cache_way_1;
	wire [63:0] rdata_64_bit; 


	assign ready = hit || sram_ready;

	assign tag_addr = address[18:9]; 

	assign index = address[9:3];
	assign hit_0 = (tag_addr==tag_cache_way_0[index]) && way_0[index][64];
	assign hit_1 = (tag_addr==tag_cache_way_1[index]) && way_1[index][64];
	hit = (hit_1 || hit_0) && (!MEM_W_EN);

	assign rdata_64_bit = (hit_0)? way_0[index][0:63]: (hit_1)? way_1[index][0:63]: sram_rdata;
	assign rdata = (address[2])? rdata_64_bit[63:32] : rdata_64_bit[31:0];

	assign sram_wdata = (MEM_W_EN)? wdata: 32'bz;
	assign sram_address = (MEM_W_EN)? address: 32'bz;

	always(posedge clk) begin 
		if(sram_ready && !hit) begin 
			if(LRU)  way_1[index] = sram_rdata; 
			else way_0[index] = sram_rdata; 
		end 
	end 

	always@(posedge clk) begin 
		sram_mem_r_en = 1'b0;
		write = 1'b0;
		if(!hit && MEM_R_EN) begin 
			sram_mem_r_en = 1'b1;
		end 

		if(MEM_W_EN) beign 
			write = 1'b1; 
			if(hit) begin 
				if(hit_1) way_1[index][64] = 0; 
				else way_0[index][64] = 0; 
			end 
		end
	end 

	always @ (posedge clk) begin 
		if(hit_0) LRU = 1; 
		else if(hit_1) LRU = 0; 
		else if(sram_ready && !hit) LRU = ~LRU; 
	end 

endmodule 