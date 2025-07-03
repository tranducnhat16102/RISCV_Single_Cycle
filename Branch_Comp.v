module Branch_Comp(
    input [31:0] A,
    input [31:0] B,
    input Branch,
    input [2:0] funct3,
    output reg BrTaken
);
    always @* begin
        if (!Branch) BrTaken = 0;
        else case (funct3)
            3'b000: BrTaken = (A == B); // beq
            3'b001: BrTaken = (A != B); // bne
            3'b100: BrTaken = ($signed(A) < $signed(B)); // blt
            3'b101: BrTaken = ($signed(A) >= $signed(B)); // bge
            default: BrTaken = 0;
        endcase
    end
endmodule
