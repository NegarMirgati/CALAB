module Adder  #(parameter LEN = 32) ( 
	input [LEN-1:0] value1, 
	input [LEN-1:0] value2, 
	output [LEN-1:0] out_val
);
	assign out_val = value1 + value2;

endmodule 