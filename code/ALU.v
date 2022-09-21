module ALU(
    input [15:0] i_operand1, i_operand2,
    input [5:0] i_mode,
    input [3:0] i_flags,
    output [15:0] o_out,
    output [3:0] o_flags
);

logic Z,S,O;
logic carry_out;
logic [15:0] out_ALU;
logic i = 0;

always @(*) begin
case(i_mode)
6'b000001, 6'b100000, 6'b100100, 6'b100101: {carry_out, out_ALU} = i_operand1 + i_operand2;
6'b000010, 6'b100001: begin
    out_ALU = i_operand1 - i_operand2;
    carry_out = !out_ALU[15];
end
6'b000011: for(i = 0; i <= i_operand2; i = i + 1) begin
    out_ALU = out_ALU + i_operand1;
end
6'b000100: out_ALU = {15'b0, i_operand2[i_operand1]};
6'b000101: out_ALU = i_operand1 & i_operand2;
6'b000110: out_ALU = i_operand1 | i_operand2;
6'b000111: out_ALU = i_operand1 ^ i_operand2;
6'b001000: out_ALU = (i_operand2 << i_operand1[2:0])|(i_operand2 >> 16 - i_operand1[2:0]);
6'b001001: out_ALU = i_operand2 << i_operand1[2:0];
6'b001010: out_ALU = (i_operand2 >> i_operand1[2:0])|(i_operand2 << 16 - i_operand1[2:0]);
6'b001011: out_ALU = i_operand2 >> i_operand1[2:0];

default: out_ALU = 0;
endcase
end
assign Z = (out_ALU == 0)? 1'b1 : 1'b0;
assign S = out_ALU[15];
assign O = out_ALU[15] ^ out_ALU[14];
assign o_flags = {Z,carry_out,S,O};
assign o_out = out_ALU;

endmodule