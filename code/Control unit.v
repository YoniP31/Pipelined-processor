module CONTROL_UNIT(
    input hazard_detected,
    input [5:0] i_ALUmode,
    output reg [5:0] o_ALUmode,
    output reg o_RegWrite, o_MEMtoReg, o_MEMWrite,
    output reg o_MEMRead, o_Branch, o_is_imm, o_Store_or_BNE
);

always @(*) begin
    if(hazard_detected == 0) begin
        o_RegWrite <= 0;
        o_MEMtoReg <= 0;
        o_MEMWrite <= 0;
        o_MEMRead <= 0;
        o_Branch <= 0;
        o_is_imm <= 0;
        o_Store_or_BNE <= 0;
        case(i_ALUmode)
        6'b000001: o_RegWrite = 1; //ADD
        6'b000010: o_RegWrite = 1; //SUB
        6'b000011: o_RegWrite = 1; //MUL
        6'b000100: o_RegWrite = 1; //SEL
        6'b000101: o_RegWrite = 1; //AND
        6'b000110: o_RegWrite = 1; //OR
        6'b000111: o_RegWrite = 1; //XOR
        6'b001000: o_RegWrite = 1; //SLA
        6'b001001: o_RegWrite = 1; //SLL
        6'b001010: o_RegWrite = 1; //SRA
        6'b001011: o_RegWrite = 1; //SRL
        6'b100000: begin //ADDI
            o_RegWrite = 1;
            o_is_imm = 1;
        end
        6'b100001: begin //SUBI
            o_RegWrite = 1;
            o_is_imm = 1;
        end
        6'b100100: begin //LD
            o_is_imm = 1;
            o_Store_or_BNE = 1;
            o_MEMRead = 1;
        end
        6'b100101: begin //ST
            o_RegWrite = 1;
            o_is_imm = 1;
            o_Store_or_BNE = 1;
        end
        6'b101000: begin //BEZ
            o_is_imm = 1;
            o_Branch = 1;
        end
        6'b101001: begin //BNE
            o_is_imm = 1;
            o_Branch = 1;
            o_Store_or_BNE = 1;
        end
        6'b101010: begin //BEC
            o_is_imm = 1;
            o_Branch = 1;
        end
        6'b101011: begin //BEO
            o_is_imm = 1;
            o_Branch = 1;
        end
        6'b101100: begin //BES
            o_is_imm = 1;
            o_Branch = 1;
        end
        'b101101: begin //JMP
            o_is_imm = 1;
            o_Branch = 1;
        end
        default: begin
            o_RegWrite <= 0;
            o_MEMtoReg <= 0;
            o_MEMWrite <= 0;
            o_MEMRead <= 0;
            o_Branch <= 0;
            o_is_imm <= 0;
            o_Store_or_BNE <= 0;
        end
        endcase
    end
    else if(hazard_detected == 1) begin
        o_RegWrite <= 0;
        o_MEMWrite <= 0;
    end
end

assign o_ALUmode = i_ALUmode;

endmodule