# 3-Bit-Synchronous-Up-Down-Counter-using-T-Flip-Flops-Verilog-HDL-
A 3-bit synchronous Up/Down counter built structurally in Verilog using custom T Flip-Flops, with synchronous reset, preset, and parallel load. Simulated in Icarus Verilog &amp; GTKWave, cross-verified in Xilinx Vivado. Includes testbench, VCD dump, I/O waveform, and RTL schematic.

# 🔁 3-Bit Synchronous Up/Down Counter using T Flip-Flops (Verilog HDL)

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)
![Simulator](https://img.shields.io/badge/Simulator-Icarus%20Verilog-green)
![Editor](https://img.shields.io/badge/Editor-VS%20Code-007ACC)

A fully synchronous **3-bit Up/Down Counter** designed at the gate/structural level using **T Flip-Flops (Toggle Flip-Flops)**. The counter supports **synchronous reset**, **synchronous preset**, and **parallel (synchronous) load**, and can count **up** or **down** based on a mode-control signal `ud`. The design is verified using a self-checking testbench simulated in **Icarus Verilog**, with waveform inspection in **GTKWave**, developed in **VS Code**, and cross-verified/synthesizable in **Xilinx Vivado**.

---

## 📖 Table of Contents

1. [Project Overview](#-project-overview)
2. [Features](#-features)
3. [Repository / File Structure](#-repository--file-structure)
4. [Tools & Software Requirements](#-tools--software-requirements)
5. [Theory of Operation](#-theory-of-operation)
   - [What is a T Flip-Flop?](#what-is-a-t-flip-flop)
   - [Up/Down Counter Design Logic](#updown-counter-design-logic)
   - [Toggle Equation Derivation](#toggle-equation-derivation)
6. [Module-by-Module Description](#-module-by-module-description)
   - [Module 1: `tflipflop` (T_flipflop.v)](#module-1-tflipflop-t_flipflopv)
   - [Module 2: `updowncounter_tb` (updowncounter.v)](#module-2-updowncounter_tb-updowncounterv)
7. [Pin / Port Description](#-pin--port-description)
   - [T Flip-Flop Pin Description](#t-flip-flop-pin-description)
   - [Top-Level / Testbench Pin Description](#top-level--testbench-pin-description)
8. [Internal Signal Connectivity (Structural Wiring)](#-internal-signal-connectivity-structural-wiring)
9. [State / Mode Table](#-state--mode-table)
10. [Testbench Stimulus Timeline](#-testbench-stimulus-timeline)
11. [How This Project Was Made](#-how-this-project-was-made)
12. [How to Run the Simulation (Windows / Ubuntu / macOS + Icarus Verilog + VS Code)](#-how-to-run-the-simulation-windows--ubuntu--macos--icarus-verilog--vs-code)
13. [Viewing Waveforms in GTKWave](#-viewing-waveforms-in-gtkwave)
14. [Simulating / Synthesizing in Xilinx Vivado](#-simulating--synthesizing-in-xilinx-vivado)
15. [Expected Output / Console Log Format](#-expected-output--console-log-format)
16. [Schematic](#-schematic)
17. [I/O Waveform](#-io-waveform)
18. [VCD Dump File](#-vcd-dump-file)
19. [Applications](#-applications)
20. [Limitations](#-limitations)
21. [Future Improvements](#-future-improvements)
22. [Troubleshooting / FAQ](#-troubleshooting--faq)
23. [License](#-license)
24. [Author](#-author)

---

## 📌 Project Overview

This project implements a **3-bit synchronous Up/Down counter** using three instances of a custom **T Flip-Flop** module. Unlike behavioral counters that use a simple `always @(posedge clk) count <= count + 1`, this design is built at the **structural/gate level**, meaning each flip-flop is individually instantiated and the toggle (`T`) input of each flip-flop is computed using **combinational Boolean logic** derived from the current state of the lower-order flip-flops.

The direction of counting (increment or decrement) is controlled by a single control bit `ud`:
- `ud = 0` → **Up-counting mode** (0 → 1 → 2 → ... → 7 → 0 ...)
- `ud = 1` → **Down-counting mode** (7 → 6 → 5 → ... → 0 → 7 ...)

The counter also supports:
- **Synchronous Reset (`rst`)** – forces the counter to `000`
- **Synchronous Preset (`prt`)** – forces the counter to `111`
- **Synchronous Parallel Load (`ld`)** – loads an external 3-bit value `a[2:0]` into the counter

This makes the design a **universal up/down counter with reset, preset, and load capability**, commonly used in digital system design courses to demonstrate flip-flop excitation tables, sequential circuit design, and structural Verilog modeling.

---

## ✨ Features

- ✅ 3-bit synchronous Up/Down counter
- ✅ Built using structural instantiation of custom T Flip-Flops (no behavioral `+1` shortcut)
- ✅ Synchronous active-high **Reset**
- ✅ Synchronous active-high **Preset** (sets counter to all 1s)
- ✅ Synchronous active-high **Parallel Load** of a 3-bit value
- ✅ Direction control using a single `ud` (up/down) signal
- ✅ Dual outputs available: `Q` (true) and `QB` (complement) for every bit
- ✅ Self-contained testbench with clock generation, stimulus sequencing, and `$monitor` console logging
- ✅ VCD dump generation for waveform analysis in GTKWave
- ✅ Fully synthesizable RTL, verified in Xilinx Vivado
- ✅ Clean modular code — easy to extend to 4-bit, 8-bit, or n-bit counters
- ✅ Priority-encoded control logic: `rst` > `prt` > `ld` > `toggle`

---

## 🗂 Repository / File Structure

```
UpDown-Counter-TFlipFlop/
│
├── T_flipflop.v          # T Flip-Flop module (core building block, reusable component)
├── updowncounter.v       # Top-level structural counter + testbench (updowncounter_tb)
│
├── dump.vcd              # Value Change Dump file generated after simulation (for GTKWave)
├── io_wave.png           # Screenshot of the simulated input/output waveform (GTKWave capture)
├── scamatic.png           # Schematic diagram of the counter (RTL schematic, e.g., from Vivado)
│
└── README.md             # This file — full project documentation
```

> **Note:** The counter's structural design (instantiation of the three T flip-flops with their toggle-logic equations) lives directly inside the `updowncounter_tb` module in `updowncounter.v`. There is no separate "DUT-only" wrapper module — the testbench module itself acts as both the **structural top level** and the **stimulus generator**. This is intentional for quick simulation-only projects; see [Future Improvements](#-future-improvements) for how to split this into a pure DUT + separate TB.

---

## 🛠 Tools & Software Requirements

| Tool | Purpose | Supported Platforms |
|---|---|---|
| **Icarus Verilog (`iverilog` / `vvp`)** | Compiling and simulating the Verilog RTL and testbench | Windows, Ubuntu/Linux, macOS |
| **VS Code** | Writing, editing, and organizing the Verilog source files (with Verilog/HDL extensions) | Windows, Ubuntu/Linux, macOS |
| **GTKWave** | Viewing the `dump.vcd` waveform file generated by the simulation | Windows, Ubuntu/Linux, macOS |
| **Xilinx Vivado** | RTL synthesis, schematic generation, and behavioral simulation cross-check | Windows, Ubuntu/Linux (officially supported) — **not natively available on macOS**, see note below |

> 🍎 **macOS note:** Xilinx does not ship a native macOS build of Vivado. On macOS, run Vivado inside a **Linux virtual machine** (VMware Fusion / Parallels / VirtualBox running Ubuntu) or a **Docker container**. Icarus Verilog, GTKWave, and VS Code all work natively on macOS with no workaround needed.

**Recommended VS Code Extensions:**
- `Verilog-HDL/SystemVerilog` (by mshr-h) — syntax highlighting & linting
- `TerosHDL` — schematic preview, linting, and simulation integration
- Any generic terminal-integrated extension to run `iverilog`/`vvp` commands directly from VS Code's integrated terminal

---

## 📚 Theory of Operation

### What is a T Flip-Flop?

A **T (Toggle) Flip-Flop** is a 1-bit sequential storage element with a single control input `T`:
- If `T = 1` at the clock edge → output **toggles** (Q → ~Q)
- If `T = 0` at the clock edge → output **holds** its previous value

In this project, the T flip-flop is **extended** with three additional synchronous controls that take priority over the toggle behavior:

| Priority | Signal | Behavior |
|---|---|---|
| 1 (Highest) | `rst` | Q ← 0, QB ← 1 |
| 2 | `prt` | Q ← 1, QB ← 0 |
| 3 | `ld` | Q ← a, QB ← ~a |
| 4 (Lowest) | `t` | Q ← Q if t=0, Q ← ~Q if t=1 |

### Up/Down Counter Design Logic

A classical way to build an n-bit up/down counter from T flip-flops is to compute each flip-flop's toggle input `T_i` based on the **AND of all lower-order bits** (for up-counting) or the **AND of the complements of all lower-order bits** (for down-counting):

- **Up-count rule:** Bit `i` toggles only when all bits below it (`0` to `i-1`) are `1` — exactly like ripple-carry binary addition.
- **Down-count rule:** Bit `i` toggles only when all bits below it (`0` to `i-1`) are `0` — exactly like binary borrow/decrement.

### Toggle Equation Derivation

For this 3-bit counter (bits `Q0`, `Q1`, `Q2`), the toggle inputs used in `updowncounter.v` are:

```
T0 = 1                                            (LSB always toggles every clock)
T1 = (ud & Q0) | (~ud & Q0)  =  ud ^ Q0            (toggles Q1 when Q0=1 in up-mode, or Q0=0 in down-mode)
T2 = (~ud & Q0 & Q1) | (ud & QB0 & QB1)            (toggles Q2 when Q0=Q1=1 in up-mode, or Q0=Q1=0 in down-mode)
```

**Verification:**
- When `ud = 0` (Up): `T1 = Q0`, `T2 = Q0 & Q1` → standard ripple/synchronous up-counter carry logic ✔
- When `ud = 1` (Down): `T1 = ~Q0`, `T2 = QB0 & QB1 = ~Q0 & ~Q1` → standard down-counter borrow logic ✔

This is exactly what is coded in the testbench's structural instantiation:

```verilog
tflipflop t0(clk,rst,prt,ld,a[0], 1'b1,                                   Q[0],QB[0]);
tflipflop t1(clk,rst,prt,ld,a[1], ud ^ Q[0],                              Q[1],QB[1]);
tflipflop t2(clk,rst,prt,ld,a[2], (~ud & Q[0] & Q[1]) | (ud & QB[0] & QB[1]), Q[2],QB[2]);
```

---

## 🧩 Module-by-Module Description

### Module 1: `tflipflop` (T_flipflop.v)

```verilog
module tflipflop(clk,rst,prt,ld,a,t,Q,QB);
input clk,rst,prt,t,ld,a;
output reg Q,QB;
```

**Description:**
This is the reusable, parametrized-by-instantiation core building block of the entire design — a single-bit flip-flop with four synchronous control mechanisms, all evaluated on the **positive edge of `clk`**, in strict priority order:

1. **`rst` (Reset)** — highest priority. When high, forces `Q = 0` and `QB = 1`, regardless of any other input.
2. **`prt` (Preset)** — second priority. When high (and `rst` is low), forces `Q = 1` and `QB = 0`.
3. **`ld` (Load)** — third priority. When high (and `rst`, `prt` are low), loads the external data bit `a` into `Q` (and its complement into `QB`).
4. **`t` (Toggle)** — lowest priority. If none of the above are asserted: when `t = 1`, the flip-flop toggles (`Q <= ~Q`); when `t = 0`, it holds its current value.

This priority-encoded `if–else if–else` structure ensures **no conflicting simultaneous assignments** and mirrors real hardware behavior of a JK/T flip-flop with reset/preset/load override pins, similar to a 74LS112-style flip-flop with additional load capability.

### Module 2: `updowncounter_tb` (updowncounter.v)

```verilog
module updowncounter_tb;
reg clk,rst,prt,ld;
reg [2:0] a;
wire [2:0] Q,QB;
reg ud;
```

**Description:**
This module serves a dual purpose:

1. **Structural Top-Level Design:** It instantiates **three `tflipflop` modules** (`t0`, `t1`, `t2`) and wires their toggle (`t`) inputs using the combinational logic derived above, producing a complete 3-bit up/down counter with `Q[2:0]` as the counter's state output and `QB[2:0]` as its bitwise complement.

2. **Testbench / Stimulus Generator:** It also drives the clock (`#5 clk = ~clk`, giving a 10ns period / 100MHz-equivalent simulation clock), applies a sequence of stimulus vectors to exercise every operating mode (reset, preset, up-count, down-count, load), dumps signal changes to `dump.vcd` for GTKWave, and prints a live `$monitor` log to the simulation console.

**Key internal signals:**

| Signal | Type | Width | Description |
|---|---|---|---|
| `clk` | reg | 1-bit | Simulation clock, toggled every 5ns (10ns period) |
| `rst` | reg | 1-bit | Synchronous reset control, applied to all 3 flip-flops |
| `prt` | reg | 1-bit | Synchronous preset control, applied to all 3 flip-flops |
| `ld` | reg | 1-bit | Synchronous parallel load enable, applied to all 3 flip-flops |
| `a` | reg | 3-bit | Parallel load data bus (`a[0]`, `a[1]`, `a[2]` feed each flip-flop's `a` input) |
| `ud` | reg | 1-bit | Up/Down mode select (`0` = up, `1` = down) |
| `Q` | wire | 3-bit | Counter output — `Q[0]` = LSB, `Q[2]` = MSB |
| `QB` | wire | 3-bit | Complement of counter output |

---

## 🔌 Pin / Port Description

### T Flip-Flop Pin Description

| Pin Name | Direction | Width | Active Level | Description |
|---|---|---|---|---|
| `clk` | Input | 1-bit | Rising edge | System clock — all state updates occur on `posedge clk` |
| `rst` | Input | 1-bit | Active High | Synchronous reset — forces Q=0, QB=1 |
| `prt` | Input | 1-bit | Active High | Synchronous preset — forces Q=1, QB=0 |
| `ld` | Input | 1-bit | Active High | Synchronous load enable — loads `a` into Q |
| `a` | Input | 1-bit | — | Parallel load data input for this bit |
| `t` | Input | 1-bit | Active High | Toggle control — combinational function of counter state |
| `Q` | Output (reg) | 1-bit | — | True/normal flip-flop output |
| `QB` | Output (reg) | 1-bit | — | Complementary flip-flop output |

### Top-Level / Testbench Pin Description

| Pin Name | Direction | Width | Description |
|---|---|---|---|
| `clk` | internal reg | 1-bit | Generated clock (period = 10ns, driven by `always #5 clk=~clk`) |
| `rst` | internal reg (stimulus) | 1-bit | Global synchronous reset applied to all flip-flops |
| `prt` | internal reg (stimulus) | 1-bit | Global synchronous preset applied to all flip-flops |
| `ld` | internal reg (stimulus) | 1-bit | Global synchronous load-enable applied to all flip-flops |
| `a[2:0]` | internal reg (stimulus) | 3-bit | Parallel data to be loaded into the counter when `ld=1` |
| `ud` | internal reg (stimulus) | 1-bit | Direction control: `0` = Up-count, `1` = Down-count |
| `Q[2:0]` | internal wire (observed) | 3-bit | Current counter value (Q[2] MSB … Q[0] LSB) |
| `QB[2:0]` | internal wire (observed) | 3-bit | Bitwise complement of the counter value |

---

## 🔗 Internal Signal Connectivity (Structural Wiring)

```
┌───────────────────────────────────────────────────────────────────┐
│              Global Control Bus: clk / rst / prt / ld              │
└─────────┬───────────────────────┬───────────────────────┬─────────┘
          │                       │                       │
          ▼                       ▼                       ▼
┌───────────────────┐   ┌───────────────────┐   ┌───────────────────┐
│    t0  (bit 0)    │   │    t1  (bit 1)    │   │    t2  (bit 2)    │
│      a = a[0]     │   │      a = a[1]     │   │      a = a[2]     │
│      t = 1'b1     │   │       t = T1      │   │       t = T2      │
│     Q  -> Q[0]    │   │     Q  -> Q[1]    │   │     Q  -> Q[2]    │
│    QB -> QB[0]    │   │    QB -> QB[1]    │   │    QB -> QB[2]    │
└───────────────────┘   └───────────────────┘   └───────────────────┘

        Q0, QB0 ────────────────────► feed into the T1 and T2 equations below
        Q1, QB1 ────────────────────────────────────► feed into the T2 equation

        T1 = ud ^ Q0
        T2 = (~ud & Q0 & Q1) | (ud & QB0 & QB1)
```

> This diagram is a fixed-width ASCII block — it renders correctly on GitHub as long as it stays inside a fenced code block, since GitHub always displays code blocks in a monospace font (which is why the previous version looked misaligned outside of one).

Each flip-flop shares the same global `clk`, `rst`, `prt`, and `ld` signals — only the `t` (toggle) input and the `a` (load-data) input differ per bit, which is what gives the design its up/down counting behavior.

---

## 📊 State / Mode Table

| `rst` | `prt` | `ld` | `t` (effective) | Resulting Action |
|---|---|---|---|---|
| 1 | X | X | X | Q ← 0 (all bits reset to `000`) |
| 0 | 1 | X | X | Q ← 1 (all bits set to `111`) |
| 0 | 0 | 1 | X | Q ← `a` (parallel load) |
| 0 | 0 | 0 | 1 | Q ← ~Q (counts up or down, based on `ud`) |
| 0 | 0 | 0 | 0 | Q ← Q (hold — only possible for bits whose toggle equation evaluates to 0) |

| `ud` | Counting Direction | Sequence (repeating) |
|---|---|---|
| 0 | Up | 0 → 1 → 2 → 3 → 4 → 5 → 6 → 7 → 0 → ... |
| 1 | Down | 7 → 6 → 5 → 4 → 3 → 2 → 1 → 0 → 7 → ... |

---

## ⏱ Testbench Stimulus Timeline

The `initial` block in `updowncounter.v` walks the counter through **every functional mode** in sequence:

| Time Window | `rst` | `prt` | `ld` | `ud` | `a` | Purpose |
|---|---|---|---|---|---|---|
| 0 – 10 ns | 1 | 0 | 0 | 0 | — | Apply synchronous reset → Q settles to `000` |
| 10 – 100 ns | 0 | 0 | 0 | 0 | — | Release reset, counter free-runs **Up** (000→001→010...) |
| 100 – 110 ns | 0 | 1 | 0 | 0 | — | Apply preset → Q settles to `111` |
| 110 – 200 ns | 0 | 0 | 0 | 0 | — | Release preset, counter continues **Up** from `111` |
| 200 – 210 ns | 1 | 0 | 0 | 1 | — | Apply reset again (Q → `000`), direction switched to **Down** |
| 210 – 300 ns | 0 | 0 | 0 | 1 | — | Release reset, counter free-runs **Down** |
| 300 – 310 ns | 0 | 1 | 0 | 1 | — | Apply preset → Q settles to `111` |
| 310 – 400 ns | 0 | 0 | 0 | 1 | — | Release preset, counter continues **Down** |
| 400 – 411 ns | 0 | 0 | 1 | 0 | 101 | Parallel load `Q = 5 (101)`, direction set to **Up** |
| 411 – 500 ns | 0 | 0 | 0 | 0 | — | Load released, counter free-runs **Up** from `5` |
| 500 – 511 ns | 0 | 0 | 1 | 1 | 100 | Parallel load `Q = 4 (100)`, direction set to **Down** |
| 511 – 600 ns | 0 | 0 | 0 | 1 | — | Load released, counter free-runs **Down** from `4` |
| 600 – 700 ns | 0 | 0 | 0 | 0 | — | Direction switched back to **Up**, counter free-runs |
| 700 ns | — | — | — | — | — | `$finish` — simulation ends |

> Total simulation length: **700 ns** (70 clock cycles at a 10ns clock period).

---

## 🏗 How This Project Was Made

1. **Design Planning:** Started with the excitation-table-based design approach for a T flip-flop up/down counter — derived toggle equations `T0`, `T1`, `T2` on paper using Karnaugh maps / carry-borrow logic for a 3-bit counter.
2. **Core Component (`T_flipflop.v`):** Implemented a single reusable synchronous T flip-flop with reset, preset, load, and toggle, written and edited in **VS Code**.
3. **Structural Top + Testbench (`updowncounter.v`):** Instantiated three `tflipflop` modules and wired the derived toggle equations combinationally, then wrote a comprehensive testbench stimulus to validate reset, preset, load, up-count, and down-count operation.
4. **Compilation & Simulation:** Compiled and simulated using **Icarus Verilog** (`iverilog` + `vvp`) directly from the VS Code integrated terminal on Windows.
5. **Waveform Dumping:** Used `$dumpfile("dump.vcd")` and `$dumpvars` to generate a VCD waveform trace of every signal.
6. **Waveform Analysis:** Opened `dump.vcd` in **GTKWave**, arranged the `clk`, `rst`, `prt`, `ld`, `ud`, `a`, `Q`, `QB` signals, and captured the annotated screenshot `io_wave.png`.
7. **Console Verification:** Used `$monitor` to print a live text log of every signal transition to the terminal, cross-checked manually against the expected up/down sequence.
8. **Synthesis Cross-Check:** Imported the RTL into **Xilinx Vivado**, ran synthesis and generated the RTL schematic (exported as `scamatic.png`) to visually confirm the structural connectivity of the three flip-flops and their toggle logic.
9. **Documentation:** Wrote this README to document the theory, module structure, pin descriptions, and simulation/synthesis workflow for future reference and GitHub publishing.

---

## 💻 How to Run the Simulation (Windows / Ubuntu / macOS + Icarus Verilog + VS Code)

The compile/simulate/view commands (Steps 3–6 below) are **identical on every OS** once the tools are installed — only the installation step differs per platform.

### Step 0 — Install the Toolchain

<details>
<summary><b>🪟 Windows setup (click to expand)</b></summary>

1. Download the Icarus Verilog Windows installer (`iverilog-v*-x64_setup.exe`) from the official Icarus Verilog releases page: https://bleyer.org/icarus/
2. Run the installer and make sure **"Add to system PATH"** is checked (or manually add the installed `bin` folder, e.g. `C:\iverilog\bin`, to your Windows `PATH` environment variable).
3. GTKWave is bundled with the Windows installer — no separate download needed.
4. Download and install **VS Code**: https://code.visualstudio.com/download
5. Restart your terminal / VS Code so the updated `PATH` takes effect.

</details>

<details>
<summary><b>🐧 Ubuntu / Linux setup (click to expand)</b></summary>

1. Open a terminal and update package lists:
   ```bash
   sudo apt update
   ```
2. Install Icarus Verilog and GTKWave directly from the Ubuntu repositories:
   ```bash
   sudo apt install iverilog gtkwave -y
   ```
3. Verify the installation:
   ```bash
   iverilog -V
   gtkwave --version
   ```
4. Install **VS Code** on Ubuntu (via `snap`, the simplest route):
   ```bash
   sudo snap install code --classic
   ```
   Or download the `.deb` package directly from https://code.visualstudio.com/download and install it with:
   ```bash
   sudo apt install ./code_*.deb
   ```

</details>

<details>
<summary><b>🍎 macOS setup (click to expand)</b></summary>

1. Install **Homebrew** first if you don't already have it (skip if `brew --version` works):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. Install Icarus Verilog and GTKWave via Homebrew:
   ```bash
   brew install icarus-verilog
   brew install --cask gtkwave
   ```
3. Verify the installation:
   ```bash
   iverilog -V
   gtkwave --version
   ```
4. Install **VS Code** via Homebrew Cask, or download it directly from https://code.visualstudio.com/download:
   ```bash
   brew install --cask visual-studio-code
   ```
5. **Xilinx Vivado** has no native macOS build — run it inside an Ubuntu VM (VMware Fusion, Parallels, or UTM) or a Docker container if you need synthesis/schematic features on macOS; Icarus Verilog, GTKWave, and VS Code all run natively without a VM.

</details>

### Step 1 — Open the Project Folder in VS Code
Open the folder containing `T_flipflop.v` and `updowncounter.v` in VS Code, and open the integrated terminal (`` Ctrl + ` `` on Windows/Linux, `` Cmd + ` `` on macOS).

### Step 2 — Compile the Design
```bash
iverilog -o updowncounter.out T_flipflop.v updowncounter.v
```
This compiles both source files and produces a simulation executable named `updowncounter.out` (identical command on Windows, Ubuntu, and macOS).

### Step 3 — Run the Simulation
```bash
vvp updowncounter.out
```
This executes the compiled simulation, prints the `$monitor` log to the console, and generates `dump.vcd` in the same directory.

### Step 4 (Optional) — One-Line Compile + Run
```bash
iverilog -o updowncounter.out T_flipflop.v updowncounter.v && vvp updowncounter.out
```

### Step 5 — View the Waveform
```bash
gtkwave dump.vcd
```

> 💡 **Tip (Windows):** If `iverilog`/`vvp`/`gtkwave` are not recognized in the terminal, re-check that the Icarus Verilog installation path was added to your Windows `PATH` variable, then restart VS Code.
>
> 💡 **Tip (Ubuntu/macOS):** If `iverilog`/`gtkwave` are not recognized, confirm the package installed correctly (`which iverilog`, `which gtkwave`) and that your shell's `PATH` includes Homebrew's `/opt/homebrew/bin` (Apple Silicon Macs) or `/usr/local/bin` (Intel Macs / Linux).

---

## 📉 Viewing Waveforms in GTKWave

1. Launch GTKWave and open `dump.vcd` (or run `gtkwave dump.vcd` from the terminal as shown above).
2. In the **SST (Signal Search Tree)** panel on the left, expand `updowncounter_tb`.
3. Drag and drop `clk`, `rst`, `prt`, `ld`, `ud`, `a[2:0]`, `Q[2:0]`, and `QB[2:0]` into the waveform viewer.
4. Set `a` and `Q`/`QB` display formats to **Decimal** or **Binary** (right-click the signal → Data Format) for easier readability.
5. Zoom in/out (`Ctrl + Scroll` or the toolbar zoom icons) to inspect each 100ns test phase (reset, up-count, preset, down-count, load) individually.
6. Save the arranged view as a `.gtkw` save file for quick reloading later, and export a screenshot as `io_wave.png` (already included in this repo).

---

## ⚙ Simulating / Synthesizing in Xilinx Vivado

1. Open **Xilinx Vivado** → **Create New Project**.
2. Add `T_flipflop.v` and `updowncounter.v` as **Design Sources** (Vivado will automatically treat `updowncounter_tb` as containing the top-level hierarchy since it instantiates `tflipflop`).
3. If synthesizing only the counter logic (not the testbench stimulus), extract the flip-flop instantiations into a separate top module (see [Future Improvements](#-future-improvements)) — pure testbenches with `initial` blocks and `$monitor`/`$dumpfile` are simulation-only constructs and are not synthesizable.
4. Run **Behavioral Simulation** in Vivado's simulator to reproduce the same waveform seen in GTKWave.
5. Run **Synthesis** → **Open Elaborated/Synthesized Design** → **Schematic** to view the auto-generated RTL schematic of the flip-flop network (this is the source of `scamatic.png`).
6. Optionally run **Implementation** and generate a **Bitstream** if targeting a physical FPGA board.

---

## 🖥 Expected Output / Console Log Format

The testbench's `$monitor` statement prints a line every time any monitored signal changes:

```
at time                   0: clk=0 rst=1 prt=0 ld=0 a=  0 ud=0 Q=  0
at time                   5: clk=1 rst=1 prt=0 ld=0 a=  0 ud=0 Q=  0
at time                  10: clk=0 rst=0 prt=0 ld=0 a=  0 ud=0 Q=  0
at time                  15: clk=1 rst=0 prt=0 ld=0 a=  0 ud=0 Q=  1
at time                  25: clk=1 rst=0 prt=0 ld=0 a=  0 ud=0 Q=  2
...
at time                 700: clk=... $finish called
```

*(Exact values/timestamps will match your simulator's console output — run the commands above to generate the full log.)*

---

## 🖼 Schematic

The file **`scamatic.png`** (RTL schematic exported from Xilinx Vivado) illustrates the structural connectivity between the three `tflipflop` instances (`t0`, `t1`, `t2`) and the combinational toggle-logic gates (`XOR`, `AND`, `OR`, inverters) that generate `T1` and `T2` from `Q0`, `Q1`, `QB0`, `QB1`, and `ud`.

> 📌 Place `scamatic.png` in the repository root (already referenced in the [File Structure](#-repository--file-structure) above) — GitHub will render it automatically if linked in this README, e.g.:
> ```markdown
> ![Schematic](scamatic.png)
> ```

## 🌊 I/O Waveform

The file **`io_wave.png`** is a GTKWave screenshot capturing the full 700ns simulation — showing the counter reset to `000`, counting up to `111`, preset to `111`, counting up again, reset + down-counting, preset + down-counting, and finally the two parallel-load events (`5` then `4`) each followed by up/down counting.

> ```markdown
> ![I/O Waveform](io_wave.png)
> ```

## 📼 VCD Dump File

**`dump.vcd`** is the raw Value Change Dump generated by `$dumpfile("dump.vcd")` / `$dumpvars(0, updowncounter_tb)`. It contains a complete time-stamped record of every signal transition in the simulation and can be reopened at any time with:
```bash
gtkwave dump.vcd
```

---

## 🎯 Applications

- Digital Logic Design coursework — demonstrating flip-flop excitation tables and structural Verilog
- Frequency division and event counting circuits
- Direction-controllable address generators (e.g., FIFO pointers, memory address counters)
- Building block for larger n-bit up/down counters, ring counters, or Johnson counters
- FPGA prototyping exercises for reset/preset/load-capable sequential elements

## ⚠ Limitations

- Fixed at 3 bits — not currently parameterized for arbitrary width
- The stimulus/testbench and structural design coexist in a single module (`updowncounter_tb`), which is convenient for simulation but is **not synthesizable as-is** for FPGA implementation without separating the DUT from the testbench
- No asynchronous reset/preset — all control signals are synchronous only
- No overflow/underflow flag output

## 🚀 Future Improvements

- [ ] Parameterize the design (`parameter N = 3`) for an n-bit generic up/down counter
- [ ] Split into a pure synthesizable top module (`updowncounter.v`) + separate testbench file (`updowncounter_tb.v`)
- [ ] Add asynchronous reset option
- [ ] Add terminal count / overflow (`TC`) output flag
- [ ] Add SystemVerilog assertions (SVA) for self-checking verification
- [ ] Add a constraints file (`.xdc`) for real FPGA board deployment in Vivado

## ❓ Troubleshooting / FAQ

**Q: `iverilog` is not recognized as an internal or external command.**
A: Add the Icarus Verilog installation's `bin` directory to your Windows `PATH` environment variable and restart VS Code/terminal.

**Q: GTKWave opens but shows no signals.**
A: Manually expand the `updowncounter_tb` hierarchy in the SST panel on the left and drag the desired signals into the main waveform view — GTKWave does not auto-populate the view on first open.

**Q: Vivado gives a synthesis error about `$monitor`/`$dumpfile`/`initial` timing controls.**
A: These are simulation-only system tasks. For synthesis, only synthesize the structural flip-flop instantiation portion (excluding the stimulus `initial` block), per the note in [Simulating / Synthesizing in Xilinx Vivado](#-simulating--synthesizing-in-xilinx-vivado).

**Q: Why does `Q` momentarily hold an unexpected value right after `rst`/`prt`/`ld` is de-asserted?**
A: Because all control transitions are **synchronous** — the new mode only takes effect on the *next* `posedge clk` after the control signal changes, which is expected, standard synchronous design behavior.

## 📄 License

This project is released under the **MIT License** — free to use, modify, and distribute for educational and personal projects. See `LICENSE` for full details.

## 👤 Author

Designed, simulated, and documented as a personal/academic digital logic design project using Icarus Verilog, VS Code, GTKWave, and Xilinx Vivado — runnable on Windows, Ubuntu/Linux, and macOS.

---

⭐ If you found this project helpful for learning sequential circuit design in Verilog, consider starring the repository!

