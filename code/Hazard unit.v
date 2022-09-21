module HAZARD_UNIT(
    input [4:0] i_src1, i_src2,
    input i_Store_or_BNE, i_is_imm, i_forward_EN,
    input [4:0] i_Write_Reg_E, i_Write_Reg_M,
    input i_Branch, i_REGWrite_E, i_REGWrite_M, i_MEMRead_E,
    output o_hazard_detected
);

logic src2_valid, EX_hazard, MEM_hazard, hazard, IR_Branch;

assign src2_valid = (~i_is_imm) || i_Store_or_BNE;
assign EX_hazard = i_REGWrite_E && (i_src1 == i_Write_Reg_E || (src2_valid && i_src2 == i_Write_Reg_E));
assign MEM_hazard = i_REGWrite_M && (i_src1 == i_Write_Reg_M || (src2_valid && i_src2 == i_Write_Reg_M));
assign hazard = (EX_hazard || MEM_hazard);
assign IR_Branch = i_Branch;
assign o_hazard_detected = ~i_forward_EN ? hazard : (IR_Branch && hazard) || (i_MEMRead_E && MEM_hazard);

endmodule