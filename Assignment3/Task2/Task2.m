%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for 
% + 3.2. Adaptive AR Model Based Time-Frequency Estimation
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


%% Plot FM
figure;
plot(1:1500,f,'-b','LineWidth',lineWidth);
set(gca, 'FontSize', 12);
xlabel('Time','FontSize',fontsize,'interpreter','latex'); 
ylabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
xlim([1,1500]);
ylim([0,500]);
grid on;
title('Frequency','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);

figure;
plot(wrapToPi(phi),'-b','LineWidth',lineWidth);
set(gca, 'FontSize', 12);
xlabel('Time','FontSize',fontsize,'interpreter','latex'); 
ylabel('Phase (rad)','FontSize',fontsize,'interpreter','latex');
title('Phase','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);

%% Task a: AR(1) model
a = aryule(y,1);
[h,w] = freqz(1, a, N, fs);
figure;
plot(w,pow2db(abs(h).^2),'b','Linewidth',2);
set(gca, 'FontSize', 12);
xlabel('Frequency (Hz)','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude (dB)','FontSize',fontsize,'interpreter','latex');
grid on;
title('Estimated Power Spectrum of FM Signal','FontSize',fontsize,'interpreter','latex')
set(gcf, 'Position', [100, 100, 800, 600]);

%% Task b: Adaptive AR(1) model
M = 1;
mu = 0.1;
[~,weights] = fCLMS(y, y, M, mu);
for n = 1:length(weights)
    [h,w] = freqz(1,[1; -conj(weights(n))], 1024, fs);
    H(:,n) = abs(h).^2;
end

medianH = 50*median(median(H));
H(H > medianH) = medianH;
figure;

[X,Y] = meshgrid(1:length(weights),w);
mesh(X,Y,H);
view(2);
colormap;
colorbar;
set(gca, 'FontSize', 12);
ylabel('Frequancy (Hz)','FontSize',fontsize,'interpreter','latex');
xlabel('Time','FontSize',fontsize,'interpreter','latex');
title('Estimated Time-frequency spectrum','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);
