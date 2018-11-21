module HazardDU (
	input [4:0] src1, 
	input [4:0] src2, 
	input [4:0] exe_dest, 
	input exe_wb_en, 
	input [4:0] mem_dest, 
	input mem_wb_en, 
	/* forwarding signals */
	input mem_mem_r_en,
	input exe_is_immidiate,
	input en_fwd,
	/* end of forwarding signals */
	output reg hazard_detected
	); 
	
	always @ (*) begin
	      if(en_fwd == 1'b0) begin
	          hazard_detected = 1'b0;
	          if(mem_dest != 5'd0) begin
              if(mem_wb_en==1'b1) begin 
        	       if((src1==mem_dest) || (src2==mem_dest)) hazard_detected = 1'b1;
            end 
          end
      
          if(exe_dest != 5'd0) begin
            if(exe_wb_en==1'b1) begin 
        	     if((src1==exe_dest) || (src2==exe_dest)) hazard_detected = 1'b1;
            end 
        end
      end // en_fwd end
    
    
  else if(en_fwd == 1'b1) begin
    if(mem_mem_r_en == 1'b1  && exe_is_immidiate == 1'b0) begin
        if((src1==mem_dest) || (src2==mem_dest)) hazard_detected = 1'b1;
    end
    
  end // else if end
    
	end  // always end
endmodule 