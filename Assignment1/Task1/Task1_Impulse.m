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

% Parameters
Fs = 1000; % Sampling frequency in Hz
T = 1/Fs; % Sampling period in s
L = 200; % Length of the signal
t = (0:L-1)*T; % Time vector

% Impulse signal x1(t)
x = zeros(1,L); % Initialize signal with zeros
x(1) = 10000; % Impulse at t=0



% ACF and PSD Calculation
[acf_x, lags] = xcorr(x, 'biased'); % ACF
[pxx1_x, f_pxx1] = fPSD(x, Fs,'def1');% PSD def1
[pxx2_x, f_pxx2] = fPSD(x, Fs,'def2');% PSD def2

%Plotting
figure;

% Signal sequence
subplot(4,1,1)
plot(t, x, 'LineWidth', 1.5);
title('Signal Sequence $x_1(t)$', 'Interpreter', 'latex');
xlabel('Time (s)', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');
grid on;

% ACF
subplot(4,1,2)
plot(lags*T, acf_x, 'LineWidth', 1.5);
title('ACF of Impulse Signal $x_1(t)$', 'Interpreter', 'latex');
xlabel('Time lag (s)', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');
grid on;

% PSD def1
subplot(4,1,3)
plot(f_pxx1, 10*log10(pxx1_x), 'LineWidth', 1.5);
title('Def-1 PSD of Impulse Signal $x_1(t)$', 'Interpreter', 'latex');
xlabel('Frequency (Hz)', 'Interpreter', 'latex');
ylabel('Power/Frequency (dB/Hz)', 'Interpreter', 'latex');
grid on;

% PSD def2
subplot(4,1,4)
plot(f_pxx2, 10*log10(pxx2_x), 'LineWidth', 1.5);
title('Def-2 PSD of Impulse Signal $x_1(t)$', 'Interpreter', 'latex');
xlabel('Frequency (Hz)', 'Interpreter', 'latex');
ylabel('Power/Frequency (dB/Hz)', 'Interpreter', 'latex');
grid on;
set(gcf, 'Color', 'w'); 