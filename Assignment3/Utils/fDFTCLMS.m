function [h_weights,errors] = fDFTCLMS(y,mu)
    numSamples = length(y);
    h_weights = zeros(numSamples,numSamples);
    errors = zeros(numSamples,1);
    w = zeros(numSamples,1);
    x = (1/numSamples) * exp(1i * (1:numSamples)' * 2 * pi * (0:(numSamples-1))/numSamples).';
    
    for n = 1:numSamples
        xn = x(:,n);
        yn_hat = w' * xn;
        en = y(n) - yn_hat;
        w = w + mu * conj(en) * xn;
        h_weights(:,n) = w;
        errors(n) = en;
    end
end