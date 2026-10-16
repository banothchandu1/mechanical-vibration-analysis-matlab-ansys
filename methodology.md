# Research Methodology & Simulation Framework

**Project Title:** Mechanical Vibration Analysis Using MATLAB & ANSYS  
**Institution:** National Institute of Technology (NIT) Hamirpur  
**Department:** Department of Mechanical Engineering  

---

## 1. Research Methodology Overview

This project implements a multi-tiered analytical and computational engineering framework to investigate the dynamic characteristics of multi-degree-of-freedom (MDOF) mechanical vibration systems. The methodological workflow integrates three complementary phases:

```
[Phase 1: Analytical Formulation]
   - Free-Body Diagrams & Newton/Lagrange Derivations
   - Structural Characteristic Determinant Solution
   - Closed-Form Eigenvalues, Natural Frequencies, Mode Shapes
         │
         ▼
[Phase 2: MATLAB Computational Implementation]
   - Generalized Matrix Eigensolution (eig)
   - State-Space Realization (A, B, C, D)
   - Time-Domain Transient Simulation (Runge-Kutta ODE45)
   - Frequency Response Function (FRF) Sweeping & Bode Plotting
         │
         ▼
[Phase 3: ANSYS Finite Element Simulation]
   - APDL Lumped Discrete Model (MASS21, COMBIN14)
   - ANSYS Workbench Continuous Beam Frame Formulation
   - Block Lanczos Modal Analysis
   - Full & Mode-Superposition Harmonic Response Analysis
         │
         ▼
[Phase 4: Synthesis & Verification]
   - Tabular Modal Parameter Comparison
   - Discrepancy & Mesh Convergence Analysis
   - Dynamic Amplification & Resonance Evaluation
```

---

## 2. Engineering Assumptions & System Idealizations

1. **Planar Motion (1-D Degrees of Freedom):**  
   Lateral displacement is confined to the horizontal $X$-axis. Vertical axial deformability of columns and torsional warping are neglected under the standard shear building hypothesis.
2. **Linear Elastic Behavior:**  
   Displacements remain within the linear elastic limits of the material ($\sigma \ll \sigma_y$). Spring forces follow Hooke's Law ($F_k = k \Delta x$).
3. **Rigid Floor Diaphragms:**  
   Floor beams and slabs are assumed to have infinite flexural rigidity relative to vertical columns, ensuring zero joint rotation at floor levels.
4. **Lumped Mass Idealization:**  
   Structural masses are concentrated at discrete floor nodes ($m_1$ and $m_2$). The distributed self-weight of column elements is neglected or incorporated as equivalent lumped mass fractions.
5. **Linear Viscous Rayleigh Damping:**  
   Damping is represented by classical orthogonal viscous damping $\mathbf{C} = \alpha \mathbf{M} + \beta \mathbf{K}$, allowing uncoupled modal coordinate transformations.

---

## 3. MATLAB Numerical Architecture

The MATLAB suite is structured into dedicated modular functions driven by an executive master script:

1. `main_vibration_analysis.m`: Orchestrates execution, sets parameter structures, invokes subroutines, produces graphical outputs, and generates summary tables.
2. `natural_frequency_analysis.m`: Employs MATLAB's generalized eigenvalue solver `eig(K, M)` to extract modal frequencies, periods, mass-normalized eigenvectors ($\boldsymbol{\Phi}^T \mathbf{M} \boldsymbol{\Phi} = \mathbf{I}$), and checks modal damping decoupling ($\boldsymbol{\Phi}^T \mathbf{C} \boldsymbol{\Phi}$).
3. `state_space_response.m`: Casts the second-order matrix differential equation into a continuous first-order state-space system $\dot{\mathbf{z}} = \mathbf{A}\mathbf{z} + \mathbf{B}\mathbf{u}$. Integrates non-linear and transient initial value problems using the adaptive variable-step Dormand-Prince Runge-Kutta solver (`ode45`) with absolute tolerance $10^{-10}$ and relative tolerance $10^{-8}$.
4. `harmonic_frequency_sweep.m`: Performs vectorized frequency response evaluations across 1500 points in the range $0.5\text{ to }20.0\text{ Hz}$, generating receptance magnitude ($|H(f)|$) and phase angle ($\angle H(f)$) curves.

---

## 4. ANSYS Finite Element Formulation

### APDL Discrete Model
In ANSYS Mechanical APDL, the system is modeled with discrete elements:
- `MASS21` structural point mass elements with active $U_X$ degree of freedom.
- `COMBIN14` linear spring-damper elements with longitudinal stiffness and damping along $U_X$.
- Boundary conditions: Fixed base at Node 1 ($U_X = U_Y = U_Z = 0$), transverse constraints on Nodes 2 and 3.
- Solution algorithm: Block Lanczos eigenvalue extraction (`MODOPT, LANB, 2`), which is unconditionally stable and exhibits superior convergence for clustered and low-order structural modes.

### Harmonic Response Solver Setup
- Full harmonic solver (`HROPT, FULL`) solves the unsymmetric or damped dynamic matrix directly at each frequency step:
  $$(-\omega^2 \mathbf{M} + i \omega \mathbf{C} + \mathbf{K}) \mathbf{x} = \mathbf{F}$$
- Rayleigh damping parameter `BETAD` is assigned to $0.00125\text{ s}$ to match the analytical viscous damping matrix.

---

## 5. Verification & Validation Metrics

To validate simulation results, relative percentage error is defined as:
$$\text{Relative Error (\%)} = \left| \frac{\text{Result}_{\text{Simulated}} - \text{Result}_{\text{Analytical}}}{\text{Result}_{\text{Analytical}}} \right| \times 100\%$$

When lumped parameters are used identically across both MATLAB and ANSYS APDL, the mathematical formulations are identical, resulting in $0.000\%$ analytical discrepancy down to floating-point truncation limits ($<10^{-6}$).
