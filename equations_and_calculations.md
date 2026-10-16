# Mathematical Derivations, Governing Equations & Calculations

**Project Title:** Mechanical Vibration Analysis Using MATLAB & ANSYS  
**Institution:** National Institute of Technology (NIT) Hamirpur  
**Department:** Department of Mechanical Engineering  
**Academic Period:** August 2025 – December 2025  

---

## 1. Physical System Description & Free-Body Diagrams

Consider a two-degree-of-freedom (2-DOF) structural shear building or two-mass, three-spring, two-damper mechanical system. The system consists of:
- Floor 1 mass: $m_1 = 10.0\text{ kg}$
- Floor 2 mass: $m_2 = 8.0\text{ kg}$
- First story stiffness: $k_1 = 20,000\text{ N/m}$ ($20\text{ kN/m}$)
- Second story stiffness: $k_2 = 12,000\text{ N/m}$ ($12\text{ kN/m}$)
- First story viscous damping: $c_1 = 25.0\text{ N}\cdot\text{s/m}$
- Second story viscous damping: $c_2 = 15.0\text{ N}\cdot\text{s/m}$

Let $x_1(t)$ and $x_2(t)$ denote the generalized horizontal displacement coordinates of Mass 1 and Mass 2 measured from their static equilibrium positions.

---

## 2. Derivation of Equations of Motion

### Method A: Newton's Second Law of Motion
Applying $\sum F_x = m \ddot{x}$ to each mass:

#### For Mass 1 ($m_1$):
The forces acting on $m_1$ include:
- Restoring spring force from Story 1: $-k_1 x_1$
- Damping dashpot force from Story 1: $-c_1 \dot{x}_1$
- Restoring spring force from Story 2: $+k_2 (x_2 - x_1)$
- Damping dashpot force from Story 2: $+c_2 (\dot{x}_2 - \dot{x}_1)$
- External applied excitation: $F_1(t)$

$$\sum F_1 = m_1 \ddot{x}_1 = -k_1 x_1 - c_1 \dot{x}_1 + k_2 (x_2 - x_1) + c_2 (\dot{x}_2 - \dot{x}_1) + F_1(t)$$

Rearranging terms:
$$m_1 \ddot{x}_1 + (c_1 + c_2)\dot{x}_1 - c_2 \dot{x}_2 + (k_1 + k_2)x_1 - k_2 x_2 = F_1(t) \quad \text{--- (Eq. 1)}$$

#### For Mass 2 ($m_2$):
The forces acting on $m_2$ include:
- Restoring spring force from Story 2: $-k_2 (x_2 - x_1)$
- Damping dashpot force from Story 2: $-c_2 (\dot{x}_2 - \dot{x}_1)$
- External applied excitation: $F_2(t)$

$$\sum F_2 = m_2 \ddot{x}_2 = -k_2 (x_2 - x_1) - c_2 (\dot{x}_2 - \dot{x}_1) + F_2(t)$$

Rearranging terms:
$$m_2 \ddot{x}_2 - c_2 \dot{x}_1 + c_2 \dot{x}_2 - k_2 x_1 + k_2 x_2 = F_2(t) \quad \text{--- (Eq. 2)}$$

---

### Method B: Energy Method (Lagrange's Equations)
The kinetic energy $T$, strain potential energy $V$, and Rayleigh dissipation function $D$ are:
$$T = \frac{1}{2} m_1 \dot{x}_1^2 + \frac{1}{2} m_2 \dot{x}_2^2$$
$$V = \frac{1}{2} k_1 x_1^2 + \frac{1}{2} k_2 (x_2 - x_1)^2$$
$$D = \frac{1}{2} c_1 \dot{x}_1^2 + \frac{1}{2} c_2 (\dot{x}_2 - \dot{x}_1)^2$$

Lagrange's equation for generalized coordinate $q_i \in \{x_1, x_2\}$:
$$\frac{d}{dt}\left(\frac{\partial T}{\partial \dot{q}_i}\right) - \frac{\partial T}{\partial q_i} + \frac{\partial V}{\partial q_i} + \frac{\partial D}{\partial \dot{q}_i} = Q_i(t)$$

