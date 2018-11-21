module MUX3INPUT #(parameter LEN = 32) ( 	
	input [LEN-1:0] value1, 
	input [LEN-1:0] value2,
	input [LEN-1:0] value3, 
	input [1:0] selector, 
	output reg [LEN-1:0] out_val
);

	always @ (*) begin 
	    if(selector==2'b00) out_val = value1; 
	    else if(selector==2'b01) out_val = value2; 
	    else if(selector==2'b10) out_val = value3; 
    end 

endmodule 