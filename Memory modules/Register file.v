module REGISTER_FILE(
    input i_clk, i_rst_n,
    input i_write_enable,
    input [4:0] i_src1, i_src2, i_dest,
    input [15:0] i_input_val,
    output [15:0] o_reg1, o_reg2
);

logic [15:0] Register_memory [31:0];
logic i;

always @(negedge i_clk) begin
    if(i_rst_n == 0) begin
        for(i = 0; i < 16; i = i + 1) begin
            Register_memory[i] <= 0;
        end
    end else if(i_write_enable) begin
        Register_memory[i_dest] <= i_input_val;
    end
end

assign o_reg1 = Register_memory[i_src1];
assign o_reg2 = Register_memory[i_src2];

endmodule