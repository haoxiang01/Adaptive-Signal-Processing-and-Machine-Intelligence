function [wn] = fPretrain(x, mu, M, a, epoch)
    N = length(x);
    wn = zeros(M + 1,1);
    weights = zeros(M + 1,N);
    errors = zeros(N, 1);
    y = zeros(N, 1);
    for i = 1:epoch
    for n = M+1:M+20
        xn = x(n-1:-1:n-M);
        xn = [1;xn];
        yn = a*tanh(wn'*xn);
        en = x(n) - yn;
        wn = wn + mu * en * xn;

        y(n) = yn;
        weights(:,n) = wn;
        errors(n) = en;
    end
    end