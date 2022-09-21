
module IF_STAGE(
    input rst, Branch_Taken, freeze,
    input [15:0] Branch_PC,
    output [15:0] Adder_out,
    output [31:0] IR
);

logic [15:0] Adder_out, PC_updated, PC;

REGISTER REGISTER_PC(
    .i_rst_n(rst),
    .i_write_E(~freeze),
    .i_reg_In(PC_updated),
    .o_reg_Out(PC)
);

ADDER ADDER_4(
    .i_val1(PC),
    .i_val2(16'd4),
    .o_Adder_out(Adder_out)
);

MUX PC_MUX(
    .i_src1(Branch_PC),
    .i_src2(Adder_out),
    .i_sel(Branch_Taken),
    .o_MUX_out(PC_updated)
);

PROGRAM_MEMORY PROGRAM_MEMORY_unit(
    .i_rst_n(rst),
    .i_address(PC),
    .o_instruction(IR)
);

endmodule