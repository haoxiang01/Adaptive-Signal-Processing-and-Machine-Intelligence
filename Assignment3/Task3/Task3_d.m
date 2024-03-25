%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for 
% + 3.3. A Real Time Spectrum Analyser Using Least Mean Square Part d
%...............................................

clc
clear
close all
addpath('../Utils/');
addpath('../EEG-dataset/');
fontsize = 20;
lineWidth = 1.5;

load 'EEG_Data_Assignment1.mat';

a = 1000;
N = 1200;
y = POz(a:a+N-1);

mu = 1;
[h,~] = fDFTCLMS(y,mu);
% H = abs(h).^2;
% medianH = 50*median(median(H));
% H(H > medianH) = medianH;

H = abs(h);
surf(1:N, (0:N-1).*fs/N, H,'LineStyle','none');
set(gca, 'FontSize', 12);
view(2);
colormap;
colorbar;
ylim([0 60])
ylabel('Frequancy (Hz)','FontSize',fontsize,'interpreter','latex');
xlabel('Time $n$','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);

