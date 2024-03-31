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
fontsize = 25;
lineWidth = 2;

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

x = sin;% adjust here for sin
%ACF
[rx_biased, lagsx_biased] = xcorr(x, 'biased'); % ACF
[rx_unbiased, lagsx_unbiased] = xcorr(x, 'unbiased'); % ACF

%% Plot Sin wave
figure;
subplot(2,1,1);
plot(lagsx_unbiased, rx_unbiased, 'r', 'LineWidth', lineWidth);
hold on;
plot(lagsx_biased, rx_biased, 'b', 'LineWidth', lineWidth);
set(gca, 'FontSize', 18);
title('$\textbf{ACF}$', 'FontSize',fontsize,'interpreter','latex');
xlabel('Time lag (s)', 'FontSize',fontsize,'interpreter','latex');
ylabel('Amplitude', 'FontSize',fontsize,'interpreter','latex');
legend('UnBiased', 'Biased', 'FontSize',20,'interpreter','latex','Location', 'northeast');
grid on;
hold off;
set(gcf, 'Position', [100, 100, 800, 600]);
set(gcf, 'Color', 'w');

% Correlogram
subplot(2,1,2);
% figure;
[Pxx_biased, fx_biased] = fcorrgram(rx_biased, nfft, Fs, lagsx_biased);
[Pxx_unbiased, fx_unbiased]= fcorrgram(rx_unbiased, nfft, Fs, lagsx_unbiased);

plot(fx_unbiased, Pxx_unbiased, 'LineWidth', lineWidth, 'Color', 'r', 'LineStyle', '-'); 
hold on;
plot(fx_biased, Pxx_biased, 'LineWidth', lineWidth, 'Color', 'b', 'LineStyle', '-');
set(gca, 'FontSize', 18);
title('$\textbf{Correlogram}$', 'FontSize',fontsize,'interpreter','latex');
xlabel('Frequency (Hz)', 'FontSize',fontsize,'interpreter','latex');
ylabel('Power/Freq', 'FontSize',fontsize,'interpreter','latex');
legend('UnBiased', 'Biased', 'FontSize',20,'interpreter','latex', 'Location', 'northeast');
grid on;
hold off;
set(gcf, 'Position', [100, 100, 800, 700]);
set(gcf, 'Color', 'w');