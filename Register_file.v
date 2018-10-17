module Register_file (
	input clk, 
	input rst, 
	input [4:0] src1; 
	input [4:0] src2; 
	input [4:0] dest;
	input [31:0] Write_val, 
	input Write_EN, 
	output [31:0] reg1, 
	output [31:0] reg2
);
	reg [31:0] regFile [31:0];
	integer i;

	always @ (negedge clk, rst)
	begin
		if (rst) begin 
			for(i=0; i<32; i = i+1) 
            	regFile[i] = i;
		end
		else begin 
			if (Write_EN) regFile[dest] = Write_val;
		end
	end
		
	assign reg1 = regFile[src1];
	assign reg2 = regFile[src2];

endmodule