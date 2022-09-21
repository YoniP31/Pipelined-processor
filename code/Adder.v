module ADDER(
    input [15:0] i_val1, i_val2,
    output [15:0] o_Adder_out
);

assign o_Adder_out = i_val1 + i_val2;

endmodule