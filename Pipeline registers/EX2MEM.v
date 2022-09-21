module EX2MEM(
    input clk, rst,
    input [15:0] i_ALU_out, i_Data_Write,
    input [4:0] i_Write_Reg_E,
    input i_REGWrite_E, i_MEMtoREG_E, i_MEMWrite_E, i_MEMRead_E,
    output reg [15:0] o_ALU_out, o_Data_Write,
    output reg [4:0] o_Write_Reg_M,
    output reg o_REGWrite_M, o_MEMtoREG_M, o_MEMWrite_M, o_MEMRead_M
);

always @(posedge clk) begin
    if(rst) begin
        {o_REGWrite_M, o_MEMtoREG_M, o_MEMWrite_M, o_MEMRead_M} <= 0;
        o_ALU_out <= 0;
        o_Data_Write <= 0;
        o_Write_Reg_M <= 0;
    end
    else begin
        o_ALU_out <= i_ALU_out;
        o_Data_Write <= i_Data_Write;
        o_Write_Reg_M <= i_Write_Reg_E;
        o_REGWrite_M <= i_REGWrite_E;
        o_MEMtoREG_M <= i_MEMtoREG_E;
        o_MEMWrite_M <= i_MEMWrite_E;
        o_MEMRead_M <= i_MEMRead_E;
    end
end

endmodule