module ROM(input clock, input [31:0] address, output [32:0] instruction);

    reg [10:0] rom [31:0]; 

    initial begin 
        for(i=0; i<1023; i = i+1) 
            rom[i] = 16'd10;
    end 

    always @ (posedge clock)
    begin 
        instruction = rom[address];
    end 

endmodule 