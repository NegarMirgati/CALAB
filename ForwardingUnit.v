module ForwardingUnit(
	input enable_forward,
	input [4:0] src1, 
	input [4:0] src2, 
	input [4:0] idexe_dest, 
	input [4:0] exemem_dest, 
	input [4:0] wb_dest,
	input mem_wb_en,  
	input wb_wb_en,  
	output [1:0] src2_val_selector, 
	output [1:0] val1_selector, 
	output [1:0] val2_selector, 
);

endmodule