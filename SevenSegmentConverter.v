module SevenSegmentConverter(input [3:0] inp_val, output reg [6:0] outval);
    always @(*) begin
    case(inp_val) 
        4'b0000: outval = 7'b1000000; 
        4'b0001: outval = 7'b1111001; 
        4'b0010: outval = 7'b0100100; 
        4'b0011: outval = 7'b0110000; 
        4'b0100: outval = 7'b0011001; 
        4'b0101: outval = 7'b0010010; 
        4'b0110: outval = 7'b0000010; 
        4'b0111: outval = 7'b1111000; 
        4'b1000: outval = 7'b0000000; 
        4'b1001: outval = 7'b0010000; 
		  
		  4'b1010: outval = 7'b0001000; 
        4'b1011: outval = 7'b0000011; 
        4'b1100: outval = 7'b1000110; 
        4'b1101: outval = 7'b0100001; 
        4'b1110: outval = 7'b0000110; 
        4'b1111: outval = 7'b0001110; 
        default: outval = 7'b1000000;
    endcase 
  end

endmodule 