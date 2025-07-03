module RegisterFile(
    input clk,
    input rst_n,
    input RegWrite,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);
    reg [31:0] reg_array [0:31];
    integer i;

    assign ReadData1 = reg_array[rs1];
    assign ReadData2 = reg_array[rs2];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            for (i = 0; i < 32; i = i + 1) reg_array[i] <= 0;
        else if (RegWrite && (rd != 0))
            reg_array[rd] <= WriteData;
    end
endmodule
