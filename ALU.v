module ALU (
	input [31:0] input_val1, input_val2, 
	input [3:0] exe_cmd, 
	output reg [31:0] output_val
	);

	always @(exe_cmd, input_val1, input_val2) begin 
		case(exe_cmd)
			4'b0000: ouput_val <= input_val1 + input_val2; 
			4'b0010: ouput_val <= input_val1 - input_val2; 
			4'b0100: ouput_val <= input_val1 & input_val2; 
			4'b0101: ouput_val <= input_val1 | input_val2; 
			4'b0110: ouput_val <= input_val1 ~| input_val2; 
			4'b0111: ouput_val <= input_val1 ^ input_val2; 
			4'b1000: ouput_val <= input_val1 << input_val2; 
			4'b1001: ouput_val <= input_val1 >>> input_val2; 
			4'b1010: ouput_val <= input_val1 >> input_val2; 
			default: ouput_val <= input_val1; 
		endcase
	end 

endmodule