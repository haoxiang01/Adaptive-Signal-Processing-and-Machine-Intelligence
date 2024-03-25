%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 21-Mar-2024.
% + This is the implementation for 
% + 2.3. Adaptive Line Enhancer (ALE) Part a
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
epoch = 100;
deltas = 4;
M = 5; % Order
fontsize = 18;
lineWidth = 2;

x = sin(w0 .* n);

% loop with deltas
for i = 1:1:deltas
    x_hat_sum = zeros(N,1);
    for j = 1:epoch
        eta = randn(N,1);
        noise = filter([1,0,0.5], 1, eta);
        x_noise = x' + noise;
        [x_hat,~,~] = fLMS_ALE(x_noise,mu,M,i);
        x_hat_sum = x_hat_sum + x_hat;
    end
    x_hat_avg = x_hat_sum ./ epoch;
    
    subplot(2,2,i);
    hold on;
    % plot(noise, '-c', 'LineWidth', 1);
    plot(x, '-b', 'LineWidth', lineWidth);
    plot(x_hat_avg, '-r', 'LineWidth', lineWidth);
    legend({'Groundtruth', 'Estimation'}, 'FontSize', fontsize, 'Interpreter', 'latex','Location', 'southeast');
    title(['Delay $\Delta$ = ' num2str(i)], 'FontSize', fontsize, 'Interpreter', 'latex');
    xlabel('Step $n$', 'FontSize', fontsize, 'Interpreter', 'latex');
    ylabel('Magnitude', 'FontSize', fontsize, 'Interpreter', 'latex');
    set(gca, 'FontSize', fontsize);
    set(gcf, 'Position', [100, 100, 800, 600]); 
    grid on;
end
