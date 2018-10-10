module IF(input clock, input reset, output [31:0] instruction, output [31:0] pc_value);
    reg [31:0] pc;

    always @ (posedge clock, posedge reset)
    begin 
        if (reset) pc = 32'd0;
        else pc = pc + 32'd4;
    end

    ROM rom (clock, pc, instruction);
    assign pc_value = pc;

endmodule