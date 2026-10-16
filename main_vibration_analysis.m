% =========================================================================
% MASTER SCRIPT: MECHANICAL VIBRATION ANALYSIS OF 2-DOF STRUCTURAL SYSTEM
% =========================================================================
% Project Title: Mechanical Vibration Analysis Using MATLAB & ANSYS
% Institution:   National Institute of Technology (NIT) Hamirpur
% Department:    Mechanical Engineering
% Project Period: August 2025 - December 2025
%
% Description:
%   This master script coordinates the analytical, numerical, and frequency
%   domain vibration analysis of a 2-DOF mass-spring-damper structural model.
%   It calculates natural frequencies, mode shapes, state-space time histories,
%   frequency response functions (FRF), and exports numerical comparison tables.
%
% System Parameters:
%   Floor 1 Mass:      m1 = 10.0 kg
%   Floor 2 Mass:      m2 = 8.0 kg
%   Story Stiffness 1: k1 = 20,000 N/m (20 kN/m)
%   Story Stiffness 2: k2 = 12,000 N/m (12 kN/m)
%   Damping:           Rayleigh Proportional: C = beta * K (beta = 0.00125 s)
%                      c1 = 25.0 N*s/m, c2 = 15.0 N*s/m
% =========================================================================

clear; clc; close all;

fprintf('====================================================================\n');
fprintf('     NIT HAMIRPUR - MECHANICAL VIBRATION ANALYSIS CAPSTONE          \n');
fprintf('         2-DOF MDOF DYNAMIC MODELLING & SIMULATION                  \n');
fprintf('====================================================================\n\n');

%% 1. Define Physical System Matrices
m1 = 10.0;     % Mass of Floor 1 (kg)
m2 = 8.0;      % Mass of Floor 2 (kg)
k1 = 20000.0;  % Interstory Stiffness 1 (N/m)
k2 = 12000.0;  % Interstory Stiffness 2 (N/m)
c1 = 25.0;     % Interstory Damping 1 (N*s/m)
c2 = 15.0;     % Interstory Damping 2 (N*s/m)

M = [m1,  0.0;
     0.0, m2];

K = [k1 + k2, -k2;
    -k2,       k2];

C = [c1 + c2, -c2;
    -c2,       c2];

fprintf('Physical Parameters:\n');
fprintf('  m1 = %.1f kg, m2 = %.1f kg\n', m1, m2);
fprintf('  k1 = %.1f N/m, k2 = %.1f N/m\n', k1, k2);
fprintf('  c1 = %.1f N*s/m, c2 = %.1f N*s/m\n', c1, c2);

%% 2. Modal & Natural Frequency Analysis
modal_results = natural_frequency_analysis(M, K, C);

%% 3. State-Space Time Domain Simulation
ss_results = state_space_response(M, K, C, modal_results);

%% 4. Harmonic Frequency Response Analysis (Bode / FRF)
frf_results = harmonic_frequency_sweep(M, K, C, 0.5, 20.0, 1500);

%% 5. Graphical Visualizations & Engineering Plots
% Figure 1: Mode Shapes
fig1 = figure('Name', 'Mode Shapes', 'Color', 'w', 'Position', [100, 100, 700, 550]);
hold on; grid on; box on;
stories = [0, 1, 2];
plot([0, 0, 0], stories, 'k--', 'LineWidth', 2.0, 'DisplayName', 'Undeformed Static');
plot([0; modal_results.phi_norm(:, 1)], stories, 'b-o', 'LineWidth', 2.5, 'MarkerSize', 8, ...
    'DisplayName', sprintf('Mode 1 (In-Phase): f_1 = %.2f Hz', modal_results.f_n(1)));
plot([0; modal_results.phi_norm(:, 2)], stories, 'r-s', 'LineWidth', 2.5, 'MarkerSize', 8, ...
    'DisplayName', sprintf('Mode 2 (Out-of-Phase): f_2 = %.2f Hz', modal_results.f_n(2)));
