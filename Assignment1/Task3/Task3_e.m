%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 3.e
%...............................................
clc
clear
close all
addpath('../Utils/');
fontsize = 30;
lineWidth = 3;

% Parameters
Fs = 1; % Sampling frequency                    
T = 1/Fs; % Sampling period       
N = 30; % Length of signal
t = (0:N-1)*T;
nfft = 1024;
sampleNum = 100; % number of samples

% Signal
noise = 0.2/sqrt(2)*(randn(1,N)+1i*randn(1,N));
x = exp(1j*2*pi*0.3*t)+exp(1i*2*pi*0.32*t)+ noise;

[X,R] = corrmtx(x,14,'mod');
[S,F] = pmusic(R,2,[ ],1,'corr');
plot(F,S,'-b','linewidth',lineWidth); set(gca,'xlim',[0.25 0.40]);
set(gca, 'FontSize', 20);
grid on; xlabel('Hz','FontSize',fontsize,'interpreter','latex'); 
ylabel('Pseudospectrum','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 650]);
