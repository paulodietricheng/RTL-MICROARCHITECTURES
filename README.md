# RTL Microarchitectures

This repository is a collection of **RTL microarchitecture projects** written in **SystemVerilog**, built as part of my focused effort to develop strong fundamentals in **digital hardware design**, **timing-aware RTL**, and **FPGA-oriented architectures**.

Each project explores a specific hardware problem and documents both the **implementation** and the **design reasoning** behind it.

---

## Motivation

I created this repository to learn by practicing.

In particular, I am using these projects to learn how:

- Combinational logic maps to real hardware
- Architectural choices affect **critical path length**
- Pipelining changes **latency vs throughput**
- Designs scale as input sizes increase
- RTL decisions appear in synthesis and timing reports

---

## Repository Structure

Each folder is a self-contained microarchitecture project, containing the RTL in SystemVerilog, one simple testbench and a README explaining the design, architectural choices and tradeoffs.

---

## What I’m Focusing On

These projects are intentionally limited in scope so I can focus on fundamentals such as:

- SystemVerilog `generate` constructs
- Clean separation of combinational vs sequential logic
- Register placement and signal flow
- Signal naming and structure
- Writing RTL that is easy to analyze and modify

---

## Tools and Workflow

- **Language:** SystemVerilog  
- **Synthesis / Timing:** Vivado  
- **Verification:** Focused testbenches

---

## Current Status

This repository is a work in progress.

Designs may be refined, extended, or rewritten as my understanding improves.

---

## About Me

I am an electrical engineering student with a strong interest in:

- Digital hardware design
- FPGA-based systems
- Performance-oriented architectures

This repository reflects how I learn by doing.
