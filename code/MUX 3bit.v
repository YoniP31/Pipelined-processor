module MUX_3BIT(
    input [15:0] i_src1, i_src2, i_src3,
    input [1:0] i_sel,
    output [15:0] o_MUX_out
);

assign o_MUX_out = (i_sel == 2'b00)? i_src1
    : (i_sel == 2'b01)? i_src2
    : (i_sel == 2'b10)? i_src3 : i_src3;

endmodule