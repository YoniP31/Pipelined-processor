`timescale 1ns/1ns
`include "Top_module.v"

module TEST_BENCH();

logic clk, rst, forward_EN;

TOP_MODULE PROCESSOR(
    .clk(clk),
    .rst(rst),
    .forward_EN(forward_EN)
);

initial begin
    clk = 0;
    rst = 0;
    forward_EN = 0;
    #100
    rst = 1;
end

always #10 clk = ~clk;

initial begin
    $dumpfile("top.vcd");
    $dumpvars(0, TEST_BENCH);
    $display("test started");
    #10
    $display("test commencing");
    #2000
    $display("test complete");
    $finish;
end

endmodule