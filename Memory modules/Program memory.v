module PROGRAM_MEMORY(
    input i_rst_n,
    input [15:0] i_address,
    output [31:0] o_instruction
);

logic [7:0] Program_memory [31:0];
logic i;

always @(*) begin
    if(i_rst_n == 0) begin
        Program_memory[0] <= 8'b10000000; //-- Addi	r1,r0,10
        Program_memory[1] <= 8'b00100000;
        Program_memory[2] <= 8'b00000000;
        Program_memory[3] <= 8'b00001010;

        Program_memory[4] <= 8'b00000100; //-- Add 	r2,r0,r1
        Program_memory[5] <= 8'b01000000;
        Program_memory[6] <= 8'b00001000;
        Program_memory[7] <= 8'b00000000;

        Program_memory[8] <= 8'b00001100; //-- sub	r3,r0,r1
        Program_memory[9] <= 8'b01100000;
        Program_memory[10] <= 8'b00001000;
        Program_memory[11] <= 8'b00000000;

        for(i = 12; i < 4294967296; i = i + 1) begin
            Program_memory[i] <= 8'b00000000;
        end
    end
end

assign o_instruction = {Program_memory[i_address], Program_memory[i_address + 1], Program_memory[i_address + 2], Program_memory[i_address + 3]};

endmodule