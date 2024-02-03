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

% Sinusoidal signal x2(t) with WGN w(t)
f = 200; % Frequency 
x = 0.7*sin(2*pi*300*t)+0.2*randn(1, length(t));% Sinusoid + WGN



% ACF and PSD Calculation
[acf_x, lags] = xcorr(x, 'biased'); % ACF
[pxx1_x, f_pxx1] = fPSD(x, Fs,'def1');% PSD def1
[pxx2_x, f_pxx2] = fPSD(x, Fs,'def2');% PSD def2

%Plotting
figure;

% Signal sequence
subplot(3,1,1)
plot(t, x, 'b','LineWidth',  1.5);
title('Signal Sequence $x_1(t)$', 'Interpreter', 'latex');
xlabel('Time (s)', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');
grid on;

% ACF
subplot(3,1,2)
plot(lags*T, acf_x,'b', 'LineWidth', 1.5);
title('ACF of Impulse Signal $x_1(t)$', 'Interpreter', 'latex');
xlabel('Time lag (s)', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');
grid on;


subplot(3,1,3)
hold on;
% PSD def1
plot(f_pxx1, 10*log10(pxx1_x), 'LineWidth', 2, 'Color', 'r', 'LineStyle', '-');

% PSD def2
plot(f_pxx2, 10*log10(pxx2_x), 'LineWidth', 2, 'Color', 'b', 'LineStyle', '--'); 

title('PSD (Def-1 and Def-2) of Signal $x_1(t)$', 'Interpreter', 'latex');
xlabel('Frequency (Hz)', 'Interpreter', 'latex');
ylabel('Power/Frequency (dB/Hz)', 'Interpreter', 'latex');
legend('PSD Def-1', 'PSD Def-2', 'Location', 'best');
grid on;
hold off;
set(gcf, 'Color', 'w');