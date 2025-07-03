module RegisterFile(
    input  logic clk,
    input  logic rst_n,
    input  logic RegWrite,
    input  logic [4:0] rs1,
    input  logic [4:0] rs2,
    input  logic [4:0] rd,
    input  logic [31:0] WriteData,
    output logic [31:0] ReadData1,
    output logic [31:0] ReadData2,
    output logic [31:0] registers [0:31] // expose cho TB
);
    logic [31:0] reg_array [0:31];
    assign registers = reg_array;
    assign ReadData1 = reg_array[rs1];
    assign ReadData2 = reg_array[rs2];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            for (int i=0; i<32; i++) reg_array[i] <= 0;
        else if (RegWrite && (rd != 0))
            reg_array[rd] <= WriteData;
    end
endmodule
