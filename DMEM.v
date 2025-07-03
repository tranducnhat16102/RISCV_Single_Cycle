module DMEM(
    input clk,
    input rst_n,
    input MemRead,
    input MemWrite,
    input [31:0] addr,
    input [31:0] WriteData,
    output [31:0] ReadData,
    output [31:0] memory [0:255]
);
    reg [31:0] mem [0:255];
    integer i;
    initial for(i=0;i<256;i=i+1) mem[i]=0;
    assign ReadData = (MemRead) ? mem[addr[9:2]] : 32'b0;
    genvar idx;
    generate
        for (idx = 0; idx < 256; idx = idx + 1)
            assign memory[idx] = mem[idx];
    endgenerate
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            for (i=0;i<256;i=i+1) mem[i] <= 0;
        else if (MemWrite)
            mem[addr[9:2]] <= WriteData;
    end
endmodule
