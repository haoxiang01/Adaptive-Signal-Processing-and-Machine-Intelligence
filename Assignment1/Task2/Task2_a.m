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
fontsize = 35;
lineWidth = 2;

% Load the sunspot dataset
load sunspot.dat
year = sunspot(:,1);
sunspot_series = sunspot(:,2);
N = length(sunspot_series);
Fs=1; %Sampling frequency - One value per year

%% Remove Mean
sunspot_meanSub = sunspot_series - mean(sunspot_series);

[psd_raw, f1]= periodogram(sunspot_series,hamming(length(sunspot_series)),[],1);
[psd_rm, f2] = periodogram(sunspot_meanSub,hamming(length(sunspot_meanSub)),[],1);

%% Removed Trend
sunspot_detrend = detrend(sunspot_series);
[psd_detrend, f3] = periodogram(sunspot_detrend,hamming(length(sunspot_detrend)),[],1);
%% Apply logarithm to data
sunspot_log = 10*log10(sunspot_series);
sunspot_logMeanSub = sunspot_log - mean(sunspot_log(sunspot_log~=-Inf));

% Plotting
figure(1);

% plot 1: Original Sunspot Time Series
plot(year, sunspot_series, 'LineWidth', lineWidth, 'Color', 'r');
hold on;
plot(year, sunspot_meanSub, 'LineWidth', lineWidth, 'Color', 'g');

plot(year, sunspot_detrend, 'LineWidth', lineWidth, 'Color', 'b');
set(gca, 'FontSize', 20);
% title('Sunspot Time Series', 'FontSize', 20, 'FontWeight', 'Bold');
xlabel('Year', 'FontSize',fontsize,'interpreter','latex');
ylabel('Numbers', 'FontSize',fontsize,'interpreter','latex');
grid on;
legend('Original', 'Mean Removed', 'Trend Removed','FontSize', 20,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);

figure(2);
hold on;
plot(f1, 10*log10(psd_raw), 'LineWidth', lineWidth, 'Color', 'r', 'DisplayName', 'Original');
plot(f2, 10*log10(psd_rm), 'LineWidth', lineWidth, 'Color', 'g', 'DisplayName', 'Mean Removed');
plot(f3, 10*log10(psd_detrend), 'LineWidth', lineWidth, 'Color', 'b', 'DisplayName', 'Trend Removed');
hold off;
set(gca, 'FontSize', 20);
% title('Spectral Estimates Comparison', 'FontSize', 12, 'FontWeight', 'Bold');
xlabel('Normalized Frequency', 'FontSize', fontsize,'interpreter','latex');
ylabel('PSD (dB/Hz)', 'FontSize',fontsize,'interpreter','latex');
legend('show', 'FontSize',20,'interpreter','latex', 'Location', 'best');
grid on;
set(gcf, 'Position', [100, 100, 800, 600]);


figure(3);
plot(year, sunspot_series, 'LineWidth', lineWidth, 'Color', 'r');
hold on;
plot(year, sunspot_logMeanSub, 'LineWidth', lineWidth, 'Color', 'b');
set(gca, 'FontSize', 20);
% title('Sunspot Time Series', 'FontSize', 12, 'FontWeight', 'Bold');
xlabel('Year','FontSize', fontsize,'interpreter','latex');
ylabel('Numbers', 'FontSize', fontsize,'interpreter','latex');
grid on;
legend('Original', 'Logarithmic Mean Removed', 'FontSize', 20,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);