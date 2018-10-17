module Controller(input [5:0] opcode, output Br_type, output EXE_cmd, output mem_write, output mem_read, output WriteBack_EN);

	always @ (opcode , func, zero) begin

		case(opcode)
			0: begin 
					

				end 

	end 

	

endmodule 