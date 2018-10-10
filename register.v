module register #(parameter len) (input clock, input reset, input [len-1:0] input_value, output [len-1:0] output_value)

    always @ (posedge clock, posedge reset)
    begin
        if (reset) output_value = 0;
        else output_value = input_value;
    end 

endmodule 