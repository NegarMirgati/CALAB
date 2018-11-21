`timescale 1ns/1ns

module test();

    reg clk=0, rst=0, en_fwd = 1;

    pipeline #(32) pl(clk, rst, en_fwd);

    initial begin 
        #50 
        rst = 1; 
        #1000
        clk = ~clk;
        #1000 
        clk = ~clk;
        #50
        rst = 0;   
        repeat(1000) #1000 clk = ~clk;
    end 

endmodule 