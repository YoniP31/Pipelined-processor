
module WB_STAGE(
    input i_MEMtoReg,
    input [15:0] DMEM_out, ALU_out,
    output [15:0] o_WriteBack_out
);

MUX WB_MUX(
    .i_src1(DMEM_out),
    .i_src2(ALU_out),
    .i_sel(i_MEMtoReg),
    .o_MUX_out(o_WriteBack_out)
);

endmodule