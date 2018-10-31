module DataMemory(
	input clock,
	input reset, 
	input [31:0] address,
	input [31:0] write_data, 
	input mem_r_en, 
	input mem_w_en, 
	output reg [31:0] data);

    reg [7:0] rom [255:0]; 
    integer i;

    always @ (*) begin 
        if(mem_r_en) 
          data = {rom[address], rom[address + 1], rom[address + 2], rom[address + 3]};
        else 
          data = 32'd0;
    end 
    
    always @ (posedge clock, posedge reset) begin
	 	if(reset) begin
		  for(i = 255; i >=0 ; i = i - 1)
		     rom[i] = i - 255;
		end
       else if(mem_w_en) 
        {rom[address], rom[address + 1], rom[address + 2], rom[address + 3]} = write_data ;
    end
         
endmodule 