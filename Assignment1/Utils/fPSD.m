function [pxx_x,f_pxx] = fPSD(input, Fs, nfft, type)

f_pxx = Fs*(0:(nfft/2))/nfft;

if strcmp(type, 'def1')
    disp('def1')
    r = input;
    pxx_x = abs(fft(r, nfft));
else
    disp('def2')
    x = input;
    N = length(x);
    pxx_x = abs(fft(x, nfft)).^2 ./ N;
end
   pxx_x = pxx_x(1:nfft/2+1);

end

