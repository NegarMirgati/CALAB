module register_f #(parameter len = 32) (input clock, 
	input reset, input flush,
	input [len-1:0] input_value, 
	output reg [len-1:0] output_value);

    always @ (posedge clock)
    begin
        if (reset) output_value = 0;
        else if (flush) output_value = 0;
        else output_value = input_value;
    end 

endmodule 
