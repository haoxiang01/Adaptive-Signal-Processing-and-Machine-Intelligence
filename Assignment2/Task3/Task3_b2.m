
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
epoch = 100;
delta = 3;
M = 1:20; % Order
MSPEs = zeros(1,length(M));
fontsize = 20;
lineWidth = 2;

x = sin(w0 .* n);

colors = ['r','g','b','m','c','y','k'];
markers = {'o',  's', '^', 'x', 's', 'd', '^', 'v', '>', '<', 'p', 'h'};
for m = 1:length(M)
    PSEs = zeros(epoch, 1);
    for j = 1:epoch
        eta = randn(N,1);
        noise = filter([1,0,0.5], 1, eta);
        x_noise = x' + noise;
        [x_hat,~,~] = fLMS_ALE(x_noise, mu, M(m), delta);
        PSEs(j) = mean((x' - x_hat).^2);
    end
    MPSE = mean(PSEs);
    MSPEs(m) = MPSE;
end

% Plotting
plot(M, 10*log10(MSPEs),'r','Marker','o','LineWidth',lineWidth);
grid on;
set(gca, 'FontSize', 16);
% legend('$M$ = 5','$M$ = 10','$M$ = 15','$M$ = 20','FontSize',fontsize,'interpreter','latex','Location', 'southeast');
xlabel('Order $M$','FontSize',fontsize,'interpreter','latex');
ylabel('MSPE $(dB)$','FontSize',fontsize,'interpreter','latex');
xlim([1,20]);
set(gcf, 'Position', [100, 100, 800, 600]); 