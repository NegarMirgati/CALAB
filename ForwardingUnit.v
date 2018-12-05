module ForwardingUnit(
	input enable_forward,
	input [4:0] src1, 
	input [4:0] src2, 
	input [4:0] idexe_dest, 
	input [4:0] exemem_dest, 
	input [4:0] wb_dest,
	input mem_wb_en,  
	input wb_wb_en,  
	input two_regs,
	output reg [1:0] src2_val_selector, 
	output reg [1:0] val1_selector, 
	output reg [1:0] val2_selector
);

	always @ (*) begin 
		 src2_val_selector = 2'b00; 
	    val1_selector = 2'b00; 
	    val2_selector = 2'b00; 
	    if(enable_forward==1'b1) begin 
	    	  if(src1==exemem_dest && mem_wb_en==1'b1) val1_selector = 2'b01; 
	    	  else if(src1==wb_dest && wb_wb_en==1'b1) val1_selector = 2'b10;
	       
	       if((src2==exemem_dest && mem_wb_en==1'b1) && two_regs == 1'b0) val2_selector = 2'b01; 
         else if((src2==wb_dest && wb_wb_en==1'b1) && two_regs == 1'b0) val2_selector = 2'b10;
           
         if(idexe_dest==exemem_dest && mem_wb_en==1'b1) src2_val_selector = 2'b01; 
         else if(idexe_dest==wb_dest && wb_wb_en==1'b1) src2_val_selector = 2'b10;

	    end 
    end 

endmodule