%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 3.c Plotting the PSD in dB.
%...............................................
clc
clear
close all
addpath('../Utils/');

% Parameters
Fs = 200; % Sampling frequency                    
T = 1/Fs; % Sampling period       
N = 32; % Length of signal
t = (0:N-1)*T; % time interval
nfft = 2048; % fft samples
sampleNum = 100; % number of samples


P_mean_db = zeros(nfft/2+1, 1);
P_sets_db = zeros(nfft/2+1, sampleNum);
figure;
subplot(2,1,1);

for i=1:sampleNum
    x = 0.8*sin(2*pi*40*t) + 1.1*sin(2*pi*70*t)+ 0.3*randn(1, length(t));% Sinusoid + WGN
    [rx_biased, lagsx_biased] = fcorr(x, 'biased'); % Biased ACF
    [Pxx_biased, fx_biased] = fcorrgram(rx_biased, nfft, Fs, lagsx_biased);
    plot(fx_biased, 10*log10(Pxx_biased),'-c');
    hold on;
    P_mean_db = P_mean_db + 10*log10(Pxx_biased);
    P_sets_db(:,i) = 10*log10(Pxx_biased);
end

P_mean_db = P_mean_db ./ sampleNum;
f_mean = fx_biased;
plot(f_mean, P_mean_db, '-b','LineWidth', 3);
title('PSD estimates (different realisations and mean)', 'Interpreter', 'latex');
xlabel('Frequency (Hz)', 'Interpreter', 'latex');
ylabel('Power/Frequency (Watt/Hz)', 'Interpreter', 'latex');
grid on;
set(gcf, 'Color', 'w');
hold off;

% Standard devition
P_std_db = sqrt(1/sampleNum * sum((P_sets_db - P_mean_db).^2, 2));
subplot(2,1,2);
f_std = fx_biased;
plot(f_std, P_std_db,'-r','LineWidth', 3);
title('Standard deviation of the PSD estimate', 'Interpreter', 'latex');
xlabel('Frequency (Hz)', 'Interpreter', 'latex');
ylabel('Power/Frequency (Watt/Hz)', 'Interpreter', 'latex');
grid on;
set(gcf, 'Color', 'w');
