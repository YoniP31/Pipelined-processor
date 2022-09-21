
module MEM_STAGE(
    input clk, rst,
    input [15:0] ALU_out_M, Data_Write_M,
    input i_MEMWrite, i_MEMRead,
    output [15:0] ALU_out, DMEM_out_M
);

DATA_MEMORY DATA_MEMORY_unit(
    .i_clk(clk),
    .i_rst_n(rst),
    .i_write_enable(i_MEMWrite),
    .i_read_enable(i_MEMRead),
    .i_data_in(Data_Write_M),
    .i_address(ALU_out_M),
    .o_data_out(DMEM_out_M)
);

assign ALU_out = ALU_out_M;

endmodule