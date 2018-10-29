module DataMemory(
	input clock,
	input reset, 
	input [31:0] address,
	input [31:0] write_data, 
	input mem_r_en, 
	input mem_w_en, 
	output reg [31:0] data);

    reg [7:0] rom [100:0]; 
    integer i;
    always @(posedge clock) begin
		if(reset) begin
		end
	end

    always @ (posedge clock)
    begin 
        if(mem_r_en) data = {rom[address], rom[address+1], rom[address+2], rom[address+3]};
        if(mem_w_en) {rom[address], rom[address+1], rom[address+2], rom[address+3]} = write_data ;
    end 

endmodule 