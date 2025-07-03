module DMEM(
    input  logic clk,
    input  logic rst_n,
    input  logic MemRead,
    input  logic MemWrite,
    input  logic [31:0] addr,
    input  logic [31:0] WriteData,
    output logic [31:0] ReadData,
    output logic [31:0] memory [0:255] // expose cho TB
);
    logic [31:0] mem [0:255];
    assign memory = mem;
    assign ReadData = (MemRead) ? mem[addr[9:2]] : 32'b0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            for (int i=0; i<256; i++) mem[i] <= 0;
        else if (MemWrite)
            mem[addr[9:2]] <= WriteData;
    end
endmodule
