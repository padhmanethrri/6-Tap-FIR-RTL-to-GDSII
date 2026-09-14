# 6-Tap FIR Filter — RTL to GDSII

An 8-bit, 6-tap Finite Impulse Response (FIR) filter implemented in Verilog and taken through an ASIC RTL-to-GDSII design flow using Cadence EDA tools.

##  Project Overview

This project demonstrates the implementation of a fixed-coefficient FIR filter, starting from RTL design and functional simulation and progressing through synthesis, placement, routing, timing analysis, power analysis, and physical verification.

The FIR filter uses six fixed coefficients:

| Tap | Coefficient |
|---|---:|
| h0 | 3 |
| h1 | 4 |
| h2 | 5 |
| h3 | 4 |
| h4 | 3 |
| h5 | 3 |

The design uses **8-bit input data** and produces a **16-bit output**.

---

##  FIR Filter Architecture

The filter follows a **direct-form FIR architecture** consisting of:

- Input data path
- Five delay elements implemented using D flip-flops
- Six constant-coefficient multiplication stages
- Adder structure for summing the multiplication results

The filter implements:

**y[n] = h0·x[n] + h1·x[n−1] + h2·x[n−2] + h3·x[n−3] + h4·x[n−4] + h5·x[n−5]**

where `x[n]` is the current input sample and the delayed samples are stored through the delay elements.

### Architecture

```text
x[n]
 │
 ├──────── × h0 ─────────┐
 │                       │
 ▼                       │
DFF → d1 ─── × h1 ───────┤
 │                       │
 ▼                       │
DFF → d2 ─── × h2 ───────┤
 │                       │
 ▼                       │
DFF → d3 ─── × h3 ───────┤──► ADD ──► dataout
 │                       │
 ▼                       │
DFF → d4 ─── × h4 ───────┤
 │                       │
 ▼                       │
DFF → d5 ─── × h5 ───────┘
```

---

##  Design Specifications

| Parameter | Value |
|---|---|
| Filter type | FIR |
| Number of taps | 6 |
| Input width | 8-bit |
| Output width | 16-bit |
| Architecture | Direct Form |
| Coefficients | `{3, 4, 5, 4, 3, 3}` |
| Technology | GPDK 90 nm |

---

##  RTL-to-GDSII Design Flow

```text
                 RTL Design
                     │
                     ▼
          Functional Simulation
        Icarus Verilog / NCLaunch
                     │
                     ▼
              RTL Synthesis
             Cadence Genus
                     │
                     ▼
             Gate-Level Netlist
                     │
                     ▼
              Floorplanning
                     │
                     ▼
                Placement
                     │
                     ▼
        Clock Tree Synthesis (CTS)
                     │
                     ▼
                 Routing
                     │
                     ▼
          Timing & Power Analysis
                     │
                     ▼
          Physical Verification
             DRC / Connectivity
                     │
                     ▼
                  GDSII
```

---

##  Tools Used

| Tool | Purpose |
|---|---|
| Verilog | RTL design |
| Icarus Verilog | Functional simulation |
| EDA Playground | RTL simulation |
| Cadence NCLaunch | Simulation |
| Cadence Genus | RTL synthesis |
| Cadence Innovus | Floorplanning, placement and routing |
| Cadence Stylus | Physical verification / analysis |

---

##  RTL Implementation

The RTL contains the FIR filter and D flip-flop based delay elements.

The five delay elements store previous input samples:

```text
x[n] → d1 → d2 → d3 → d4 → d5
```

Each input sample is multiplied by its corresponding coefficient and the six products are summed to generate the filter output.

The RTL uses:

- 8-bit input `x`
- 8-bit delay elements
- 16-bit multiplication results
- 16-bit output `dataout`
- Synchronous data movement controlled by the clock
- Asynchronous reset

---

##  Functional Verification

A Verilog testbench was used to apply input samples and observe:

- Clock
- Reset
- Input `x`
- Delay signals `d1` through `d5`
- Filter output `dataout`

### Test Input Sequence

```text
10, 10, 20, 20, 30, 30, 40, 40,
50, 50, 60, 60, 70, 70, 80, 80,
90, 90, 100, 100
```

The simulation waveforms and console output were used to verify the FIR filtering behavior.

---

##  Synthesis — Cadence Genus

The RTL was synthesized using **Cadence Genus** targeting a **GPDK 90 nm** standard-cell library.

The synthesis stage was used to obtain:

- Gate-level netlist
- Timing information
- Area report
- Power report
- Quality-of-results information
- SDC constraints for the backend flow

### Reported Synthesis Results

| Metric | Result |
|---|---:|
| Total synthesized area | 703.152 units |
| Reported positive slack | 37,740 ps |

The reported positive slack indicates that the design met the timing requirements during synthesis.

---

##  Physical Design — Cadence Innovus

The synthesized design was taken through the physical implementation flow using **Cadence Innovus**.

### 1. Power Planning

Power stripes were added across the core area to provide VDD/VSS distribution and support power integrity.

### 2. Placement

Standard cells were placed using timing-driven optimization.

Placement optimization considered:

- Setup timing
- Hold timing
- Cell placement
- Congestion

### 3. Clock Tree Synthesis

Clock tree synthesis was performed to distribute the clock signal through the design while maintaining timing requirements.

### 4. Routing

Global and detailed routing were performed after placement and CTS.

Routing included:

- Routing-rule checks
- Connectivity verification
- DRC checking

---

##  Timing Analysis

Final timing analysis was performed after clock tree synthesis and routing.

Both **setup** and **hold** timing were checked.

### Reported Final Timing

| Timing Metric | Reported Value |
|---|---:|
| Setup WNS | 37.476 ns |
| Hold WNS | 10.107 ns |
| Setup violations | 0 |
| Hold violations | 0 |

Positive slack was reported for both setup and hold analysis.

---

##  Power & Rail Analysis

Power analysis was performed to evaluate:

- Dynamic power
- Leakage power
- Total power

Rail analysis was also performed to examine the power delivery network and power integrity, including:

- IR drop
- Electromigration (EM)
- Supply integrity

---

##  Physical Verification

The physical implementation included checks for:

- Design Rule Check (DRC)
- Connectivity
- Routing-rule compliance
- Timing closure
- Power integrity

The reported implementation showed:

- No reported DRC violations
- No setup violations
- No hold violations

---

##  Results Summary

| Metric | Result |
|---|---:|
| Technology | GPDK 90 nm |
| Input width | 8-bit |
| Output width | 16-bit |
| Number of taps | 6 |
| Architecture | Direct Form |
| Area | 703.152 units |
| Setup WNS | 37.476 ns |
| Hold WNS | 10.107 ns |
| Setup violations | 0 |
| Hold violations | 0 |
| DRC violations | 0 reported |

---


##  Future Work

The baseline implementation can be further investigated and optimized through:

- Constant-coefficient multiplier optimization
- Adder-tree optimization
- RTL architecture optimization
- Pipelining
- Area optimization
- Power optimization
- Timing optimization
- Improved functional verification
- RTL vs. gate-level simulation
- Pre-layout vs. post-layout analysis
- Baseline vs. optimized PPA comparison

---
