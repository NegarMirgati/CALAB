module SignExtend #(parameter LEN = 16) (input [LEN-1:0] input_value, output [31:0] extended);
	assign extended = { {(32-LEN){input_value[LEN-1]}} ,input_value[LEN-1:0]};
endmodule