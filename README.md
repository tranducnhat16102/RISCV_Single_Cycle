# RISC-V Single Cycle Processor (Verilog)

**Đồ án bộ xử lý RISC-V 1 chu kỳ, pass toàn bộ test SC1 & SC2 trên hệ thống chấm điểm tự động CA_Lab-2025 (UET, Đại học Công nghệ).**

---

## 📁 Cấu trúc file

- `RISCV_Single_Cycle.v` : Top module CPU
- `ALU.v`                : Khối ALU (toán học, logic, shift, slt/sltu)
- `Branch_Comp.v`        : So sánh điều kiện nhánh
- `DMEM.v`               : Bộ nhớ dữ liệu (256 word)
- `IMEM.v`               : Bộ nhớ lệnh (256 word)
- `Imm_Gen.v`            : Sinh giá trị Immediate
- `RegisterFile.v`       : Bộ thanh ghi (32 x 32bit)
- `control_unit.v`       : Giải mã điều khiển

---

## 🚀 Hướng dẫn build & test

**1. Chuẩn bị thư mục chứa toàn bộ các file .v bên trên.**

**2. Đảm bảo có đủ các file dữ liệu test:**
- SC1: `./mem/imem.hex`, `./mem/dmem_init.hex`, `./mem/golden_output.txt`
- SC2: `./mem/imem2.hex`, `./mem/dmem_init2.hex`, `./mem/golden_output2.txt`

**3. Chạy lệnh test trên server:**

```bash
python3 /srv/calab_grade/CA_Lab-2025/scripts/calab_grade.py sc1 ALU.v Branch_Comp.v DMEM.v IMEM.v Imm_Gen.v RISCV_Single_Cycle.v RegisterFile.v control_unit.v
python3 /srv/calab_grade/CA_Lab-2025/scripts/calab_grade.py sc2 ALU.v Branch_Comp.v DMEM.v IMEM.v Imm_Gen.v RISCV_Single_Cycle.v RegisterFile.v control_unit.v

Kết quả Pass khi xuất hiện dòng:

🎉 All memory contents match golden output! All tests passed.

Nếu có lỗi/mismatch, kiểm tra file log chi tiết tại:

/tmp/grade_<tên_user>/sim.log

🛠️ Mô tả module
ALU.v
Thực hiện các phép cộng, trừ, and, or, xor, shift, so sánh nhỏ hơn (signed & unsigned).

control_unit.v
Giải mã opcode, funct3, funct7 → phát tín hiệu điều khiển các khối.
Mapping đủ SLT, SLTU, SLTI, SLTIU (so sánh có dấu/không dấu).

RegisterFile.v
32 thanh ghi, x0 luôn bằng 0, chỉ ghi khi RegWrite, reset đồng bộ.

Imm_Gen.v
Sinh & sign-extend giá trị Immediate theo đúng chuẩn RISC-V cho I/S/B/J-type.

DMEM/IMEM.v
Bộ nhớ đồng bộ, có thể load bằng $readmemh từ file test.

Branch_Comp.v
Xử lý điều kiện nhánh (bằng, khác, nhỏ hơn, lớn hơn - signed/unsigned).

RISCV_Single_Cycle.v
Kết nối toàn bộ datapath + control.

🏆 Đặc điểm nổi bật
Hỗ trợ đầy đủ các lệnh cơ bản RV32I (R/I/S/B-type).

Hoạt động đúng chuẩn, pass toàn bộ test trường.

Tách module chuyên nghiệp, dễ mở rộng thành pipeline/FPGA/SoC.

📈 Datapath tổng quát

Instruction -->[IMEM]-->[Control + ImmGen + RegFile + ALU + DMEM]--> Kết quả

📚 Mở rộng / Tuỳ biến

Có thể mở rộng thêm JAL, JALR, LUI, AUIPC nếu cần.

Có thể dùng làm nền tảng cho project CPU pipeline, FPGA, mô phỏng cao hơn.

