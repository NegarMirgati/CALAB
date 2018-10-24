module IF(input clock, input reset, input [31:0] branch_address, input branch_tacken, output [31:0] instruction, output [31:0] pc_value);

    reg [31:0] pc = 32'd0;
    wire [31:0] pcplus4;
    wire [31:0] nextpc;

    Adder pc_adder (.value1(pc), .value2(32'd4), .out_val(pcplus4));
    MUX #(32) dest_mux (.value1(pcplus4),.value2(branch_address), .selector(branch_tacken),.out_val(nextpc));

    always @ (posedge clock, posedge reset)
    begin 
        if (reset) pc = 32'd0;
        else pc = nextpc;
    end

    ROM rom (clock, pc, instruction);
    assign pc_value = pc;

endmodule