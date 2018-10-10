module ROM(input clock, input [31:0] address, output [32:0] instruction);

    reg [10:0] rom [31:0]; 

    always @ (posedge clock)
    begin 
        instruction = rom[address];
    end 

endmodule 