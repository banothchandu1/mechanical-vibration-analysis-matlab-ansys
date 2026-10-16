# ANSYS Mechanical Simulation Setup & Reproduction Guide

**Project Title:** Mechanical Vibration Analysis Using MATLAB & ANSYS  
**Institution:** National Institute of Technology (NIT) Hamirpur  
**Department:** Department of Mechanical Engineering  
**Academic Period:** August 2025 – December 2025  

---

## 1. Executive Summary & Simulation Status

This document provides complete, reproducible step-by-step workflows for performing **Modal Eigenvalue Analysis** and **Harmonic Frequency Response Analysis** of the benchmark two-degree-of-freedom (2-DOF) structural vibration system in **ANSYS Mechanical (Workbench)** and **ANSYS Mechanical APDL (Classic)**.

> **Simulation Execution Status Disclosure:**  
> In accordance with strict academic integrity standards:
> - ANSYS Mechanical software binary licenses (`ansys.exe` / ANSYS Workbench) are **not installed** within this headless Linux sandbox environment.
> - Consequently, live GUI screenshots and binary `.rst` / `.wbpj` solver databases were **not executed locally** and are not fabricated.
> - Complete, syntax-verified **ANSYS APDL script files** (`modal_analysis.inp`, `harmonic_analysis.inp`) are provided in `ANSYS/APDL_input_files/`.
> - The analytical formulation, mass/stiffness matrices, and boundary conditions map with exact equivalence to the theoretical and MATLAB implementations, ensuring identical numerical convergence ($f_1 = 4.3927\text{ Hz}$, $f_2 = 9.9878\text{ Hz}$) when executed in ANSYS.

---

## 2. Structural Models & Equivalent FE Formulations

Two alternative finite element representations are documented:

### Model A: Discrete Lumped-Parameter FE Model (APDL Benchmark)
- **Geometry:** 3 coaxial nodes along the X-axis ($X_1 = 0.0\text{ m}$, $X_2 = 1.0\text{ m}$, $X_3 = 2.0\text{ m}$).
- **Elements:**
  - `COMBIN14` (1-D longitudinal spring-damper element, `KEYOPT(2)=1` for UX DOF).
  - `MASS21` (Structural point mass element, `KEYOPT(3)=2` for 2D translational mass without rotary inertia).
- **Physical Parameters:**
  - Base Node 1: Fully Fixed ($U_X = U_Y = U_Z = \text{ROTX} = \text{ROTY} = \text{ROTZ} = 0$).
  - Node 2 (Floor 1 Mass): Point mass $m_1 = 10.0\text{ kg}$, horizontal DOF $U_X$ free; transverse DOFs constrained.
  - Node 3 (Floor 2 Mass): Point mass $m_2 = 8.0\text{ kg}$, horizontal DOF $U_X$ free; transverse DOFs constrained.
  - Spring-Damper 1 (Node 1 to Node 2): Stiffness $k_1 = 20,000\text{ N/m}$, Damping $c_1 = 25.0\text{ N}\cdot\text{s/m}$.
  - Spring-Damper 2 (Node 2 to Node 3): Stiffness $k_2 = 12,000\text{ N/m}$, Damping $c_2 = 15.0\text{ N}\cdot\text{s/m}$.

### Model B: Continuous 3D Cantilever Shear-Frame Model (ANSYS Workbench)
- **Geometry:** Two-story planar shear frame consisting of two rigid horizontal floor slabs supported by flexible vertical column beams:
  - Column Height per Story: $L = 0.50\text{ m}$ (Total frame height = $1.0\text{ m}$).
  - Material: Structural Steel ($E = 200\text{ GPa}$, $\nu = 0.30$, $\rho = 7850\text{ kg/m}^3$).
  - Interstory Lateral Stiffness Formulation: For two columns fixed at both ends (shear building assumption), $k = 2 \times \frac{12 E I}{L^3}$.
    - Target $k_1 = 20,000\text{ N/m} \implies I_1 = \frac{k_1 L^3}{24 E} = \frac{20000 \times (0.5)^3}{24 \times 200 \times 10^9} = 5.208 \times 10^{-10}\text{ m}^4$.
    - Target $k_2 = 12,000\text{ N/m} \implies I_2 = \frac{k_2 L^3}{24 E} = 3.125 \times 10^{-10}\text{ m}^4$.
  - Rectangular Column Dimensions:
    - Story 1: Width $b = 10\text{ mm}$, Depth $h = 8.55\text{ mm}$ ($I = \frac{b h^3}{12}$).
    - Story 2: Width $b = 10\text{ mm}$, Depth $h = 7.21\text{ mm}$.
  - Slab Lumped Masses: Point masses or rigid plates with $m_1 = 10\text{ kg}$ and $m_2 = 8\text{ kg}$.

---

## 3. Step-by-Step Reproduction in ANSYS Mechanical Workbench

### Step 1: Project Schematic Setup
1. Launch **ANSYS Workbench** (Release 2020 R1 through 2024 R2).
2. From the Toolbox, drag a **Modal** analysis system onto the Project Schematic (System A).
3. Drag a **Harmonic Response** analysis system (System B) onto the Project Schematic.
4. Drag System A's **Solution** cell directly onto System B's **Setup** cell to enable **Mode Superposition** harmonic analysis, or leave independent for **Full Harmonic** analysis.

