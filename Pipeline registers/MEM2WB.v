module MEM2WB(
    input clk, rst,
    input i_REGWrite_M, i_MEMtoReg_M, 
    input [4:0] i_Write_Reg_M,
    input [15:0] i_DMEM_out, i_ALU_out,
    output reg o_REGWrite_W, o_MEMtoReg_W,
    output reg [4:0] o_Write_Reg_W,
    output reg [15:0] o_DMEM_out, o_ALU_out
);

always @(posedge clk) begin
    if(rst) begin
        o_REGWrite_W <= 0;
        o_MEMtoReg_W <= 0;
        o_Write_Reg_W <= 0;
        o_ALU_out <= 0;
        o_DMEM_out <= 0;
    end
    else begin
        o_REGWrite_W <= i_REGWrite_M;
        o_MEMtoReg_W <= i_MEMtoReg_M;
        o_Write_Reg_W <= i_Write_Reg_M;
        o_ALU_out <= i_ALU_out;
        o_DMEM_out <= i_DMEM_out;
    end
end

endmodule