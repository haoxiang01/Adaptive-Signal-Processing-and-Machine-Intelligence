%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 3.d 
%...............................................
clc
clear
close all
addpath('../Utils/');

% Parameters
Fs = 1; % Sampling frequency                    
T = 1/Fs; % Sampling period       
N_sets =[30, 45, 60]; % Length of signal
color_sets = ['r','g','b'];
nfft = 1024;
sampleNum = 100; % number of samples

figure;
for i=1:length(N_sets)
    N = N_sets(i); 
    t = (0:N-1)*T; 
    noise = 0.2/sqrt(2)*(randn(1,N)+1i*randn(1,N));
    x = exp(1j*2*pi*0.3*t)+exp(1i*2*pi*0.32*t)+ noise;
    [Pxx, fx] = periodogram(x,[],nfft,Fs);
    plot(fx, 10*log10(Pxx), 'Color', color_sets(i) ,'LineWidth', 2);
    hold on;
end
xlabel('Frequency (Hz)', 'Interpreter', 'latex');
ylabel('Power/Frequency (dB/Hz)', 'Interpreter', 'latex');
legend('30', '45','60','Location', 'best');
grid on;
hold off;
set(gcf, 'Color', 'w');



