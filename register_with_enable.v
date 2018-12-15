module register_with_enable #(parameter len = 32) (input clock, 
	input reset,
	input enable,
	input [len-1:0] input_value, 
	output reg [len-1:0] output_value);

    always @ (posedge clock)
    begin
        if (reset) output_value = 0;
        else if(enable) output_value = input_value;
    end 

endmodule 

