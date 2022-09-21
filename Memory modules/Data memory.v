module DATA_MEMORY(
    input i_clk, i_rst_n,
    input i_write_enable,
    input i_read_enable,
    input [15:0] i_data_in,
    input [15:0] i_address,
    output reg [15:0] o_data_out
);

logic [7:0] Data_memory [15:0];
logic i;

always @(negedge i_clk) begin
    if(i_rst_n == 0) begin
        for(i = 0; i < 16; i = i + 1)
            Data_memory[i] <= 0;
    end else if(i_write_enable) begin
        {Data_memory[i_address],Data_memory[i_address+1],Data_memory[i_address+2],Data_memory[i_address+3]} <= i_data_in;
    end
end

assign o_data_out = (i_read_enable == 1)? {Data_memory[i_address],Data_memory[i_address+1],Data_memory[i_address+2],Data_memory[i_address+3]} : 0;

endmodule