%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 
% + 1.4 Spectrum of Autoregressive Processes
%...............................................
clc;
clear variables;
close all;
addpath('../Utils/');
fontsize = 13;
% Number of samples
totalSamples = 10000;
% Coefficients of the AR process
arCoefficients = [2.76, -3.81, 2.65, -0.92]; 
% Number of frequency points
freqPoints = 1024;
% Order of the AR process
N = length(arCoefficients); 
noiseVariance = 1; 

% Generate AR Signal
arSignal = zeros(totalSamples+N,1);
ar_coeff_flip = flip(arCoefficients);
for i = N+1:totalSamples+N
    % add white noise
    arSignal(i) = ar_coeff_flip * arSignal(i-4:i-1) + sqrt(noiseVariance) * randn(1,1);
end
arSignal = arSignal(N+1:end); 
% Discard half
arSignal = arSignal(totalSamples/2:end);
normalizedFrequency = (0:2*pi/(freqPoints-1):2*pi)./pi;

% True PSD calculation
PSDTrue = fARSpectrum(arCoefficients, noiseVariance, freqPoints,''); 

%ACF
[rx_biased, lagsx_biased] = xcorr(arSignal, 'biased'); 


% Find the best model order
modelOrders = 2:14;
mseErrors = zeros(1,length(modelOrders)); 
for i = 1:length(modelOrders)
    PSDEstimated = fMEM(rx_biased, modelOrders(i), freqPoints, '');
    %MSE
    mseErrors(i) = mean((PSDTrue - PSDEstimated).^2);
end

figure;
subplot(2,1,1);
semilogy(modelOrders, mseErrors, 'r-*', 'LineWidth', 1); % Plot MSE vs. model order
xlabel('Model Order $p$', 'FontSize', fontsize, 'interpreter', 'latex'); 
ylabel('Mean Square Error', 'FontSize', fontsize, 'interpreter', 'latex'); 
grid on;


% Find the best model order with minimum MSE
[~, bestOrderIndex] = min(mseErrors); 
bestOrder = modelOrders(bestOrderIndex); 
PSDEstimatedBest = fMEM(rx_biased, bestOrder, freqPoints, 'dB'); 

subplot(2,1,2);
% Plot true PSD
plot(normalizedFrequency, 10*log10(PSDTrue), '-r', 'LineWidth', 1.5);
hold on;
% Plot best estimated PSD
plot(normalizedFrequency, PSDEstimatedBest, '-b', 'LineWidth', 1.5); 
grid on;
xlabel('Frequency', 'FontSize', fontsize, 'interpreter', 'latex'); 
ylabel('Power/Frequency (dB/Hz)', 'FontSize', fontsize, 'interpreter', 'latex'); 
xlim([0 1]); 
legend('True PSD', ['Best Estimated PSD (Model Order=' num2str(bestOrder) ')'], 'FontSize', 10, 'interpreter', 'latex', 'Location', 'best');
title('Power Spectral Density Estimation', 'FontSize', fontsize);

