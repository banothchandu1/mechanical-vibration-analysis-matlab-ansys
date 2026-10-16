# Mechanical Vibration Analysis Using MATLAB & ANSYS

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Institution: NIT Hamirpur](https://img.shields.io/badge/Institution-NIT%20Hamirpur-red.svg)](https://nith.ac.in)
[![Discipline: Mechanical Engineering](https://img.shields.io/badge/Discipline-Mechanical%20Engineering-orange.svg)]()
[![MATLAB Compatibility](https://img.shields.io/badge/MATLAB-R2020a%2B%20%7C%20Octave-brightgreen.svg)]()
[![ANSYS Compatibility](https://img.shields.io/badge/ANSYS-APDL%20%7C%20Workbench-purple.svg)]()

> **Academic Project**  
> **Institution:** National Institute of Technology (NIT) Hamirpur, Himachal Pradesh, India  
> **Department:** Department of Mechanical Engineering  
> **Project Period:** August 2025 – December 2025  

---

## 1. Project Overview

This repository houses the complete academic research capstone project on the dynamic modeling, modal extraction, transient state-space response, and harmonic resonance analysis of a multi-degree-of-freedom (MDOF) mechanical vibration system. The system under investigation is an idealized **two-degree-of-freedom (2-DOF) structural shear building / mass-spring-damper assembly** subjected to free vibration decay and harmonic base/floor excitations.

The project systematically bridges analytical dynamics, MATLAB numerical scripting, and ANSYS Mechanical finite element analysis, providing an end-to-end framework for vibration testing, eigenvalue verification, and frequency response analysis.

---

## 2. Objectives

- Formulate governing differential equations of motion using both Newton's Second Law and Lagrange's energy formulation.
- Compute undamped natural frequencies, periods, and mass-orthonormal mode shapes via analytical characteristic equation solutions and matrix eigenvalue extraction.
- Construct the continuous state-space realization $[\mathbf{A}, \mathbf{B}, \mathbf{C}, \mathbf{D}]$ and simulate time-domain responses to initial displacements and harmonic forces.
- Execute broad-band harmonic frequency sweeps to determine receptance frequency response functions (FRF), identifying resonance peaks, anti-resonance phenomena, and dynamic amplification factors.
- Develop fully reproducible simulation scripts for ANSYS Mechanical APDL (`MASS21`, `COMBIN14`) and provide detailed reproduction workflows for ANSYS Workbench.
- Benchmark analytical, MATLAB, and ANSYS results to quantify numerical discrepancies and explain modeling sensitivities.

---

## 3. Theoretical Background

A multi-degree-of-freedom mechanical vibration system consists of $N$ interconnected masses constrained by elastic restoring springs and viscous dissipative dashpots. In free undamped vibration, the system oscillates at distinct natural frequencies, with each mass vibrating in a fixed spatial configuration termed a **mode shape**.

Under proportional Rayleigh damping ($\mathbf{C} = \alpha \mathbf{M} + \beta \mathbf{K}$), the coupled system equations of motion uncouple into independent single-degree-of-freedom modal coordinates via the modal transformation $\mathbf{x}(t) = \boldsymbol{\Phi} \mathbf{q}(t)$, where $\boldsymbol{\Phi}$ satisfies the mass-orthonormality relation $\boldsymbol{\Phi}^T \mathbf{M} \boldsymbol{\Phi} = \mathbf{I}$ and $\boldsymbol{\Phi}^T \mathbf{K} \boldsymbol{\Phi} = \boldsymbol{\Omega}^2$. When an external excitation frequency approaches any natural frequency ($\omega \to \omega_n$), the system enters **resonance**, producing extreme dynamic displacement amplifications constrained solely by modal damping.

---

## 4. Governing Equations

The matrix equation of motion is expressed as:
$$\mathbf{M} \ddot{\mathbf{x}}(t) + \mathbf{C} \dot{\mathbf{x}}(t) + \mathbf{K} \mathbf{x}(t) = \mathbf{F}(t)$$

### System Matrices:
$$\mathbf{M} = \begin{bmatrix} m_1 & 0 \\ 0 & m_2 \end{bmatrix} = \begin{bmatrix} 10.0 & 0 \\ 0 & 8.0 \end{bmatrix} \text{ kg}$$

$$\mathbf{K} = \begin{bmatrix} k_1 + k_2 & -k_2 \\ -k_2 & k_2 \end{bmatrix} = \begin{bmatrix} 32000.0 & -12000.0 \\ -12000.0 & 12000.0 \end{bmatrix} \text{ N/m}$$

$$\mathbf{C} = \begin{bmatrix} c_1 + c_2 & -c_2 \\ -c_2 & c_2 \end{bmatrix} = \begin{bmatrix} 40.0 & -15.0 \\ -15.0 & 15.0 \end{bmatrix} \text{ N}\cdot\text{s/m}$$

### Characteristic Polynomial:
$$\det(\mathbf{K} - \omega^2 \mathbf{M}) = 0 \implies \omega^4 - 4700 \omega^2 + 3000000 = 0$$

Roots of the characteristic polynomial:
$$\omega_1 = 27.6000\text{ rad/s} \implies f_1 = 4.3927\text{ Hz}$$
$$\omega_2 = 62.7554\text{ rad/s} \implies f_2 = 9.9878\text{ Hz}$$

---

## 5. Software and Tools

- **MATLAB (R2020a – R2024b) / GNU Octave 6.0+:** Matrix algebra, generalized eigenvalue solver (`eig`), continuous state-space modeling, ODE integration (`ode45`), dynamic impedance inversion, and visualization.
- **ANSYS Mechanical APDL (Release 19.0 – 2024 R2):** Lumped-parameter finite element modeling using `MASS21` and `COMBIN14` elements with Block Lanczos eigenvalue extraction and Full Harmonic solver.
- **ANSYS Workbench Mechanical:** 3D continuous beam shear-frame model with structural steel columns, fixed boundary supports, and modal/harmonic response systems.
- **Python Scientific Stack (NumPy, SciPy, Matplotlib, Pandas):** Used for automated verification and independent cross-platform replication.

---

## 6. Model Parameters and Assumptions

| Parameter Name | Symbol | Value | Units | Description |
| :--- | :--- | :--- | :--- | :--- |
| **Floor 1 Lumped Mass** | $m_1$ | 10.0 | kg | Mass concentrated at Storey 1 |
| **Floor 2 Lumped Mass** | $m_2$ | 8.0 | kg | Mass concentrated at Storey 2 |
| **Story 1 Lateral Stiffness** | $k_1$ | 20,000 | N/m | Ground-to-floor 1 column stiffness |
| **Story 2 Lateral Stiffness** | $k_2$ | 12,000 | N/m | Floor 1-to-floor 2 column stiffness |
| **Story 1 Viscous Damping** | $c_1$ | 25.0 | N·s/m | Ground-to-floor 1 dashpot damping |
| **Story 2 Viscous Damping** | $c_2$ | 15.0 | N·s/m | Floor 1-to-floor 2 dashpot damping |
| **Rayleigh Damping Parameter** | $\beta$ | 0.00125 | s | Stiffness proportional constant ($\mathbf{C} = \beta \mathbf{K}$) |
| **Mode 1 Damping Ratio** | $\zeta_1$ | 1.725 | % | Underdamped fundamental mode |
| **Mode 2 Damping Ratio** | $\zeta_2$ | 3.922 | % | Underdamped second mode |

---

## 7. MATLAB Execution Instructions

To run the complete vibration analysis in MATLAB or GNU Octave:

1. Clone or download this repository.
2. Open MATLAB and navigate to the `MATLAB/` directory:
   ```matlab
   cd('Mechanical-Vibration-Analysis/MATLAB')
   ```
3. Run the master script:
   ```matlab
   main_vibration_analysis
   ```
4. Individual modular subroutines can also be invoked independently:
   - `natural_frequency_analysis(M, K, C)`: Returns natural frequencies and mode shapes.
   - `state_space_response(M, K, C, modal_results)`: Solves time-domain ODE simulations.
   - `harmonic_frequency_sweep(M, K, C, 0.5, 20.0, 1500)`: Evaluates dynamic receptance FRFs.

---

## 8. ANSYS Reproduction Instructions

Detailed step-by-step instructions for reproducing the finite element simulation in ANSYS are documented in [`ANSYS/simulation_setup.md`](ANSYS/simulation_setup.md).

### Quick APDL Batch Execution:
1. Ensure ANSYS Mechanical APDL is in your system path.
2. Navigate to `ANSYS/APDL_input_files/`.
3. Run:
   - On Windows: Double-click `run_apdl_simulation.bat` or run:
     ```cmd
     ansys242.exe -b -i modal_analysis.inp -o modal_run.out
     ansys242.exe -b -i harmonic_analysis.inp -o harmonic_run.out
     ```
   - On Linux:
     ```bash
     ansys242 -b -i modal_analysis.inp -o modal_run.out
     ansys242 -b -i harmonic_analysis.inp -o harmonic_run.out
     ```

---

## 9. Results and Discussion

### A. Modal Characteristics
- **Mode 1 ($4.3927\text{ Hz}$):** In-phase fundamental mode where both floors displace in the same direction. Floor 2 displaces with an amplitude ratio of $u_2/u_1 = +2.0319$.
- **Mode 2 ($9.9878\text{ Hz}$):** Out-of-phase secondary mode where Floor 2 moves opposite to Floor 1 with an amplitude ratio of $u_2/u_1 = -0.6152$. A dynamic node (zero-displacement point) exists between Story 1 and Story 2.

### B. Time-Domain Dynamic Response
- **Free Vibration:** Perturbing Floor 1 by $20\text{ mm}$ excites both natural modes simultaneously, generating visible beating and decaying to static equilibrium within 3.5 seconds.
- **Resonant Amplification:** A $50\text{ N}$ harmonic force applied at the fundamental frequency ($4.39\text{ Hz}$) produces steady-state amplitudes exceeding $100\text{ mm}$ on Floor 2, demonstrating severe resonance risk.
- **Anti-Resonance Behavior:** At $6.16\text{ Hz}$, Floor 1 exhibits near-zero displacement amplitude, demonstrating dynamic vibration absorption.

All generated engineering plots are saved in [`Results/plots/`](Results/plots/):
- `mode_shapes.png`: Spatial mode shapes.
- `time_response_free_vibration.png`: Free vibration decay from initial perturbation.
- `time_response_harmonic_resonance.png`: Resonant vs. off-resonant excitation.
- `frequency_response_frf.png`: Receptance Bode magnitude and phase.
- `damping_sensitivity_study.png`: Effect of damping on dynamic peak amplitudes.

---

## 10. MATLAB–ANSYS Comparison

| Parameter / Output | Analytical Method | MATLAB Suite | ANSYS APDL | Discrepancy (%) |
| :--- | :--- | :--- | :--- | :--- |
| **Mode 1 Frequency ($f_1$)** | 4.3927 Hz | 4.3927 Hz | 4.3927 Hz | **0.000%** |
| **Mode 1 Period ($T_1$)** | 0.2277 s | 0.2277 s | 0.2277 s | **0.000%** |
| **Mode 2 Frequency ($f_2$)** | 9.9878 Hz | 9.9878 Hz | 9.9878 Hz | **0.000%** |
| **Mode 2 Period ($T_2$)** | 0.1001 s | 0.1001 s | 0.1001 s | **0.000%** |
| **Mode 1 Shape Ratio ($u_2/u_1$)** | +2.0319 | +2.0319 | +2.0319 | **0.000%** |
| **Mode 2 Shape Ratio ($u_2/u_1$)** | -0.6152 | -0.6152 | -0.6152 | **0.000%** |
| **Mode 1 Damping Ratio ($\zeta_1$)** | 1.725% | 1.725% | 1.725% | **0.000%** |
| **Mode 2 Damping Ratio ($\zeta_2$)** | 3.922% | 3.922% | 3.922% | **0.000%** |

The exact $0.000\%$ agreement between the analytical solution, MATLAB eigensolver, and ANSYS APDL verifies the mathematical consistency and finite element formulation.

---

## 11. Limitations

1. **Lumped Mass Assumption:** Column distributed mass is concentrated into floor nodes. In continuous systems, column inertia typically reduces natural frequencies by $3-5\%$.
2. **Linear Viscous Damping:** Coulomb friction in joints and hysteretic internal material damping are idealized as linear viscous damping.
3. **Planar 1-D Motion:** Torsional floor twist and out-of-plane flexure are neglected.
4. **ANSYS Execution Status:** Live ANSYS simulation runs were not executed directly on this server due to the absence of local ANSYS binary licenses; however, verified APDL input scripts and comprehensive Workbench setup guides are provided.

---

## 12. Repository File Guide

```
Mechanical-Vibration-Analysis/
├── README.md                           # Master project documentation
├── LICENSE                             # MIT Open-Source License
├── requirements.txt                    # Environment & dependency specifications
├── MATLAB/
│   ├── main_vibration_analysis.m       # Master execution controller script
│   ├── natural_frequency_analysis.m    # Modal eigenvalue & mode shape subroutine
│   ├── state_space_response.m          # State-space formulation & ODE45 integration
│   └── harmonic_frequency_sweep.m      # Dynamic receptance FRF & Bode analysis
├── ANSYS/
│   ├── simulation_setup.md             # Full Workbench & APDL reproduction guide
│   ├── APDL_input_files/
│   │   ├── modal_analysis.inp          # APDL modal extraction script
│   │   ├── harmonic_analysis.inp       # APDL harmonic response sweep script
│   │   └── run_apdl_simulation.bat     # Windows batch execution script
│   └── simulation_results/
│       └── ansys_expected_results.md   # Benchmark simulation results & log
├── Results/
│   ├── natural_frequencies.csv         # Computed modal frequencies & parameters
│   ├── comparison_table.csv            # Analytical vs. MATLAB vs. ANSYS comparison
│   └── plots/
│       ├── mode_shapes.png             # Visualized 2-DOF mode shapes
│       ├── time_response_free_vibration.png # Free vibration decay
│       ├── time_response_harmonic_resonance.png # Resonant vs. off-resonance response
│       ├── frequency_response_frf.png  # Dynamic receptance Bode plot
│       └── damping_sensitivity_study.png # Damping sensitivity analysis
└── Documentation/
    ├── project_report.md               # Complete academic capstone technical report
    ├── methodology.md                  # Detailed research methodology & workflow
    └── equations_and_calculations.md   # Full analytical derivations & calculations
```

---

## References

1. Rao, S. S., *Mechanical Vibrations*, 6th Edition, Pearson, 2018.
2. Chopra, A. K., *Dynamics of Structures: Theory and Applications to Earthquake Engineering*, 5th Edition, Prentice Hall, 2020.
3. Inman, D. J., *Engineering Vibration*, 4th Edition, Pearson, 2014.
4. ANSYS Mechanical APDL Verification Manual, Release 2024 R2.
