module IMEM(
    input [31:0] addr,
    output [31:0] Instruction,
    output [31:0] memory [0:255]
);
    reg [31:0] mem [0:255];
    integer i;
    initial for(i=0;i<256;i=i+1) mem[i]=0;
    assign Instruction = mem[addr[11:2]];
    genvar idx;
    generate
        for (idx = 0; idx < 256; idx = idx + 1)
            assign memory[idx] = mem[idx];
    endgenerate
endmodule
