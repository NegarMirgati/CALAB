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
	output reg write, 
	output reg sram_mem_r_en,
	input [63:0] sram_rdata, 
	input sram_ready
	);
   integer i;
	reg LRU;
   wire	hit, hit_0, hit_1; 
	wire [5:0] index; 
	wire [8:0] tag_addr; 
	reg [64:0] way_0 [63:0];
   reg [64:0] way_1 [63:0];
	reg [8:0] tag_cache_way_0 [63:0];
	reg [8:0] tag_cache_way_1 [63:0];
	
	wire [63:0] rdata_64_bit; 


	assign ready = hit || sram_ready;

	assign tag_addr = address[18:9]; 
	assign index = address[9:3];
	
	assign hit_0 = (tag_addr==tag_cache_way_0[index]) && way_0[index][64];
	assign hit_1 = (tag_addr==tag_cache_way_1[index]) && way_1[index][64];
	assign hit = (hit_1 || hit_0) && (!MEM_W_EN);

	assign rdata_64_bit = (hit_0)? way_0[index][63:0]: (hit_1)? way_1[index][63:0]: sram_rdata;
	assign rdata = (address[2])? rdata_64_bit[63:32] : rdata_64_bit[31:0];

	assign sram_wdata = wdata;
	assign sram_address = address;

	always @(posedge clk) begin // writing data in cache
		if(sram_ready && !hit) begin 
			if(LRU) begin  way_1[index][63:0] = sram_rdata; tag_cache_way_1[index] = tag_addr;  end 
			else  begin way_0[index][63:0] = sram_rdata;    tag_cache_way_0[index] = tag_addr; end
		end 
	end 

	always@(posedge clk) begin 
		sram_mem_r_en = 1'b0;
		write = 1'b0;
		if(!hit && MEM_R_EN) begin 
			sram_mem_r_en = 1'b1;
		end 

		if(MEM_W_EN) begin 
			write = 1'b1; 
		end
	end 
	
	always @(posedge clk ) begin // Valid bit
	   if(rst) begin
			for(i = 0; i < 64; i = i + 1) begin
				way_0[i][64] = 1'd0;
				way_1[i][64] = 1'd0;
			end
		end
		else if(MEM_W_EN) begin	
			if(hit) begin 
				if(hit_1) way_1[index][64] = 0; 
				else way_0[index][64] = 0; 
			end 
		end
		else if(sram_ready && !hit) begin 
			if(LRU)  way_1[index][64] = 1; 
			else way_0[index][64] = 1; 
		end 
	end

	always @ (posedge clk) begin 
		if(hit_0) LRU = 1; 
		else if(hit_1) LRU = 0; 
		else if(sram_ready && !hit) LRU = ~LRU; 
	end 
	


endmodule 