module ALU (
	input [31:0] input_val1, input_val2, 
	input [3:0] exe_cmd, 
	output reg [31:0] output_val
	);

	always @(exe_cmd, input_val1, input_val2) begin 
		case(exe_cmd)
			4'b0000: output_val <= input_val1 + input_val2; // addition
			4'b0010: output_val <= input_val1 - input_val2; // subtraction
			4'b0100: output_val <= input_val1 & input_val2; // bitwise and 
			4'b0101: output_val <= input_val1 | input_val2;  //bitwise or
			4'b0110: output_val <= ~(input_val1 | input_val2); // check NOR
			4'b0111: output_val <= input_val1 ^ input_val2; // xor
			4'b1000: output_val <= input_val1 << input_val2; // SLA - shift left arithmatic
			4'b1001: output_val <= $signed(input_val1) >>> input_val2; // SRA - shift right arithmetic
			4'b1010: output_val <= input_val1 >> input_val2; // SRL - shift right logical
			//4'b1000: output_val <= input_val1 << input_val2; // SLL - shift left logical
			default: output_val <= 32'd0; 
		endcase
	end 

endmodule