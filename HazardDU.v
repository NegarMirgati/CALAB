module HazardDU (
	input [4:0] src1, 
	input [4:0] src2, 
	input [4:0] exe_dest, 
	input exe_wb_en, 
	input [4:0] mem_dest, 
	input mem_wb_en, 
	output hazard_detected
	); 
	
	always @ (*) begin 
        if(mem_wb_en==1'b1) begin 
        	if((src1==mem_dest) || (src2==mem_dest)) hazard_detected = 1'b1;
        end 
        else if(exe_wb_en==1'b1) begin 
        	if((src1==exe_dest) || (src2==exe_dest)) hazard_detected = 1'b1;
        end 
        else hazard_detected = 1'b0;

    end 
	
endmodule 