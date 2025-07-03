module DMEM(
    input clk,
    input rst_n,
    input MemRead,
    input MemWrite,
    input [31:0] addr,
    input [31:0] WriteData,
    output [31:0] ReadData
);
    reg [31:0] memory [0:255];
    integer i;

    // Khởi tạo dữ liệu bộ nhớ
    initial
        for (i = 0; i < 256; i = i + 1) memory[i] = 0;

    assign ReadData = (MemRead) ? memory[addr[9:2]] : 32'b0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            for (i = 0; i < 256; i = i + 1) memory[i] <= 0;
        else if (MemWrite)
            memory[addr[9:2]] <= WriteData;
    end
endmodule
