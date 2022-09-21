
module EX_STAGE(
    input rst,
    input [1:0] oper1_sel, oper2_sel, Write_Data_sel,
    input [5:0] ALUmode_E,
    input Branch,
    input [15:0] reg1, reg2, temp_reg, Write_back, ALU_out_MtoE,
    output Branch_Taken,
    output [15:0] ALU_out, Data_Write
);

logic [15:0] ALU_src1, ALU_src2;
logic [3:0] SR, SR_updated;
logic Branch_Condition;

MUX_3BIT ALU_OPER1_MUX(
    .i_src1(reg1),
    .i_src2(Write_back),
    .i_src3(ALU_out_MtoE),
    .i_sel(oper1_sel), //hazard unit logic
    .o_MUX_out(ALU_src1)
);

MUX_3BIT ALU_OPER2_MUX(
    .i_src1(temp_reg),
    .i_src2(Write_back),
    .i_src3(ALU_out_MtoE),
    .i_sel(oper2_sel),//hazard unit logic
    .o_MUX_out(ALU_src2)
);

MUX_3BIT DATA_WRITE_MUX(
    .i_src1(reg2),
    .i_src2(Write_back),
    .i_src3(ALU_out_MtoE),
    .i_sel(Write_Data_sel),//hazard unit logic
    .o_MUX_out(Data_Write)
);

ALU ALU_unit(
    .i_operand1(ALU_src1),
    .i_operand2(ALU_src2),
    .i_mode(ALUmode_E),
    .i_flags(SR),
    .o_out(ALU_out),
    .o_flags(SR_updated)
);

REGISTER #(.LENGTH('d4)) REGISTER_SR(
    .i_rst_n(rst),
    .i_write_E(~freeze),
    .i_reg_In(SR_updated),
    .o_reg_Out(SR)
);

CONDITION_CHECKER CONDITION_CHECKER_unit(
    .i_reg1(reg1),
    .i_reg2(reg2),
    .i_SR(SR),
    .i_ALUmode(ALUmode_E),
    .o_Branch_Condition(Branch_Condition)
);

assign Branch_Taken = Branch_Condition & Branch;

endmodule