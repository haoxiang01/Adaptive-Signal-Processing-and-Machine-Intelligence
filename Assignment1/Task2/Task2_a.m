%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 03-Feb-2024.
% + This is the implementation for
% + 1.2 Periodogram-based Methods Applied to Real–World Data
% + Task a: Sunspot Time Series
%...............................................

clc
clear
close all

% Load the sunspot dataset
load sunspot.dat
year = sunspot(:,1);
sunspot_series = sunspot(:,2);
N = length(sunspot_series);
Fs=1; %Sampling frequency - One value per year

%% Remove Mean
sunspot_meanSub = sunspot_series - mean(sunspot_series);

psd_raw = periodogram(sunspot_series,hamming(length(sunspot_series)),[],1);
psd_rm = periodogram(sunspot_meanSub,hamming(length(sunspot_meanSub)),[],1);

%% Removed Trend
sunspot_detrend = detrend(sunspot_series);
psd_detrend = periodogram(sunspot_detrend,hamming(length(sunspot_detrend)),[],1);
%% Apply logarithm to data
sunspot_log = 10*log10(sunspot_series);
sunspot_logMeanSub = sunspot_log - mean(sunspot_log(sunspot_log~=-Inf));

% Plotting
figure(1);

% plot 1: Original Sunspot Time Series
plot(year, sunspot_series, 'LineWidth', 1.5, 'Color', 'r');
hold on;
plot(year, sunspot_meanSub, 'LineWidth', 1.5, 'Color', 'g');

plot(year, sunspot_detrend, 'LineWidth', 1.5, 'Color', 'b');
title('Sunspot Time Series', 'FontSize', 12, 'FontWeight', 'Bold');
xlabel('Year', 'FontSize', 10);
ylabel('Relative Sunspot Numbers', 'FontSize', 10);
grid on;
set(gca, 'FontSize', 10);
legend('Original', 'Mean Removed', 'Trend Removed','FontSize', 10,'interpreter','latex');

figure(2);
hold on;
plot(10*log10(psd_raw), 'LineWidth', 1.5, 'Color', 'r', 'DisplayName', 'Original');
plot(10*log10(psd_rm), 'LineWidth', 1.5, 'Color', 'g', 'DisplayName', 'Mean Removed');
plot(10*log10(psd_detrend), 'LineWidth', 1.5, 'Color', 'b', 'DisplayName', 'Trend Removed');
hold off;
title('Spectral Estimates Comparison', 'FontSize', 12, 'FontWeight', 'Bold');
xlabel('Frequency (Years^{-1})', 'FontSize', 10);
ylabel('Power Spectral Density (dB/Hz)', 'FontSize', 10);
legend('show', 'Location', 'best');
grid on;
set(gca, 'FontSize', 10);

figure(3);
plot(year, sunspot_series, 'LineWidth', 1.5, 'Color', 'r');
hold on;
plot(year, sunspot_logMeanSub, 'LineWidth', 1.5, 'Color', 'b');
title('Sunspot Time Series', 'FontSize', 12, 'FontWeight', 'Bold');
xlabel('Year', 'FontSize', 10);
ylabel('Relative Sunspot Numbers', 'FontSize', 10);
grid on;
set(gca, 'FontSize', 10);
legend('Original', 'Logarithmic Mean Removed', 'FontSize', 10,'interpreter','latex');