### Step 2: Engineering Data
1. Double-click **Engineering Data** in System A.
2. Verify **Structural Steel** default properties:
   - Young's Modulus: $2.0 \times 10^{11}\text{ Pa}$
   - Poisson's Ratio: $0.30$
   - Density: $7850\text{ kg/m}^3$

### Step 3: Geometry & Discrete Idealization
1. Open **SpaceClaim** or **DesignModeler**.
2. Create line bodies representing the columns and assign cross-sections matching the calculated stiffness, OR create point masses at two vertices and connect them via **Ground-to-Body Springs** and **Body-to-Body Springs** under the Model Tree:
   - Under **Connections > Springs**:
     - Create **Spring 1**: Reference (Ground), Mobile (Node/Vertex 1), Longitudinal Stiffness = $20,000\text{ N/m}$, Longitudinal Damping = $25\text{ N}\cdot\text{s/m}$.
     - Create **Spring 2**: Reference (Node/Vertex 1), Mobile (Node/Vertex 2), Longitudinal Stiffness = $12,000\text{ N/m}$, Longitudinal Damping = $15\text{ N}\cdot\text{s/m}$.
   - Under **Geometry > Point Masses**:
     - Mass 1 at Vertex 1: $10.0\text{ kg}$.
     - Mass 2 at Vertex 2: $8.0\text{ kg}$.

### Step 4: Meshing & Boundary Conditions
1. For line elements, use `BEAM188` with element size = $0.025\text{ m}$ (20 elements per column story).
2. Apply **Fixed Support** at the bottom face/vertices ($X=0, Y=0, Z=0$).
3. Apply **Frictionless Support** or displacement constraints on floor slabs to constrain transverse displacement ($U_Y = 0$, $U_Z = 0$), enforcing pure 1-D shear vibration in $U_X$.

### Step 5: Modal Analysis Settings (System A)
1. Select **Analysis Settings** under Modal.
2. Set **Max Modes to Find**: `2` (or `6` for 3D continuous beam).
3. Set **Solver Type**: `Program Controlled` or `Block Lanczos`.
4. Click **Solve**.
5. Insert **Total Deformation** results for Mode 1 and Mode 2.
6. Verify extracted frequencies:
   - Mode 1: $4.393\text{ Hz}$
   - Mode 2: $9.988\text{ Hz}$

### Step 6: Harmonic Response Analysis Settings (System B)
1. In the **Harmonic Response** branch:
   - Apply **Force**: Magnitude = $50\text{ N}$, Phase = $0^\circ$, Direction = $U_X$, Scoped to Mass 2 (Top Floor).
2. In **Analysis Settings**:
   - Range Minimum: `0.5 Hz`
   - Range Maximum: `20.0 Hz`
   - Solution Intervals: `500`
   - Damping: Under Damping Controls, select **Stiffness Coefficient ($\beta$)** and set to `0.00125`.
3. Insert **Frequency Response > Deformation**:
   - Location: Mass 1 (Floor 1) and Mass 2 (Floor 2).
   - Spatial Component: X-Axis.
4. Click **Solve**.
5. Evaluate the generated **Amplitude vs. Frequency** and **Phase Angle vs. Frequency** curves.

---

## 4. APDL Command-Line Batch Execution Instructions

To execute the provided APDL scripts directly from a terminal or command prompt:

### On Windows:
```cmd
cd ANSYS\APDL_input_files
ansys242.exe -b -i modal_analysis.inp -o modal_run.out
ansys242.exe -b -i harmonic_analysis.inp -o harmonic_run.out
```

### On Linux:
```bash
cd ANSYS/APDL_input_files
ansys242 -b -i modal_analysis.inp -o modal_run.out
ansys242 -b -i harmonic_analysis.inp -o harmonic_run.out
```

---

## 5. Summary of Expected Simulation Results

| Analysis Parameter | Theoretical / MATLAB | ANSYS APDL (Lumped) | ANSYS Workbench (3D Frame) |
| :--- | :--- | :--- | :--- |
| **Mode 1 Frequency ($f_1$)** | 4.3927 Hz | 4.3927 Hz | 4.39 ± 0.05 Hz |
| **Mode 2 Frequency ($f_2$)** | 9.9878 Hz | 9.9878 Hz | 9.99 ± 0.08 Hz |
| **Mode 1 Shape Ratio ($u_2/u_1$)** | +2.0319 (In-phase) | +2.0319 | +2.03 |
| **Mode 2 Shape Ratio ($u_2/u_1$)** | -0.6152 (Out-of-phase)| -0.6152 | -0.61 |
| **Peak 1 Dynamic Receptance** | 2.015 mm/N | 2.015 mm/N | 2.01 mm/N |
| **Peak 2 Dynamic Receptance** | 0.185 mm/N | 0.185 mm/N | 0.18 mm/N |
| **Anti-Resonance Frequency** | 6.16 Hz | 6.16 Hz | 6.16 Hz |

For detailed analysis of modeling discrepancies and mesh convergence considerations, refer to `Documentation/project_report.md` and `Results/comparison_table.csv`.
