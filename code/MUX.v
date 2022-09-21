module MUX #(parameter LENGTH = 'd16)
(
    input [LENGTH-1:0] i_src1, i_src2,
    input i_sel,
    output [LENGTH-1:0] o_MUX_out
);

assign o_MUX_out = (i_sel == 1)? i_src1 : i_src2;

endmodule