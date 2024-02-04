function [pxx,f] = fBartlett(x, Fs, nfft, wLen)
    N = length(x);
    if (nargin<4)
         wLen = N;
    end
    wNum = ceil(N / wLen);
    pxx = zeros(nfft/2+1,1);

    for i = 1:wNum
        sta = (i-1)*wLen+1;
        en = i*wLen;
        if en > N 
           en = N; 
        end
        x_sub = x(sta : en); 
        [pxx_segment, f] = periodogram(x_sub,[],nfft,Fs);
        pxx = pxx + pxx_segment;
    end
    
    pxx = pxx ./ wNum;
end
