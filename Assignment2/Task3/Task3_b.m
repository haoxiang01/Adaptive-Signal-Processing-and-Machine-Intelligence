%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 21-Mar-2024.
% + This is the implementation for 
% + 2.3. Adaptive Line Enhancer (ALE) Part b
%...............................................

clc
clear
close all
addpath('../Utils/');

%Initialization
w0 = 0.01 * pi;
sigma = 1;
N = 1000;
n = 1:N;
mu = 0.01;
epoch = 1000;
deltas = 0:25;
M = [5,10,15,20]; % Order
MSPEs = zeros(length(deltas),1);
fontsize = 20;
lineWidth = 2;

x = sin(w0 .* n);

colors = ['r','g','b','m','c','y','k'];
markers = {'o',  's', '^', 'x', 's', 'd', '^', 'v', '>', '<', 'p', 'h'};
for m = 1:length(M)
    for i = deltas
        PSEs = zeros(epoch, 1);
        for j = 1:epoch
            eta = randn(N,1);
            noise = filter([1,0,0.5], 1, eta);
            x_noise = x' + noise;
            [x_hat,~,~] = fLMS_ALE(x_noise, mu, M(m), i);
            PSEs(j) = mean((x' - x_hat).^2);
        end
        MPSE = mean(PSEs);
        MSPEs(i+1,:) = MPSE;
    end


% Plotting
plot(deltas, 10*log10(MSPEs),'Marker',markers{m},'Color', colors(m),'LineWidth',lineWidth);
hold on;grid on;
end
set(gca, 'FontSize', 16);
legend('$M$ = 5','$M$ = 10','$M$ = 15','$M$ = 20','FontSize',fontsize,'interpreter','latex','Location', 'northeast');
xlabel('Delay $\Delta$','FontSize',fontsize,'interpreter','latex');
ylabel('MSPE $(dB)$','FontSize',fontsize,'interpreter','latex');
xlim([0,25]);
set(gcf, 'Position', [100, 100, 800, 600]); 