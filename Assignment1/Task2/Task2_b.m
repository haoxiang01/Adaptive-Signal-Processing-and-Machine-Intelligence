%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 03-Feb-2024.
% + This is the implementation for
% + 1.2 Periodogram-based Methods Applied to Real–World Data
% + Task-b: an electroencephalogram (EEG) experiment
%...............................................

clc
clear
close all
fontsize = 35;
lineWidth = 2;

addpath('../Utils/')
load('../data/EEG_Data_Assignment1.mat');
% Parameters
N = length(POz); % Number of samples in the EEG data
dt = 1/fs; % Time resolution
t = (0:N-1)*dt; 
nfft = 5*fs;

%% Standard Periodogram
% [Pxx_standard, f_standard] = fPSD(POz, fs, nfft, 'def2');
[Pxx_standard, f_standard] = periodogram(POz,[],nfft,fs);

figure(1);
plot(f_standard, 10*log10(Pxx_standard), 'b', 'LineWidth', lineWidth);

%% Bartlett's Method
tLen = 10; 
wLen = tLen / dt; % window length
[Px_bartlett_10, f_bartlett_10] = fBartlett(POz,fs,nfft,wLen);
hold on;
plot(f_bartlett_10, 10*log10(Px_bartlett_10), 'r', 'LineWidth', lineWidth);
set(gca, 'FontSize', 20);
% title("Standard VS 10s-Bartlett's");
xlabel('Frequency (Hz)', 'FontSize',fontsize,'interpreter','latex');
ylabel('Power/Frequency (dB/Hz)', 'FontSize',fontsize,'interpreter','latex');
xlim([0 60]);
grid on;
legend('Standard', "10s-Bartlett's", 'FontSize',20,'interpreter','latex','Location', 'northeast');
hold off;
set(gcf, 'Position', [100, 100, 800, 600]);

tLen = 5; 
wLen = tLen / dt; % window length
[Px_bartlett_5, f_bartlett_5] = fBartlett(POz,fs,nfft,wLen);

tLen = 1; 
wLen = tLen / dt; % window length
[Px_bartlett_1, f_bartlett_1] = fBartlett(POz,fs,nfft,wLen);

figure(2);
plot(f_bartlett_10, 10*log10(Px_bartlett_10), 'r', 'LineWidth', lineWidth);
hold on;
plot(f_bartlett_5, 10*log10(Px_bartlett_5), 'g', 'LineWidth', lineWidth);
plot(f_bartlett_1, 10*log10(Px_bartlett_1), 'b', 'LineWidth', lineWidth);
set(gca, 'FontSize', 20);
% title("Bartlett's Periodogram", 'FontSize',fontsize,'interpreter','latex');
xlabel('Frequency (Hz)', 'FontSize',fontsize,'interpreter','latex');
ylabel('Power/Frequency (dB/Hz)', 'FontSize',fontsize,'interpreter','latex');
xlim([11 20]);
grid on;
legend("10s-Bartlett's","5s-Bartlett's","1s-Bartlett's", 'FontSize',20,'interpreter','latex','Location', 'northeast');
set(gcf, 'Position', [100, 100, 800, 600]);



