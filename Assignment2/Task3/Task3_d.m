%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 21-Mar-2024.
% + This is the implementation for 
% + 2.3. Adaptive Line Enhancer (ALE) Part d
%...............................................

clc
clear
close all
addpath('../Utils/');
addpath('../Data/');
load('EEG_Data_Assignment2.mat');
fontsize = 14;
lineWidth = 2;

T = 1/fs; % sampling period
L = length(POz); % length of sequence

%% original signal
figure;
spectrogram(POz,1000,500,1024,fs);
colormap hot;
title('Spectrum of EEG (POz)','FontSize',fontsize,'interpreter','latex');
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
ylabel('Time (minutes)','FontSize',fontsize,'interpreter','latex');
hcb=colorbar;
ylabel(hcb,'Power/frequency (dB/Hz)','FontSize',fontsize,'interpreter','latex')
set(gcf, 'Position', [100, 100, 800, 600]); 
%% ANC
mu = 0.01;
M = 10;
sigma = 0.01;
n = (0:L-1) * T;
u = sin(2 * pi * 50 * n)' + sqrt(sigma) * randn(L,1); % reference signal
[~,x_hat,~] = fLMS_ANC(u, POz, mu, M);
figure;
spectrogram(x_hat,1000,500,1024,fs);
colormap hot;
title('Spectrum of ANC denoised EEG (POz)','FontSize',fontsize,'interpreter','latex');
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
ylabel('Time (minutes)','FontSize',fontsize,'interpreter','latex');
hcb=colorbar;
ylabel(hcb,'Power/frequency (dB/Hz)','FontSize',fontsize,'interpreter','latex')
set(gcf, 'Position', [100, 100, 800, 600]); 
