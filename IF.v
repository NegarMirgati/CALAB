module IF(input clock, input reset, input [31:0] branch_address, input branch_taken, output [31:0] instruction, output [31:0] pc_value);

    wire [31:0] pc;
    wire [31:0] pcplus4;
    wire [31:0] nextpc;
    register #(32) pc_reg(.clock(clock), .reset(reset), .input_value(nextpc), .output_value(pc));


    Adder pc_adder (.value1(pc), .value2(32'd4), .out_val(pcplus4));
    MUX #(32) dest_mux (.value2(branch_address),.value1(pcplus4), .selector(branch_taken),.out_val(nextpc));
    ROM rom (clock, reset, pc, instruction);
    assign pc_value = pcplus4;
endmodule