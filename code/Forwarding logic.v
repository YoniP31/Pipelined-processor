module FORWARDING_LOGIC(
    input [4:0] i_src1_E, i_src2_E, i_Write_Reg_E,
    input [4:0] i_Write_Reg_M, i_Write_Reg_W,
    input i_REGWrite_M, i_REGWrite_W,
    output reg [1:0] o_oper1_sel, o_oper2_sel, o_Write_Data_sel
);

always @(*) begin
    o_oper1_sel <= 2'b00;
    o_oper2_sel <= 2'b00;
    o_Write_Data_sel <= 2'b00;

    if(i_REGWrite_M && i_Write_Reg_E == i_Write_Reg_M)
        o_Write_Data_sel <= 2'b01;
    else if(i_REGWrite_W && i_Write_Reg_E == i_Write_Reg_W)
        o_Write_Data_sel <= 2'b10;

    if(i_REGWrite_M && i_src1_E == i_Write_Reg_M)
        o_oper1_sel <= 2'b01;
    else if(i_REGWrite_W && i_src1_E == i_Write_Reg_W)
        o_oper1_sel <= 2'b10;

    if(i_REGWrite_M && i_src2_E == i_Write_Reg_M)
        o_oper2_sel <= 2'b01;
    else if(i_REGWrite_W && i_src2_E == i_Write_Reg_W)
        o_oper2_sel <= 2'b10;

end

endmodule