Evaluating partial derivatives:
$$\frac{d}{dt}\left(\frac{\partial T}{\partial \dot{x}_1}\right) = m_1 \ddot{x}_1, \quad \frac{\partial V}{\partial x_1} = k_1 x_1 - k_2 (x_2 - x_1) = (k_1 + k_2)x_1 - k_2 x_2$$
$$\frac{\partial D}{\partial \dot{x}_1} = c_1 \dot{x}_1 - c_2 (\dot{x}_2 - \dot{x}_1) = (c_1 + c_2)\dot{x}_1 - c_2 \dot{x}_2$$

This yields identical equations to Newton's formulation.

---

## 3. Matrix Representation

Assembling into compact matrix notation:
$$\mathbf{M} \ddot{\mathbf{x}}(t) + \mathbf{C} \dot{\mathbf{x}}(t) + \mathbf{K} \mathbf{x}(t) = \mathbf{F}(t)$$

Where:
$$\mathbf{M} = \begin{bmatrix} m_1 & 0 \\ 0 & m_2 \end{bmatrix} = \begin{bmatrix} 10.0 & 0 \\ 0 & 8.0 \end{bmatrix} \text{ kg}$$

$$\mathbf{K} = \begin{bmatrix} k_1 + k_2 & -k_2 \\ -k_2 & k_2 \end{bmatrix} = \begin{bmatrix} 32000.0 & -12000.0 \\ -12000.0 & 12000.0 \end{bmatrix} \text{ N/m}$$

$$\mathbf{C} = \begin{bmatrix} c_1 + c_2 & -c_2 \\ -c_2 & c_2 \end{bmatrix} = \begin{bmatrix} 40.0 & -15.0 \\ -15.0 & 15.0 \end{bmatrix} \text{ N}\cdot\text{s/m}$$

---

## 4. Undamped Eigenvalue Analysis & Natural Frequencies

For free undamped vibration ($\mathbf{C} = \mathbf{0}$, $\mathbf{F} = \mathbf{0}$), assume harmonic motion:
$$\mathbf{x}(t) = \boldsymbol{\phi} e^{i \omega t} \implies \ddot{\mathbf{x}}(t) = -\omega^2 \boldsymbol{\phi} e^{i \omega t}$$

Substituting into undamped equations:
$$(\mathbf{K} - \omega^2 \mathbf{M}) \boldsymbol{\phi} = \mathbf{0}$$

For non-trivial solutions ($\boldsymbol{\phi} \neq \mathbf{0}$):
$$\det(\mathbf{K} - \omega^2 \mathbf{M}) = 0$$

$$\det \begin{bmatrix} 32000 - 10\omega^2 & -12000 \\ -12000 & 12000 - 8\omega^2 \end{bmatrix} = 0$$

Expanding the determinant:
$$(32000 - 10\omega^2)(12000 - 8\omega^2) - (-12000)^2 = 0$$
$$80 \omega^4 - (32000 \times 8 + 12000 \times 10)\omega^2 + (384 \times 10^6 - 144 \times 10^6) = 0$$
$$80 \omega^4 - 376000 \omega^2 + 240000000 = 0$$

Dividing the entire polynomial by 80:
$$\omega^4 - 4700 \omega^2 + 3000000 = 0$$

Let $\lambda = \omega^2$. The quadratic equation is:
$$\lambda^2 - 4700 \lambda + 3000000 = 0$$

Discriminant $\Delta$:
$$\Delta = (-4700)^2 - 4(1)(3000000) = 22090000 - 12000000 = 10090000$$
$$\sqrt{\Delta} = \sqrt{10090000} \approx 3176.475722\text{ rad}^2/\text{s}^2$$

Solving for the eigenvalues:
$$\lambda_1 = \omega_1^2 = \frac{4700 - 3176.475722}{2} = \frac{1523.524278}{2} = 761.762139\text{ (rad/s)}^2$$
$$\lambda_2 = \omega_2^2 = \frac{4700 + 3176.475722}{2} = \frac{7876.475722}{2} = 3938.237861\text{ (rad/s)}^2$$

