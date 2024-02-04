function [PSD] = fMEM(acf, p, N, dB)
o = (length(acf)+1)/2;
% Calculate the correlation matrix
R = zeros(p+1, p+1);
for i=0:p
    acf_shift = circshift(acf,i);
    R(:,i+1) = acf_shift(o:o+p);
end
l = zeros(p+1,1);
l(1) = 1;

% Yule-Walker equation
result = inv(R) * l;
sigma_2 = 1/result(1);
ar_coeff = -result(2:end)' * sigma_2;

PSD = fARSpectrum(ar_coeff,sigma_2,N,dB);
end

