module RISCV_Single_Cycle(
    input clk,
    input rst_n,
    output reg [31:0] PC_out_top,
    output wire [31:0] Instruction_out_top
);
    reg [31:0] PC_next;

    // Instruction field wires
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;
    wire [6:0] opcode, funct7;

    // Immediate value
    wire [31:0] Imm;

    // Register file wires
    wire [31:0] ReadData1, ReadData2, WriteData;

    // ALU
    wire [31:0] ALU_in2, ALU_result;
    wire ALUZero;

    // Data Memory
    wire [31:0] MemReadData;

    // Control signals
    wire ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, PCSel;
    wire [3:0] ALUCtrl;

    // PC update
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            PC_out_top <= 0;
        else
            PC_out_top <= PC_next;
    end

    // Instruction Memory (KHÔNG truyền port memory!)
    IMEM IMEM_inst(
        .addr(PC_out_top),
        .Instruction(Instruction_out_top)
    );

    // Instruction field decoding
    assign opcode = Instruction_out_top[6:0];
    assign rd     = Instruction_out_top[11:7];
    assign funct3 = Instruction_out_top[14:12];
    assign rs1    = Instruction_out_top[19:15];
    assign rs2    = Instruction_out_top[24:20];
    assign funct7 = Instruction_out_top[31:25];

    // Immediate generator
    Imm_Gen imm_gen(
        .inst(Instruction_out_top),
        .imm_out(Imm)
    );

    // Register File (KHÔNG truyền port registers!)
    RegisterFile Reg_inst(
        .clk(clk),
        .rst_n(rst_n),
        .RegWrite(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // ALU input selection
    assign ALU_in2 = (ALUSrc) ? Imm : ReadData2;

    // ALU
    ALU alu(
        .A(ReadData1),
        .B(ALU_in2),
        .ALUOp(ALUCtrl),
        .Result(ALU_result),
        .Zero(ALUZero)
    );

    // Data Memory (KHÔNG truyền port memory!)
    DMEM DMEM_inst(
        .clk(clk),
        .rst_n(rst_n),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(ALU_result),
        .WriteData(ReadData2),
        .ReadData(MemReadData)
    );

    // Write-back mux
    assign WriteData = (MemToReg) ? MemReadData : ALU_result;

    // Control unit
    control_unit ctrl(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUCtrl),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite)
    );

    // Branch comparator
    Branch_Comp comp(
        .A(ReadData1),
        .B(ReadData2),
        .Branch(Branch),
        .funct3(funct3),
        .BrTaken(PCSel)
    );

    // Next PC logic (Imm đã chuẩn với B-type, J-type)
    assign PC_next = (PCSel) ? PC_out_top + Imm : PC_out_top + 4;

endmodule
