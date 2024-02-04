function PSD = fARSpectrum(arCoeff, sigma2, nf, outputType)
    freq = linspace(0, pi, nf);
    PSD = zeros(size(freq));
    for i = 1:nf
        denominator = 1 - sum(arCoeff .* exp(-1j * 2 * pi * (i-1) / nf * (1:length(arCoeff))));
        PSD(i) = sigma2 / abs(denominator)^2;
    end
     % Convert to dB if requested
    if strcmp(outputType, 'dB')
        PSD = 10 * log10(PSD);
    end
end