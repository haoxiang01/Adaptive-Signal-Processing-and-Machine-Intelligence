%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for
% + 3.a. Unbiased correlation estimation and 
%   preservation of non-negative spectra.
%...............................................

clc
clear
close all
addpath('../Utils/');

% Parameters
Fs = 200; % Sampling frequency in Hz
T = 1/Fs; % Sampling period in s
N = 200; % Length of the signal
t = (0:N-1)*T; % Time vector
nfft = 2048;

% Sinusoidal signal with WGN w(t)
f = 1024; % Frequency 
wgn = randn(1, length(t));
sin = 0.8*sin(2*pi*40*t) + 1.1*sin(2*pi*70*t)+ 0.3*randn(1, length(t));
noiseFilter = filter([1/4 1/4 1/4 1/4], 1, wgn);

x = wgn;
%ACF
[rx_biased, lagsx_biased] = xcorr(x, 'biased'); % ACF
[rx_unbiased, lagsx_unbiased] = xcorr(x, 'unbiased'); % ACF

%% Plot Sin wave
figure(1);
subplot(2,1,1);
plot(lagsx_unbiased, rx_unbiased, 'r', 'LineWidth', 1.5);
hold on;
plot(lagsx_biased, rx_biased, 'b', 'LineWidth', 1.5);
title('ACF', 'Interpreter', 'latex');
xlabel('Time lag (s)', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');
legend('UnBiased', 'Biased', 'Location', 'best');
grid on;
hold off;

% Correlogram
subplot(2,1,2);
[Pxx_biased, fx_biased] = fcorrgram(rx_biased, nfft, Fs, lagsx_biased);
[Pxx_unbiased, fx_unbiased]= fcorrgram(rx_unbiased, nfft, Fs, lagsx_unbiased);

plot(fx_unbiased, Pxx_unbiased, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '-'); 
hold on;
plot(fx_biased, Pxx_biased, 'LineWidth', 1.5, 'Color', 'b', 'LineStyle', '-');

title('Correlogram', 'Interpreter', 'latex');
xlabel('Frequency (Hz)', 'Interpreter', 'latex');
ylabel('Power/Frequency (Watt/Hz)', 'Interpreter', 'latex');
legend('UnBiased', 'Biased', 'Location', 'best');
grid on;
hold off;
set(gcf, 'Color', 'w');