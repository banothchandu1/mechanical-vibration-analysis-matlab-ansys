function frf_results = harmonic_frequency_sweep(M, K, C, f_start, f_end, num_points)
% HARMONIC_FREQUENCY_SWEEP - Computes Frequency Response Functions (FRF) Receptance.
%
% Solves: (-omega^2 * M + 1i * omega * C + K) * X(omega) = F(omega)
% Receptance matrix: H(omega) = (-omega^2 * M + 1i * omega * C + K)^(-1)
%
% Inputs:
%   M          - Mass matrix [kg]
%   K          - Stiffness matrix [N/m]
%   C          - Damping matrix [N*s/m]
%   f_start    - Start frequency [Hz] (Default: 0.5)
%   f_end      - End frequency [Hz] (Default: 20.0)
%   num_points - Number of frequency evaluation points (Default: 1000)
%
% Project: Mechanical Vibration Analysis Using MATLAB & ANSYS
% Institution: NIT Hamirpur (Department of Mechanical Engineering)

if nargin < 4, f_start = 0.5; end
if nargin < 5, f_end = 20.0; end
if nargin < 6, num_points = 1000; end

fprintf('\n========================================================\n');
fprintf('     HARMONIC FREQUENCY SWEEP & RECEPTANCE FRF          \n');
fprintf('========================================================\n');

f_vec = linspace(f_start, f_end, num_points);
omega_vec = 2 * pi * f_vec;

H11 = zeros(1, num_points);
H21 = zeros(1, num_points);
H12 = zeros(1, num_points);
H22 = zeros(1, num_points);

for i = 1:num_points
    w = omega_vec(i);
    Z = -w^2 * M + 1i * w * C + K; % Dynamic impedance / stiffness matrix
    H = inv(Z);
    H11(i) = H(1, 1);
    H21(i) = H(2, 1);
    H12(i) = H(1, 2);
    H22(i) = H(2, 2);
end

% Identify peak frequencies and resonance values
[max_H22_1, idx1] = max(abs(H22(f_vec < 7.0)));
[max_H22_2, idx2_rel] = max(abs(H22(f_vec >= 7.0)));
idx2 = idx2_rel + sum(f_vec < 7.0);

fprintf('Peak 1 Resonance: f = %.4f Hz, Receptance |H22| = %.6e m/N (%.3f mm/N)\n', ...
    f_vec(idx1), max_H22_1, max_H22_1 * 1000);
fprintf('Peak 2 Resonance: f = %.4f Hz, Receptance |H22| = %.6e m/N (%.3f mm/N)\n', ...
    f_vec(idx2), max_H22_2, max_H22_2 * 1000);

frf_results.f_vec = f_vec;
frf_results.omega_vec = omega_vec;
frf_results.H11 = H11;
frf_results.H21 = H21;
frf_results.H12 = H12;
frf_results.H22 = H22;
frf_results.peak1_f = f_vec(idx1);
frf_results.peak1_amp = max_H22_1;
frf_results.peak2_f = f_vec(idx2);
frf_results.peak2_amp = max_H22_2;

end
