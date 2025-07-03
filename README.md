# RISC-V Single Cycle CPU - Lab Project

## 1. Mục tiêu

- Thiết kế và mô phỏng bộ xử lý **RISC-V Single Cycle** có thể chạy **testbench tự động** (`tb_RISCV_sc2`) kiểm tra thanh ghi, PC và bộ nhớ qua từng chu kỳ.
- Chuẩn theo bài Lab kiến trúc máy tính/RISC-V cơ bản.

## 2. Cấu trúc file

.
├── RISCV_Single_Cycle.sv # Top-level CPU
├── RegisterFile.sv # Thanh ghi
├── DMEM.sv # Bộ nhớ dữ liệu
├── IMEM.sv # Bộ nhớ lệnh
├── Imm_Gen.sv # Sinh tức thì
├── ALU.sv # Khối tính toán
├── control_unit.sv # Giải mã điều khiển
├── Branch_Comp.sv # So sánh nhánh
├── mem/ # Thư mục chứa file hex (imem2.hex, dmem_init2.hex, ...)
└── README.md # File này

shell
Sao chép
Chỉnh sửa

## 3. Cách biên dịch & mô phỏng

**Ví dụ với ModelSim hoặc Icarus/Verilator:**

```bash
# ModelSim (SystemVerilog)
vlog *.sv
vsim tb_RISCV_sc2

# Icarus Verilog (nếu không dùng output array)
iverilog -g2012 *.sv tb_RISCV_sc2.sv -o cpu_tb
vvp cpu_tb
Chú ý:

Testbench tự động sẽ gọi $readmemh để load file imem2.hex và dmem_init2.hex vào IMEM và DMEM.

Kiểm tra kết quả bằng so sánh với file golden_output2.txt.

4. Giải thích kết nối & interface
RISCV_Single_Cycle là module top, chỉ nhận clk, rst_n, xuất ra PC_out_top, Instruction_out_top.

Các module con phải có instance đúng tên:

Reg_inst (register file), xuất ra registers [0:31]

DMEM_inst (data memory), xuất ra memory [0:255]

IMEM_inst (instruction memory), xuất ra memory [0:255]

Các array này để testbench truy cập kiểm tra giá trị qua từng chu kỳ.

Luồng dữ liệu cơ bản:
PC lấy lệnh từ IMEM.

Giải mã trường rs1, rs2, rd, các immediate.

Đọc giá trị từ RegisterFile.

ALU thực thi phép toán.

Truy cập DMEM nếu là lệnh load/store.

Kết quả ghi lại RegisterFile.

Cập nhật PC (PC+4 hoặc PC+imm nếu nhánh/jump).

5. Giải thích các module
IMEM/DMEM:

Mảng 256 ô, 32-bit, truy cập word-address.

Testbench load dữ liệu bằng $readmemh.

RegisterFile:

32 thanh ghi x0-x31, x0 luôn bằng 0.

Imm_Gen:

Sinh immediate theo loại lệnh (I, S, B, J).

ALU:

Thực hiện các phép toán số học và logic.

control_unit:

Giải mã opcode, funct3, funct7 ra control signals.

Branch_Comp:

So sánh nhánh, quyết định update PC.

6. Câu lệnh kiểm tra kết quả
Nếu chạy đúng, testbench sẽ báo:

sql
Sao chép
Chỉnh sửa
🎉 All memory contents match golden output! All tests passed.
Nếu sai:

sql
Sao chép
Chỉnh sửa
❗ PC mismatch at cycle X: DUT = ..., Golden = ...
❗ xY mismatch at cycle X: DUT = ..., Golden = ...
❗ Dmem[Z] mismatch at cycle X: DUT = ..., Golden = ...
7. Ghi chú mở rộng
Code template đã hỗ trợ lệnh cơ bản (add, sub, and, or, lw, sw, beq, bne, slt...).

Có thể mở rộng thêm lệnh nếu test yêu cầu.

Nếu dùng Icarus hoặc Verilator gặp lỗi với output array, cần sửa lại interface thành từng phần tử hoặc dùng generate.