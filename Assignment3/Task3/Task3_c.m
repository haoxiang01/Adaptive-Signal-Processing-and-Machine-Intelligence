%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for 
% + 3.3. A Real Time Spectrum Analyser Using Least Mean Square Part c
%...............................................

clc
clear
close all
addpath('../Utils/');
fontsize = 20;
lineWidth = 1.5;

%% Initialization
N = 1500;
fs = 2000;

% frequency
f = zeros(1500,1);
n = 1:500;
f(n) = 100;
n = 501:1000;
f(n) = 100 + (n-500) / 2;
n = 1001:1500;
f(n) = 100 + ((n-1000)/25).^2;

% phase
phi = cumsum(f);
eta = sqrt(0.05) * (randn(1500,1) + 1i * randn(1500,1));
y = exp( 1i * (2*pi/fs * phi) ) + eta;

%% DFT-CLMS algorithm
mu = 1;
[h,~] = fDFTCLMS(y,mu);
% H = abs(h).^2;
% medianH = 50*median(median(H));
% H(H > medianH) = medianH;

H = abs(h);
surf(1:N, (0:N-1).*fs/N, abs(H),'LineStyle','none');
set(gca, 'FontSize', 12);
view(2);
ylim([0 600]);
ylabel('Frequancy (Hz)','FontSize',fontsize,'interpreter','latex');
xlabel('Time','FontSize',fontsize,'interpreter','latex');
colormap;
colorbar;
% title('Time-frequency Spectrum of FM Signal estimated by DFT-CLMS','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);
