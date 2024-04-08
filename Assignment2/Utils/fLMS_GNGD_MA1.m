function [weights,errors] = fLMS_GNGD_MA1(x,eta, mu, rho, M)
    N = length(x);
    weights = zeros(M,N);
    errors = zeros(1,N);
    epsilon = zeros(1,N);
    epsilon(M+1) = 1/mu;
    for k = M+2:N
        xk = eta(k-1:-1:k-M);
        dk = x(k);
        wk = weights(:,k);
        ek = dk - wk'* xk;
        xk_1 = eta(k-2:-1:k-M-1);
        epsilon(k) = epsilon(k-1) - rho * mu * errors(k) * errors(k - 1) * xk' * xk_1 / ...
                                  (epsilon(k-2) + xk_1' * xk_1) ^ 2;
        epsilonk = epsilon(k);
        weights(:,k+1) = wk + 1 / (epsilonk + xk'*xk) * ek * xk;
        errors(k) = ek;
    end
end