module ID2EX(
    input clk, rst,
    input [4:0] i_Write_Reg_D,
    input [15:0] i_temp_reg_D,
    input i_Branch_D,
    input [4:0] i_src1_D, i_src2_D,
    output reg [4:0] o_Write_Reg_E,
    output reg [15:0] o_temp_reg_E,
    output reg o_Branch_E,
    output reg [4:0] o_src1_E, o_src2_E,
    input i_REGWrite_D, i_MEMtoREG_D, i_MEMWrite_D, i_MEMRead_D, 
    input [5:0] i_ALUMode_D,
    output reg o_REGWrite_E, o_MEMtoREG_E, o_MEMWrite_E, o_MEMRead_E,
    output reg [5:0] o_ALUMode_E
);

always @(posedge clk) begin
    if(rst) begin
        {o_REGWrite_E, o_MEMtoREG_E, o_MEMWrite_E, o_MEMRead_E, o_ALUMode_E} <= 0;
        o_Write_Reg_E <= 0;
        o_Branch_E <= 0;
    end
    else begin
        o_Write_Reg_E <= i_Write_Reg_D;
        o_REGWrite_E <= i_REGWrite_D;
        o_MEMtoREG_E <= i_MEMtoREG_D;
        o_MEMWrite_E <= i_MEMWrite_D;
        o_MEMWrite_E <= i_MEMWrite_D;
        o_ALUMode_E <= i_ALUMode_D;
        o_temp_reg_E <= i_temp_reg_D;
        o_Branch_E <= i_Branch_D;
        o_src1_E <= i_src1_D;
        o_src2_E <= i_src2_D;
    end
end

endmodule