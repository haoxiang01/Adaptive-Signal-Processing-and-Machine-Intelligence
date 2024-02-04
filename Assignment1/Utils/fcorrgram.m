function [PSD, f] = fcorrgram(acf, nfft, Fs, lag)
f = Fs*(0:(nfft/2))/nfft;

w = 0:2*pi/(nfft-1):2*pi;
e = exp(1i * w);

PSD = zeros(nfft,1);
for i = 1:nfft
    PSD(i) = sum(acf .* e(i).^lag);
end
PSD = real(PSD);
PSD = PSD(1:nfft/2+1);
end
