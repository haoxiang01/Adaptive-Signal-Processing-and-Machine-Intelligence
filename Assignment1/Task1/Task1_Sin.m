%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 03-Feb-2024.
% + This is the implementation for
% + 1.1. Properties of Power Spectral Density (PSD) 
%...............................................

clc
clear
close all
addpath('../Utils/');
fontsize = 35;
lineWidth = 3.5;
% Parameters
Fs = 1000; % Sampling frequency in Hz
T = 1/Fs; % Sampling period in s
L = 200; % Length of the signal
t = (0:L-1)*T; % Time vector
nfft = 2048;

% Sinusoidal signal x2(t) with WGN w(t)
f = 1024; % Frequency 
x = 0.5*sin(2*pi*f*t)+0.5*randn(1, length(t));% Sinusoid + WGN



% ACF and PSD Calculation
[acf_x, lags] = xcorr(x, 'biased'); % ACF
[pxx1_x, f_pxx1] = fPSD(x, Fs, nfft, 'def1');% PSD def1
[pxx2_x, f_pxx2] = fPSD(x, Fs, nfft, 'def2');% PSD def2

%Plotting
figure;

% Signal sequence
plot(t, x, 'b','LineWidth',  lineWidth);
set(gca, 'FontSize', 20);
% title('Sinusoidal Signal Sequence $x(t)$', 'Interpreter', 'latex');
xlabel('Time (s)', 'FontSize',fontsize,'interpreter','latex');
ylabel('Amplitude', 'FontSize',fontsize,'interpreter','latex');
grid on;
set(gcf, 'Position', [100, 100, 800, 600]);

% ACF
figure;
plot(lags*T, acf_x,'b', 'LineWidth', lineWidth);
% xlim([-0.05 0.05])
set(gca, 'FontSize', 20);
% title('ACF of Sinusoidal Signal $x(t)$', 'FontSize',fontsize,'interpreter','latex');
xlabel('Time lag (s)', 'FontSize',fontsize,'interpreter','latex');
ylabel('Amplitude', 'FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);
grid on;


figure;
hold on;
% PSD def1
plot(f_pxx1, 10*log10(pxx1_x), 'LineWidth', lineWidth, 'Color', 'r', 'LineStyle', '-');

% PSD def2
plot(f_pxx2, 10*log10(pxx2_x), 'LineWidth', lineWidth, 'Color', 'b', 'LineStyle', '--'); 
set(gca, 'FontSize', 20);
% title('PSD (Def-1 and Def-2) of Sinusoidal Signal $x(t)$', 'FontSize',fontsize,'interpreter','latex');
xlabel('Frequency (Hz)', 'FontSize',fontsize,'interpreter','latex');
ylabel('Power/Frequency (dB/Hz)', 'FontSize',fontsize,'interpreter','latex');
legend('PSD Def-1', 'PSD Def-2', 'FontSize',25,'interpreter','latex', 'Location', 'southeast');
grid on;
hold off;
set(gcf, 'Color', 'w');
set(gcf, 'Position', [100, 100, 800, 600]);