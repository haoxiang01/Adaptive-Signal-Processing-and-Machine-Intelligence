function [acf, lag] = fcorr(x, type)
    N = length(x);

    if strcmp(type, 'biased')
        lag = -(N-1) : (N-1);
        acf = zeros(length(lag),1);
        for i = 1:length(lag)
            shift = lag(i);
            if shift >= 0
                acf(i) = sum(x(1:N-shift) .* x(1+shift:N)) / N;
            else
                shift = -shift; % Make shift positive for indexing
                acf(i) = sum(x(1+shift:N) .* x(1:N-shift)) / N;
            end
        end
    elseif strcmp(type, 'unbiased')
        lag = 0 : (N-1);
        acf = zeros(length(lag),1);
        for i = 1:length(lag)
            shift = lag(i);
            acf(i) = sum(x(1:N-shift) .* x(1+shift:N)) / (N-shift);
        end
    end

    lag = lag(:); % Ensure lag is a column vector
end