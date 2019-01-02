module register_with_enable #(parameter len) (input clock, 
	input reset,
	input enable,
	input [len-1:0] input_value, 
	output reg [len-1:0] output_value);

    always @ (posedge clock , posedge reset) begin
      if (reset) output_value = 0;
      else if(enable) output_value = input_value;
		else output_value = output_value;
    end 

endmodule 

