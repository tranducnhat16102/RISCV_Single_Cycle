module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0]  ALUOp,
    output reg [31:0] Result,
    output Zero
);
    always @* begin
        case (ALUOp)
            4'b0000: Result = A + B;    // ADD, ADDI, LW, SW
            4'b0001: Result = A - B;    // SUB, Branch
            4'b0010: Result = A & B;    // AND, ANDI
            4'b0011: Result = A | B;    // OR, ORI
            4'b0100: Result = A ^ B;    // XOR, XORI
            4'b0101: Result = A << B[4:0]; // SLL, SLLI
            4'b0110: Result = A >> B[4:0]; // SRL, SRLI
            4'b0111: Result = $signed(A) >>> B[4:0]; // SRA, SRAI
            4'b1000: Result = ($signed(A) < $signed(B)) ? 1 : 0; // SLT, SLTI
            4'b1001: Result = (A < B) ? 1 : 0;                   // SLTU, SLTIU
            default: Result = 0;
        endcase
    end
    assign Zero = (Result == 0);
endmodule
