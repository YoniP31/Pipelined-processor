
module ID_STAGE(
    input hazard_detected,
    input [31:0] IR,
    input [15:0] PC,
    input [15:0] reg2,
    output [15:0] Branch_PC,
    output [15:0] temp_reg,
    output [4:0] o_Write_Reg,
    output [5:0] ALUmode_D,
    output [4:0] o_src2,
    output Is_IMM, Store_or_BNE,
    output o_MEMtoReg, o_REGWrite, o_MEMRead, o_MEMWrite, Branch
);

logic [4:0] Write_Reg;
logic MEMtoReg, REGWrite, MEMRead, MEMWrite;

CONTROL_UNIT CONTROL_UNIT_unit(
    .hazard_detected(hazard_detected),
    .i_ALUmode(IR[31:26]),
    .o_ALUmode(ALUmode_D),
    .o_RegWrite(REGWrite),
    .o_MEMtoReg(MEMtoReg),
    .o_MEMWrite(MEMWrite),
    .o_MEMRead(MEMRead),
    .o_Store_or_BNE(Store_or_BNE),
    .o_Branch(Branch),
    .o_is_imm(Is_IMM)
);

ADDER ADDER_OFFSET(
    .i_val1(IR[15:0]),
    .i_val2(PC),
    .o_Adder_out(Branch_PC)
);

MUX #(.LENGTH('d5)) REG_FILE_MUX(
    .i_src1(IR[15:11]),
    .i_src2(IR[25:21]),
    .i_sel(Store_or_BNE),
    .o_MUX_out(o_src2)
);

MUX #(.LENGTH('d16)) IMM_MUX(
    .i_src1(reg2),
    .i_src2(IR[15:0]),
    .i_sel(Is_IMM),
    .o_MUX_out(temp_reg)
);

MUX #(.LENGTH('d5)) DEST_MUX(
    .i_src1(IR[20:16]),
    .i_src2(IR[15:11]),
    .i_sel(Reg_Dest),
    .o_MUX_out(Write_Reg)
);

assign o_REGWrite = REGWrite;
assign o_MEMtoReg = MEMtoReg;
assign o_MEMWrite = MEMWrite;
assign o_MEMRead = MEMRead;
assign o_Write_Reg = Write_Reg;

endmodule