### Natural Frequencies:
- **First Mode (Fundamental):**
  $$\omega_1 = \sqrt{761.762139} = 27.600039\text{ rad/s}$$
  $$f_1 = \frac{\omega_1}{2\pi} = \frac{27.600039}{2\pi} = 4.392683\text{ Hz} \approx 4.3927\text{ Hz}$$
  $$T_1 = \frac{1}{f_1} = 0.227651\text{ s}$$

- **Second Mode:**
  $$\omega_2 = \sqrt{3938.237861} = 62.755381\text{ rad/s}$$
  $$f_2 = \frac{\omega_2}{2\pi} = \frac{62.755381}{2\pi} = 9.987820\text{ Hz} \approx 9.9878\text{ Hz}$$
  $$T_2 = \frac{1}{f_2} = 0.100122\text{ s}$$

---

## 5. Mode Shapes and Orthonormality

Substituting $\omega_r^2$ back into the first row of $(K - \omega_r^2 M) \phi_r = 0$:
$$(32000 - 10\omega_r^2) u_{1r} - 12000 u_{2r} = 0 \implies \frac{u_{2r}}{u_{1r}} = \frac{32000 - 10\omega_r^2}{12000}$$

### Mode 1 Ratio:
$$\frac{u_{21}}{u_{11}} = \frac{32000 - 10(761.762139)}{12000} = \frac{32000 - 7617.621}{12000} = \frac{24382.379}{12000} \approx +2.031865$$
Setting $u_{11} = 1.0$:
$$\boldsymbol{\phi}_{1,\text{norm}} = \begin{bmatrix} 1.0000 \\ +2.0319 \end{bmatrix} \quad \text{(In-phase mode: both floors displace in identical direction)}$$

### Mode 2 Ratio:
$$\frac{u_{22}}{u_{12}} = \frac{32000 - 10(3938.237861)}{12000} = \frac{32000 - 39382.379}{12000} = \frac{-7382.379}{12000} \approx -0.615198$$
Setting $u_{12} = 1.0$:
$$\boldsymbol{\phi}_{2,\text{norm}} = \begin{bmatrix} 1.0000 \\ -0.6152 \end{bmatrix} \quad \text{(Out-of-phase mode: floor 2 displaces opposite to floor 1)}$$

### Mass-Normalization Condition:
$$\boldsymbol{\phi}_i^T \mathbf{M} \boldsymbol{\phi}_i = 1$$
For Mode 1:
$$m_{\text{modal}, 1} = 10(1.0)^2 + 8(2.031865)^2 = 10 + 8(4.128475) = 10 + 33.02780 = 43.0278\text{ kg}$$
$$\boldsymbol{\phi}_1 = \frac{1}{\sqrt{43.0278}}\begin{bmatrix} 1.0 \\ 2.031865 \end{bmatrix} = \begin{bmatrix} 0.152449 \\ 0.309756 \end{bmatrix}$$

For Mode 2:
$$m_{\text{modal}, 2} = 10(1.0)^2 + 8(-0.615198)^2 = 10 + 8(0.378469) = 10 + 3.02775 = 13.0278\text{ kg}$$
$$\boldsymbol{\phi}_2 = \frac{1}{\sqrt{13.0278}}\begin{bmatrix} 1.0 \\ -0.615198 \end{bmatrix} = \begin{bmatrix} 0.277055 \\ -0.170443 \end{bmatrix}$$

Modal Matrix $\boldsymbol{\Phi}$:
$$\boldsymbol{\Phi} = \begin{bmatrix} 0.15245 & 0.27705 \\ 0.30976 & -0.17044 \end{bmatrix}$$

Verification of Orthogonality:
$$\boldsymbol{\Phi}^T \mathbf{M} \boldsymbol{\Phi} = \begin{bmatrix} 1.0000 & 0.0000 \\ 0.0000 & 1.0000 \end{bmatrix} = \mathbf{I}$$
$$\boldsymbol{\Phi}^T \mathbf{K} \boldsymbol{\Phi} = \begin{bmatrix} \omega_1^2 & 0 \\ 0 & \omega_2^2 \end{bmatrix} = \begin{bmatrix} 761.76 & 0.00 \\ 0.00 & 3938.24 \end{bmatrix}$$

