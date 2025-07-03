module IMEM(
    input  logic [31:0] addr,
    output logic [31:0] Instruction,
    output logic [31:0] memory [0:255] // expose cho TB
);
    logic [31:0] mem [0:255];
    assign memory = mem; // SystemVerilog: xuất ra cho TB
    assign Instruction = mem[addr[11:2]];
    // Để testbench dùng $readmemh vào memory

    // Optionally, add initial block to clear mem
    // initial for(int i=0;i<256;i++) mem[i]=0;
endmodule