yticks([0, 1, 2]);
yticklabels({'Ground (Fixed)', 'Floor 1 (m_1=10 kg)', 'Floor 2 (m_2=8 kg)'});
xlabel('Normalized Modal Displacement', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Elevation / Storey Level', 'FontSize', 12, 'FontWeight', 'bold');
title('2-DOF Undamped Mode Shapes (Normalized to Floor 1)', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 10);

% Figure 2: Free Vibration Decay
fig2 = figure('Name', 'Free Vibration Time Response', 'Color', 'w', 'Position', [150, 150, 800, 600]);
subplot(2, 1, 1);
plot(ss_results.t_free, ss_results.z_free(:, 1) * 1000, 'b-', 'LineWidth', 1.8);
grid on; ylabel('Displacement x_1 [mm]', 'FontWeight', 'bold');
title('Free Vibration Time Response (Initial Condition x_1(0)=20 mm)', 'FontSize', 13, 'FontWeight', 'bold');

subplot(2, 1, 2);
plot(ss_results.t_free, ss_results.z_free(:, 2) * 1000, 'r-', 'LineWidth', 1.8);
grid on; xlabel('Time [seconds]', 'FontWeight', 'bold');
ylabel('Displacement x_2 [mm]', 'FontWeight', 'bold');

% Figure 3: Harmonic Resonance Comparisons
fig3 = figure('Name', 'Resonance Comparison', 'Color', 'w', 'Position', [200, 200, 850, 750]);
subplot(3, 1, 1);
plot(ss_results.t_forced, ss_results.z_res1(:, 1) * 1000, 'b-', 'LineWidth', 1.5); hold on;
plot(ss_results.t_forced, ss_results.z_res1(:, 2) * 1000, 'r-', 'LineWidth', 1.5);
grid on; ylabel('Disp. [mm]', 'FontWeight', 'bold');
title(sprintf('Mode 1 Resonance Excitation (f = %.2f Hz, In-Phase Amplification)', modal_results.f_n(1)), 'FontWeight', 'bold');
legend('Floor 1', 'Floor 2', 'Location', 'northeast');

subplot(3, 1, 2);
plot(ss_results.t_forced, ss_results.z_res2(:, 1) * 1000, 'b-', 'LineWidth', 1.5); hold on;
plot(ss_results.t_forced, ss_results.z_res2(:, 2) * 1000, 'r-', 'LineWidth', 1.5);
grid on; ylabel('Disp. [mm]', 'FontWeight', 'bold');
title(sprintf('Mode 2 Resonance Excitation (f = %.2f Hz, Out-of-Phase Amplification)', modal_results.f_n(2)), 'FontWeight', 'bold');
legend('Floor 1', 'Floor 2', 'Location', 'northeast');

subplot(3, 1, 3);
plot(ss_results.t_forced, ss_results.z_off(:, 1) * 1000, 'b-', 'LineWidth', 1.5); hold on;
plot(ss_results.t_forced, ss_results.z_off(:, 2) * 1000, 'r-', 'LineWidth', 1.5);
grid on; xlabel('Time [seconds]', 'FontWeight', 'bold');
ylabel('Disp. [mm]', 'FontWeight', 'bold');
title('Off-Resonance Excitation (f = 7.00 Hz, Steady Non-Resonant Response)', 'FontWeight', 'bold');
legend('Floor 1', 'Floor 2', 'Location', 'northeast');

% Figure 4: Receptance Frequency Response Function (Bode)
fig4 = figure('Name', 'FRF Receptance Bode Plot', 'Color', 'w', 'Position', [250, 250, 850, 650]);
subplot(2, 1, 1);
plot(frf_results.f_vec, 20*log10(abs(frf_results.H11)), 'b-', 'LineWidth', 1.8, 'DisplayName', '|H_{11}|'); hold on;
plot(frf_results.f_vec, 20*log10(abs(frf_results.H21)), 'r-', 'LineWidth', 1.8, 'DisplayName', '|H_{21}|');
plot(frf_results.f_vec, 20*log10(abs(frf_results.H22)), 'g--', 'LineWidth', 1.8, 'DisplayName', '|H_{22}|');
xline(modal_results.f_n(1), 'b:', sprintf('f_1=%.2f Hz', modal_results.f_n(1)), 'LineWidth', 1.2);
xline(modal_results.f_n(2), 'r:', sprintf('f_2=%.2f Hz', modal_results.f_n(2)), 'LineWidth', 1.2);
grid on; ylabel('Magnitude [dB re 1 m/N]', 'FontWeight', 'bold');
title('Receptance FRF Magnitude & Phase vs. Excitation Frequency', 'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'southwest');

subplot(2, 1, 2);
plot(frf_results.f_vec, angle(frf_results.H11)*180/pi, 'b-', 'LineWidth', 1.8, 'DisplayName', 'Phase H_{11}'); hold on;
plot(frf_results.f_vec, angle(frf_results.H21)*180/pi, 'r-', 'LineWidth', 1.8, 'DisplayName', 'Phase H_{21}');
plot(frf_results.f_vec, angle(frf_results.H22)*180/pi, 'g--', 'LineWidth', 1.8, 'DisplayName', 'Phase H_{22}');
xline(modal_results.f_n(1), 'b:');
xline(modal_results.f_n(2), 'r:');
grid on; xlabel('Frequency [Hz]', 'FontWeight', 'bold');
ylabel('Phase Angle [deg]', 'FontWeight', 'bold');
yticks([-180, -90, 0, 90, 180]);
legend('Location', 'southwest');

fprintf('\nMaster vibration analysis script executed successfully.\n');
