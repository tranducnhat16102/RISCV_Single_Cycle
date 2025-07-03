module IMEM(
    input [31:0] addr,
    output [31:0] Instruction
);
    reg [31:0] memory [0:255];
    integer i;

    // Khởi tạo bộ nhớ lệnh
    initial
        for (i = 0; i < 256; i = i + 1) memory[i] = 0;

    assign Instruction = memory[addr[11:2]];
endmodule
