# RISC-V Single Cycle Processor (Verilog)

**A professional, modular single-cycle RISC-V CPU implementation in Verilog. Passes all SC1 & SC2 tests on the CA_Lab-2025 automatic grading system (UET, VNU Hanoi).**

---

## 📁 File Structure

- `RISCV_Single_Cycle.v` : Top-level CPU module
- `ALU.v`                : Arithmetic Logic Unit (ALU)
- `Branch_Comp.v`        : Branch comparator
- `DMEM.v`               : Data memory (256 words)
- `IMEM.v`               : Instruction memory (256 words)
- `Imm_Gen.v`            : Immediate generator
- `RegisterFile.v`       : Register file (32 x 32-bit)
- `control_unit.v`       : Control unit

---

## 🚀 Build & Test Instructions

1. **Prepare a directory containing all the `.v` files listed above.**

2. **Ensure all required test data files are present:**
   - SC1: `./mem/imem.hex`, `./mem/dmem_init.hex`, `./mem/golden_output.txt`
   - SC2: `./mem/imem2.hex`, `./mem/dmem_init2.hex`, `./mem/golden_output2.txt`

3. **Run the test commands on the grading server:**

   ```bash
   python3 /srv/calab_grade/CA_Lab-2025/scripts/calab_grade.py sc1 ALU.v Branch_Comp.v DMEM.v IMEM.v Imm_Gen.v RISCV_Single_Cycle.v RegisterFile.v control_unit.v
   python3 /srv/calab_grade/CA_Lab-2025/scripts/calab_grade.py sc2 ALU.v Branch_Comp.v DMEM.v IMEM.v Imm_Gen.v RISCV_Single_Cycle.v RegisterFile.v control_unit.v
   ```

   **Pass criteria:**
   
   > 🎉 All memory contents match golden output! All tests passed.
   
   If there are errors/mismatches, check the detailed log at:
   
   > /tmp/grade_<tên_user>/sim.log

## 🛠️ Module Descriptions

- **ALU.v**
  - Performs arithmetic, logic, shift, and comparison operations (signed & unsigned).

- **control_unit.v**
  - Decodes opcode, funct3, funct7 to generate control signals for all blocks.
  - Supports SLT, SLTU, SLTI, SLTIU (signed/unsigned comparisons).

- **RegisterFile.v**
  - 32 registers, x0 is always zero, write enabled by RegWrite, synchronous reset.

- **Imm_Gen.v**
  - Generates and sign-extends immediate values for I/S/B/J-type instructions per RISC-V spec.

- **DMEM/IMEM.v**
  - Synchronous memories, loadable via `$readmemh` from test files.

- **Branch_Comp.v**
  - Handles branch conditions: equal, not equal, less than, greater than (signed/unsigned).

- **RISCV_Single_Cycle.v**
  - Integrates all datapath and control modules.

## 🏆 Key Features

- Full support for basic RV32I instructions (R/I/S/B-type)
- Passes all official test cases
- Modular design, easy to extend to pipeline/FPGA/SoC

---

## 📈 General Datapath

```
Instruction --> [IMEM] --> [Control + ImmGen + RegFile + ALU + DMEM] --> Result
```

---

## 📚 Extensions / Customization

- Can be extended to support JAL, JALR, LUI, AUIPC, etc.
- Suitable as a foundation for pipeline CPU, FPGA, or higher-level simulation projects.


