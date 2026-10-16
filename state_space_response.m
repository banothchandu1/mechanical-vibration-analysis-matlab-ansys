function ss_results = state_space_response(M, K, C, modal_results)
% STATE_SPACE_RESPONSE - Formulates state-space model and simulates time response.
%
% State vector: z = [x1; x2; v1; v2]
% Equations:
%   dz/dt = A * z + B * u
%   y     = C_ss * z + D_ss * u
%
% Outputs:
%   ss_results - Struct containing state-space matrices and simulation trajectories.
%
% Project: Mechanical Vibration Analysis Using MATLAB & ANSYS
% Institution: NIT Hamirpur (Department of Mechanical Engineering)

fprintf('\n========================================================\n');
fprintf('      STATE-SPACE MODELLING & TIME-DOMAIN RESPONSE      \n');
fprintf('========================================================\n');

% 1. Formulate Continuous State-Space Matrices
Minv = inv(M);
num_dof = size(M, 1);

A = [zeros(num_dof, num_dof), eye(num_dof);
     -Minv * K,              -Minv * C];

B = [zeros(num_dof, num_dof);
     Minv];

C_ss = [eye(num_dof), zeros(num_dof, num_dof)]; % Output is displacement [x1; x2]
D_ss = zeros(num_dof, num_dof);

fprintf('State Matrix A (size 4x4):\n');
disp(A);
fprintf('Input Matrix B (size 4x2):\n');
disp(B);

% Eigenvalues of state matrix A
eig_A = eig(A);
fprintf('Eigenvalues of Continuous System Matrix A:\n');
for i = 1:length(eig_A)
    wn = abs(eig_A(i));
    zeta = -real(eig_A(i)) / wn;
    fprintf('  lambda_%d = %10.4f + %10.4fi  (fn = %6.4f Hz, zeta = %.4f)\n', ...
        i, real(eig_A(i)), imag(eig_A(i)), wn/(2*pi), zeta);
end

% 2. Case A: Free Vibration Response to Initial Displacements
% Initial condition: Floor 1 perturbed by 20 mm, Floor 2 at rest
z0 = [0.020; 0.000; 0.000; 0.000]; % [m, m, m/s, m/s]
t_free = linspace(0, 4.0, 2000);

% Simulation using matrix exponential / ODE45
sys_free = @(t, z) A * z;
[t_out_free, z_free] = ode45(sys_free, t_free, z0);

% 3. Case B: Forced Vibration - Resonance 1, Resonance 2, and Off-Resonance
% Force applied at top floor (Mass 2): F2(t) = F0 * sin(omega * t)
F0 = 50.0; % Force amplitude (N)
t_forced = linspace(0, 3.0, 3000);

% Mode 1 Resonance (f1 = 4.3927 Hz)
omega1 = modal_results.omega_n(1);
sys_res1 = @(t, z) A * z + B * [0; F0 * sin(omega1 * t)];
[~, z_res1] = ode45(sys_res1, t_forced, zeros(4, 1));

% Mode 2 Resonance (f2 = 9.9878 Hz)
omega2 = modal_results.omega_n(2);
sys_res2 = @(t, z) A * z + B * [0; F0 * sin(omega2 * t)];
[~, z_res2] = ode45(sys_res2, t_forced, zeros(4, 1));

% Off-Resonance (f_off = 7.0 Hz)
omega_off = 2 * pi * 7.0;
sys_off = @(t, z) A * z + B * [0; F0 * sin(omega_off * t)];
[~, z_off] = ode45(sys_off, t_forced, zeros(4, 1));

% Package outputs
ss_results.A = A;
ss_results.B = B;
ss_results.C_ss = C_ss;
ss_results.D_ss = D_ss;
ss_results.eig_A = eig_A;
ss_results.t_free = t_out_free;
ss_results.z_free = z_free;
ss_results.t_forced = t_forced;
ss_results.z_res1 = z_res1;
ss_results.z_res2 = z_res2;
ss_results.z_off = z_off;

fprintf('State-space time simulations completed successfully.\n');

end
