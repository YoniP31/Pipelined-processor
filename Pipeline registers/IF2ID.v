module IF2ID(
    input clk, rst, freeze, flush,
    input [15:0] i_PC,
    input [31:0] i_IR,
    output reg [15:0] o_PC,
    output reg [31:0] o_IR
);

always @(posedge clk) begin
    if(rst) begin
        o_PC <= 0;
        o_IR <= 0;
    end
    else begin
        if(freeze == 0) begin
            if(flush) begin
                o_PC <= 0;
                o_IR <= 0;
            end
        end
    end
end

endmodule