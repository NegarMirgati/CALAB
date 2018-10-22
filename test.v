`timescale 1ns/1ns

module test();

    reg clk=0, rst=0; 
    wire [6:0] ifid_pc, idexe_pc, exemem_pc, memwb_pc, ss_exe_cmd;

    pipeline #(32) pl(clk, rst, ifid_pc, idexe_pc, exemem_pc, memwb_pc, ss_exe_cmd);

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