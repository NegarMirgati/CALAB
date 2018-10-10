module ROM(input clock, input [31:0] address, output reg [32:0] instruction);

    reg [31:0] rom [1023:0]; 
    integer i;
    initial begin 
        for(i=0; i<1023; i = i+1) 
            rom[i] = 32'd10;
    end 

    always @ (posedge clock)
    begin 
        instruction = rom[address];
    end 

endmodule 