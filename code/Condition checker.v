module CONDITION_CHECKER (
    input [15:0] i_reg1, i_reg2,
    input [3:0] i_SR,
    input [5:0] i_ALUmode,
    output reg o_Branch_Condition
);

always @(*) begin
    case(i_ALUmode)
        'b101000: o_Branch_Condition <= (i_reg1 == 'd0)? 1 : 0; //BEZ
        'b101001: o_Branch_Condition <= (i_reg1 != i_reg2)? 1 : 0; //BNE
        'b101010: o_Branch_Condition <= (i_SR[2] == 'd1)? 1 : 0; //BEC
        'b101011: o_Branch_Condition <= (i_SR[0] == 'd1)? 1 : 0; //BEO
        'b101100: o_Branch_Condition <= (i_SR[1] == 'd1)? 1 : 0; //BES
        'b101101: o_Branch_Condition <= 1;
        default: o_Branch_Condition <= 0;
    endcase
end
endmodule