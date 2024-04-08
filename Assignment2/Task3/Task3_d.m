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
fontsize = 35;
lineWidth = 2;

T = 1/fs; % sampling period
L = length(POz); % length of sequence

%% original signal
figure;
spectrogram(POz,1000,500,1024,fs);
colormap jet;
set(gca, 'FontSize', 20);
% title('Spectrum of original EEG (POz)','FontSize',fontsize,'interpreter','latex');
xlabel('Frequency (Hz)','FontSize',20,'interpreter','latex');
ylabel('Time (minutes)','FontSize',20,'interpreter','latex');
hcb=colorbar;
ylabel(hcb,'Power/frequency (dB/Hz)','FontSize',20,'interpreter','latex')
set(gcf, 'Position', [100, 100, 800, 600]); 

fig = gcf; 
fig.PaperPositionMode = 'auto'; 
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)]; 

print(fig, '2.3.4a.eps', '-depsc')
print(fig, '2.3.4a.pdf', '-dpdf', '-fillpage')

%% ANC
mu = 0.01;
M = 50;
sigma = 0.01;
n = (0:L-1) * T;
u = sin(2 * pi * 50 * n)' + sqrt(sigma) * randn(L,1); % reference signal
[~,x_hat,~] = fLMS_ANC(u, POz, mu, M);
figure;
spectrogram(x_hat,1000,500,1024,fs);
colormap jet;
%title(['Spectrum of denoised EEG ($\mu$ = ' num2str(mu) ', $M$ = ' num2str(M) ')'],'FontSize',fontsize,'interpreter','latex');
set(gca, 'FontSize', 25);
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
ylabel('Time (minutes)','FontSize',fontsize,'interpreter','latex');
hcb=colorbar;
% ylabel(hcb,'Power/frequency (dB/Hz)','FontSize',fontsize,'interpreter','latex')
set(gcf, 'Position', [100, 100, 800, 600]);

fig = gcf; 
fig.PaperPositionMode = 'auto'; 
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)]; 

print(fig, '2.3.4b.eps', '-depsc')
print(fig, '2.3.4b.pdf', '-dpdf', '-fillpage')
