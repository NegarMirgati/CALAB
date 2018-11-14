module Controller(input [5:0] opcode, output reg[1:0] branch_type, output reg [3:0] exe_cmd, output reg mem_write, output reg mem_read, output reg writeback_en, output reg is_immediate);

	always @ (opcode) begin
	{mem_read, mem_write, writeback_en, exe_cmd, branch_type} = 9'd0;
    case(opcode)
			6'd1 : begin  //addition
			  mem_write = 1'd0;
			  exe_cmd = 4'd0;
			  is_immediate = 1'd0;
			  writeback_en = 1'd1;
			  end
			  
			6'd3 : begin  // subtraction
			 mem_write = 1'd0;
			 exe_cmd = 4'd2;
			 is_immediate = 1'd0;
			 writeback_en = 1'd1;
			 end
			 
			6'd5: begin  // And
			 mem_write = 1'd0;
			 exe_cmd = 4'b0100;
			 is_immediate = 1'd0;
			 writeback_en = 1'd1;
			 end
			
			6'd6 : begin // OR
			 mem_write = 1'd0;
			 mem_read = 1'd0;
			 exe_cmd = 4'b0101;
			 is_immediate = 1'd0;
			 writeback_en = 1'd1;
			 end
			 
			6'd7 : begin // NOR
			 mem_write = 1'd0;
			 mem_read = 1'd0;
			 exe_cmd = 4'b0110;
			 is_immediate = 1'b0;
			 writeback_en = 1'd1;
			 end
			 
			6'd8 : begin // XOR
			 mem_write = 1'd0;
			 mem_read = 1'b0;
			 exe_cmd = 4'b0111;
			 is_immediate = 1'b0;
			 writeback_en = 1'd1;
			 end
			 
			6'd9 : begin // SLA 
			 mem_write = 1'd0;
			 mem_read = 1'd0;
			 exe_cmd = 4'b1000;
			 is_immediate = 1'b0;
			 writeback_en = 1'd1;
			 end
			 
			6'd10 : begin // SLL - exe_cmd edited
			 mem_write = 1'd0;
			 mem_read = 1'd0;
			 exe_cmd = 4'b1000;
			 is_immediate = 1'b0;
			 writeback_en = 1'd1;
			 end
			
			6'd11 : begin // SRA
			 mem_write = 1'd0;
			 mem_read = 1'd0;
			 exe_cmd = 4'b1001;
			 is_immediate = 1'b0;
			 writeback_en = 1'd1;
			 end 
			 
			6'd12 : begin // SRL
			 mem_write = 1'd0;
			 mem_read = 1'b0;
			 exe_cmd = 4'b1010;
			 is_immediate = 1'b0;
			 writeback_en = 1'd1;
			 end
			 
			6'd32 : begin // ADDI
			 mem_write = 1'b0;
			 mem_read = 1'b0;
			 exe_cmd = 4'b0000;
			 is_immediate = 1'b1;
			 writeback_en = 1'd1;
			 end
			 
			6'd33 : begin  // SUBI
			 mem_write = 1'b0;
			 mem_read = 1'b0;
			 exe_cmd = 4'b0010;
			 is_immediate = 1'b1;
			 writeback_en = 1'd1;
			 end
			 
			6'd36 : begin // LD
			 mem_read = 1'b1;
			 mem_write = 1'b0;
			 exe_cmd = 4'b0000;
			 is_immediate = 1'b1;
			 writeback_en = 1'd1;
			 end
			 
			6'd37 : begin // ST
			 mem_read = 1'b0;
			 mem_write = 1'b1;
			 exe_cmd = 4'b0000;
			 is_immediate = 1'b1;
			 end
			 
			6'd40 : begin // BEZ
			 mem_read = 1'b0;
			 mem_write = 1'b0;
			 branch_type = 2'b01;
			 is_immediate = 1'b1;
			 end
			 
			6'd41 : begin //BNE
			 mem_read = 1'b0;
			 mem_write = 1'b0;
			 branch_type = 2'b10;
			 is_immediate = 1'b1;
			 end
			 
			6'd42 : begin // JMP
			 mem_read = 1'b0;
			 mem_write = 1'b0;
			 branch_type = 2'b11;
			 is_immediate = 1'b1;
			 end
			 
			default : begin 
			  {mem_read, mem_write, is_immediate, branch_type, writeback_en, exe_cmd} = 10'd0;
			  end
			endcase

	end

	

endmodule 
