module ROM(input clock, input [31:0] address, output reg [32:0] instruction);

    reg [7:0] rom [1023:0]; 
    integer i;
    initial begin 
	 	{rom[0], rom[1], rom[2], rom[3]} = 32'b10000000000000010000011000001010;
	 	{rom[4], rom[5], rom[6], rom[7]} = 32'b00000100000000010001000000000000;
	 	{rom[8], rom[9], rom[10], rom[11]} = 32'b00001100000000010001100000000000;
	 	{rom[12], rom[13], rom[14], rom[15]} = 32'b00010100010000110010000000000000;
	 	{rom[16], rom[17], rom[18], rom[19]} = 32'b10000100011001010001101000110100;
	 	{rom[20], rom[21], rom[22], rom[23]} = 32'b00011000011001000010100000000000;
	 	{rom[24], rom[25], rom[26], rom[27]} = 32'b00011100101000000011000000000000;
	 	{rom[28], rom[29]], rom[30], rom[31]} = 32'b00011100100000000101100000000000;
	 	{rom[32], rom[33], rom[34], rom[35]} = 32'b00001100101001010010100000000000;
	 	{rom[36], rom[37], rom[38], rom[39]} = 32'b10000000000000010000010000000000;
	 	{rom[40], rom[41], rom[42], rom[43]} = 32'b10010100001000100000000000000000;
	 	{rom[44], rom[45], rom[46], rom[47]} =  32'b10010000001001010000000000000000;
    end 

    always @ (posedge clock)
    begin 
        instruction = {rom[address], rom[address+1], rom[address+2], rom[address+3]};
    end 

endmodule 