---

## 6. Proportional Damping & Decoupling

The damping matrix satisfies Rayleigh stiffness proportional damping:
$$\mathbf{C} = \alpha \mathbf{M} + \beta \mathbf{K}$$
With $\alpha = 0\text{ s}^{-1}$ and $\beta = 0.00125\text{ s}$:
$$\beta \mathbf{K} = 0.00125 \begin{bmatrix} 32000 & -12000 \\ -12000 & 12000 \end{bmatrix} = \begin{bmatrix} 40.0 & -15.0 \\ -15.0 & 15.0 \end{bmatrix} = \mathbf{C}$$

Modal Damping Ratios:
$$\zeta_r = \frac{\alpha}{2\omega_r} + \frac{\beta \omega_r}{2} = \frac{0.00125 \times \omega_r}{2}$$
$$\zeta_1 = \frac{0.00125 \times 27.600039}{2} = 0.01725 = 1.725\% \approx 1.73\%$$
$$\zeta_2 = \frac{0.00125 \times 62.755381}{2} = 0.03922 = 3.922\% \approx 3.92\%$$

Both modes are lightly damped ($\zeta < 1$), ensuring classic underdamped oscillatory dynamics.

---

## 7. State-Space Representation

Let the state vector be $\mathbf{z}(t) = \begin{bmatrix} x_1(t) & x_2(t) & \dot{x}_1(t) & \dot{x}_2(t) \end{bmatrix}^T$.

$$\dot{\mathbf{z}}(t) = \mathbf{A} \mathbf{z}(t) + \mathbf{B} \mathbf{u}(t)$$
$$\mathbf{y}(t) = \mathbf{C}_{\text{ss}} \mathbf{z}(t) + \mathbf{D}_{\text{ss}} \mathbf{u}(t)$$

$$\mathbf{A} = \begin{bmatrix} \mathbf{0}_{2\times 2} & \mathbf{I}_{2\times 2} \\ -\mathbf{M}^{-1}\mathbf{K} & -\mathbf{M}^{-1}\mathbf{C} \end{bmatrix} = \begin{bmatrix} 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 1 \\ -3200 & 1200 & -4.0 & 1.5 \\ 1500 & -1500 & 1.875 & -1.875 \end{bmatrix}$$

$$\mathbf{B} = \begin{bmatrix} \mathbf{0}_{2\times 2} \\ \mathbf{M}^{-1} \end{bmatrix} = \begin{bmatrix} 0 & 0 \\ 0 & 0 \\ 0.100 & 0 \\ 0 & 0.125 \end{bmatrix}$$

$$\mathbf{C}_{\text{ss}} = \begin{bmatrix} 1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \end{bmatrix}, \quad \mathbf{D}_{\text{ss}} = \begin{bmatrix} 0 & 0 \\ 0 & 0 \end{bmatrix}$$

---

## 8. Dynamic Receptance Frequency Response Function (FRF)

Under harmonic excitation $\mathbf{F}(t) = \mathbf{F}_0 e^{i \omega t}$:
$$\mathbf{x}(t) = \mathbf{X}_0 e^{i \omega t} \implies (-\omega^2 \mathbf{M} + i \omega \mathbf{C} + \mathbf{K}) \mathbf{X}_0 = \mathbf{F}_0$$

Dynamic Impedance Matrix:
$$\mathbf{Z}(\omega) = -\omega^2 \mathbf{M} + i \omega \mathbf{C} + \mathbf{K}$$

Dynamic Receptance Matrix:
$$\mathbf{H}(\omega) = \mathbf{Z}(\omega)^{-1} = \begin{bmatrix} H_{11}(\omega) & H_{12}(\omega) \\ H_{21}(\omega) & H_{22}(\omega) \end{bmatrix}$$

Where $H_{jk}(\omega)$ represents displacement response of mass $j$ per unit force excitation applied at mass $k$. By Betti-Maxwell reciprocity theorem, $H_{12}(\omega) = H_{21}(\omega)$.
