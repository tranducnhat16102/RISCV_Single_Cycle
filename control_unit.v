module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg ALUSrc,
    output reg [3:0] ALUOp,
    output reg Branch,
    output reg MemRead,
    output reg MemWrite,
    output reg MemToReg,
    output reg RegWrite
);
    always @* begin
        // Default values
        ALUSrc   = 0;
        ALUOp    = 4'b0000;
        Branch   = 0;
        MemRead  = 0;
        MemWrite = 0;
        MemToReg = 0;
        RegWrite = 0;
        case (opcode)
            7'b0110011: begin // R-type
                ALUSrc   = 0;
                MemToReg = 0;
                RegWrite = 1;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 0;
                case ({funct7, funct3})
                    {7'b0000000,3'b000}: ALUOp = 4'b0000; // add
                    {7'b0100000,3'b000}: ALUOp = 4'b0001; // sub
                    {7'b0000000,3'b111}: ALUOp = 4'b0010; // and
                    {7'b0000000,3'b110}: ALUOp = 4'b0011; // or
                    {7'b0000000,3'b100}: ALUOp = 4'b0100; // xor
                    {7'b0000000,3'b001}: ALUOp = 4'b0101; // sll
                    {7'b0000000,3'b101}: ALUOp = 4'b0110; // srl
                    {7'b0100000,3'b101}: ALUOp = 4'b0111; // sra
                    {7'b0000000,3'b010}: ALUOp = 4'b1000; // slt
                    default:              ALUOp = 4'b0000;
                endcase
            end
            7'b0010011: begin // I-type (addi, slti, andi, ori, xori, slli, srli, srai)
                ALUSrc   = 1;
                MemToReg = 0;
                RegWrite = 1;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 0;
                case (funct3)
                    3'b000: ALUOp = 4'b0000; // addi
                    3'b111: ALUOp = 4'b0010; // andi
                    3'b110: ALUOp = 4'b0011; // ori
                    3'b100: ALUOp = 4'b0100; // xori
                    3'b010: ALUOp = 4'b1000; // slti
                    3'b001: ALUOp = 4'b0101; // slli
                    3'b101: begin
                        if (funct7 == 7'b0000000)
                            ALUOp = 4'b0110; // srli
                        else if (funct7 == 7'b0100000)
                            ALUOp = 4'b0111; // srai
                        else
                            ALUOp = 4'b0000;
                    end
                    default: ALUOp = 4'b0000;
                endcase
            end
            7'b0000011: begin // lw
                ALUSrc   = 1;
                MemToReg = 1;
                RegWrite = 1;
                MemRead  = 1;
                MemWrite = 0;
                Branch   = 0;
                ALUOp    = 4'b0000;
            end
            7'b0100011: begin // sw
                ALUSrc   = 1;
                MemToReg = 0; // don't care
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 1;
                Branch   = 0;
                ALUOp    = 4'b0000;
            end
            7'b1100011: begin // beq, bne, ...
                ALUSrc   = 0;
                MemToReg = 0;
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 1;
                ALUOp    = 4'b0001; // sub for comparison
            end
            default: begin
                ALUSrc   = 0;
                ALUOp    = 4'b0000;
                Branch   = 0;
                MemRead  = 0;
                MemWrite = 0;
                MemToReg = 0;
                RegWrite = 0;
            end
        endcase
    end
endmodule
