`timescale 1ns/1ns

module test();

    reg clk=0, rst=0; 

    pipeline #(32) pl(clk, rst);

    initial begin 
        #50 
        rst = 1; 
        #100
        clk = ~clk; 
        #50
        rst = 0;   
        repeat(1000) #1000 clk = ~clk;
    end 

endmodule 