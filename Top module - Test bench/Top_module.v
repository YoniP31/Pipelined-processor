`include "Pipeline stages/IF stage.v"
`include "Pipeline stages/ID stage.v"
`include "Pipeline stages/EX stage.v"
`include "Pipeline stages/MEM stage.v"
`include "Pipeline stages/WB stage.v"
`include "Pipeline register/IF2ID.v"
`include "Pipeline register/ID2EX.v"
`include "Pipeline register/EX2MEM.v"
`include "Pipeline register/MEM2WB.v"
`include "code/Register.v"
`include "code/Adder.v"
`include "code/MUX.v"
`include "code/ALU.v"
`include "code/Control unit.v"
`include "code/Condition checker.v"
`include "code/MUX 3bit.v"
`include "code/Hazard unit.v"
`include "code/Forwarding logic.v"
`include "Memory modules/Register file.v"
`include "Memory modules/Program memory.v"
`include "Memory modules/Data memory.v"

module TOP_MODULE(
    input clk, rst, forward_EN
);

logic Branch_Taken;
logic [4:0] Write_Reg_D, Write_Reg_E, Write_Reg_M, Write_Reg_W;
logic MEMtoReg_D, MEMtoReg_E, MEMtoReg_M, MEMtoReg_W;
logic REGWrite_D, REGWrite_E, REGWrite_M, REGWrite_W;
logic MEMRead_D, MEMRead_E, MEMRead_M;
logic MEMWrite_D, MEMWrite_E, MEMWrite_M;
logic Branch_D, Branch_E;
logic [5:0] ALUmode_D, ALUmode_E;

logic [15:0] Branch_PC, PC_F, PC_D;
logic [31:0] IR_D, IR_F;
logic [15:0] reg1, reg2;
logic [15:0] ALU_out_E, ALU_out_M, ALU_out_W, ALU_out;
logic [15:0] Data_Write_E, Data_Write_M;
logic [15:0] temp_reg_D, temp_reg_E;
logic [15:0] Write_back;
logic [15:0] DMEM_out_M, DMEM_out_W;
logic Is_IMM, Store_or_BNE;
logic [4:0] src2_D, src1_E, src2_E;
logic [1:0] oper1_sel, oper2_sel, Write_Data_sel;
logic hazard_detected, flush_F;

REGISTER_FILE REGISTER_FILE_unit(
    .i_clk(clk),
    .i_rst_n(rst),
    .i_write_enable(REGWrite_W),
    .i_src1(IR_D[20:16]),
    .i_src2(src2_D),
    .i_dest(Write_Reg_W),
    .i_input_val(Write_back),
    .o_reg1(reg1),
    .o_reg2(reg2)
);

HAZARD_UNIT HAZARD_UNIT_unit(
    .i_src1(IR_D[20:16]),
    .i_src2(src2_D),
    .i_Store_or_BNE(Store_or_BNE),
    .i_is_imm(Is_IMM),
    .i_forward_EN(forward_EN), //Hazard unit
    .i_Write_Reg_E(Write_Reg_E),
    .i_Write_Reg_M(Write_Reg_M),
    .i_Branch(Branch_D),
    .i_REGWrite_E(REGWrite_E),
    .i_REGWrite_M(REGWrite_M),
    .i_MEMRead_E(MEMRead_E),
    .o_hazard_detected(hazard_detected)
);

FORWARDING_LOGIC FORWARDING_LOGIC_unit(
    .i_src1_E(src1_E),
    .i_src2_E(src2_E),
    .i_Write_Reg_E(Write_Reg_E),
    .i_Write_Reg_M(Write_Reg_M),
    .i_Write_Reg_W(Write_Reg_W),
    .i_REGWrite_M(REGWrite_M),
    .i_REGWrite_W(REGWrite_W),
    .o_oper1_sel(oper1_sel),
    .o_oper2_sel(oper2_sel),
    .o_Write_Data_sel(Write_Data_sel)
);

IF_STAGE IF_STAGE_unit(
    .rst(rst),
    .freeze(hazard_detected), //Hazard unit
    .Branch_Taken(Branch_Taken),
    .Branch_PC(Branch_PC),
    .Adder_out(PC_F),
    .IR(IR_F)
);

ID_STAGE ID_STAGE_unit(
    .hazard_detected(hazard_detected),
    .IR(IR_D),
    .PC(PC_D),
    .Branch_PC(Branch_PC),
    .temp_reg(temp_reg_D),
    .reg2(reg2),
    .o_Write_Reg(Write_Reg_D),
    .ALUmode_D(ALUmode_D),
    .o_src2(src2_D),
    .Is_IMM(Is_IMM),
    .Store_or_BNE(Store_or_BNE),
    .o_MEMtoReg(MEMtoReg_D),
    .o_REGWrite(REGWrite_D),
    .o_MEMRead(MEMRead_D),
    .o_MEMWrite(MEMWrite_D),
    .Branch(Branch_D)
);

EX_STAGE EX_STAGE_unit(
    .rst(rst),
    .oper1_sel(oper1_sel),
    .oper2_sel(oper2_sel),
    .Write_Data_sel(Write_Data_sel),
    .ALUmode_E(ALUmode_E),
    .Branch(Branch_E),
    .reg1(reg1),
    .reg2(reg2),
    .temp_reg(temp_reg_E),
    .Write_back(Write_back),
    .ALU_out_MtoE(ALU_out),
    .ALU_out(ALU_out_E),
    .Data_Write(Data_Write_E),
    .Branch_Taken(Branch_Taken)
);

MEM_STAGE MEM_STAGE_unit(
    .clk(clk),
    .rst(rst),
    .ALU_out_M(ALU_out_M),
    .Data_Write_M(Data_Write_M),
    .i_MEMWrite(MEMWrite_M),
    .i_MEMRead(MEMRead_M),
    .ALU_out(ALU_out),
    .DMEM_out_M(DMEM_out_M)
);

WB_STAGE WB_STAGE_unit(
    .i_MEMtoReg(MEMtoReg_W),
    .DMEM_out(DMEM_out_W),
    .ALU_out(ALU_out_W),
    .o_WriteBack_out(Write_back)
);

IF2ID IF2ID_unit(
    .clk(clk),
    .rst(rst),
    .freeze(hazard_detected), //Hazard unit
    .flush(flush_F), //Hazard unit
    .i_PC(PC_F),
    .i_IR(IR_F),
    .o_PC(PC_D),
    .o_IR(IR_D)
);

ID2EX ID2EX_unit(
    .clk(clk),
    .rst(rst),
    .i_Write_Reg_D(Write_Reg_D),
    .i_temp_reg_D(temp_reg_D),
    .i_Branch_D(Branch_D),
    .i_src1_D(IR_D[20:16]),
    .i_src2_D(IR_D[15:11]),
    .o_Write_Reg_E(Write_Reg_E),
    .o_temp_reg_E(temp_reg_E),
    .o_Branch_E(Branch_E),
    .o_src1_E(src1_E),
    .o_src2_E(src2_E),
    .i_REGWrite_D(REGWrite_D),
    .i_MEMtoREG_D(MEMtoReg_D),
    .i_MEMRead_D(MEMRead_D),
    .i_MEMWrite_D(MEMWrite_D),
    .i_ALUMode_D(ALUmode_D),
    .o_REGWrite_E(REGWrite_E),
    .o_MEMtoREG_E(MEMtoReg_E),
    .o_MEMWrite_E(MEMWrite_E),
    .o_MEMRead_E(MEMRead_E),
    .o_ALUMode_E(ALUmode_E)
);

EX2MEM EX2MEM_unit(
    .clk(clk),
    .rst(rst),
    .i_ALU_out(ALU_out_E),
    .i_Data_Write(Data_Write_E),
    .i_REGWrite_E(REGWrite_E),
    .i_MEMtoREG_E(MEMtoReg_E),
    .i_MEMRead_E(MEMRead_E),
    .i_MEMWrite_E(MEMWrite_E),
    .i_Write_Reg_E(Write_Reg_E),
    .o_ALU_out(ALU_out_M),
    .o_Data_Write(Data_Write_M),
    .o_REGWrite_M(REGWrite_M),
    .o_MEMtoREG_M(MEMtoReg_M),
    .o_MEMWrite_M(MEMWrite_M),
    .o_MEMRead_M(MEMRead_M),
    .o_Write_Reg_M(Write_Reg_M)
);

MEM2WB MEM2WB_unit(
    .clk(clk),
    .rst(rst),
    .i_Write_Reg_M(Write_Reg_M),
    .i_REGWrite_M(REGWrite_M),
    .i_MEMtoReg_M(MEMtoReg_M),
    .i_DMEM_out(DMEM_out_M),
    .i_ALU_out(ALU_out),
    .o_Write_Reg_W(Write_Reg_W),
    .o_REGWrite_W(REGWrite_W),
    .o_MEMtoReg_W(MEMtoReg_W),
    .o_DMEM_out(DMEM_out_W),
    .o_ALU_out(ALU_out_W)
);

assign flush_F = Branch_Taken;

endmodule