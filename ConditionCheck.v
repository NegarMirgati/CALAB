module ConditionCheck(
	input [31:0] val1, 
	input [31:0] src2_val, 
	input [1:0] branch_type, 
	output reg branch_taken
	);
	
	always @(*) begin 
	  if(branch_type == 2'b11 )
	     branch_taken = 1'b1;
	  else if (branch_type == 2'b01)/* BEZ */ 
	    branch_taken = (val1 == 32'd0) ? 1'd1 : 1'd0;
	   
	  else if (branch_type == 2'b10)  /* BNE */
	    branch_taken = (val1 == src2_val ) ? 1'd1 : 1'd0;
	  else
	     branch_taken = 1'd0;
	end
	    

endmodule