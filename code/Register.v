module REGISTER #(parameter LENGTH = 'd16)
(
    input i_rst_n, i_write_E,
    input [LENGTH-1:0] i_reg_In,
    output reg [LENGTH-1:0] o_reg_Out
);

always @(*) begin
    if(i_rst_n == 0)
        o_reg_Out <= 0;
    else if(i_write_E)
        o_reg_Out <= i_reg_In;
end

endmodule