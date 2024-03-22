function [eta,x_hat,weights] = fLMS_ANC(u,s,mu,M)
    N = length(u);
    weights = zeros(M,N);
    w = zeros(M,1);
    x_hat = zeros(N,1);
    eta = zeros(N,1);
    for k = M+1:N
        uk = u(k:-1:k-M+1);
        dk = s(k);
        xk = w'*uk;
        ek = dk - xk;
        w = w + mu*ek *uk;
        x_hat(k) = ek;
        eta(k) = xk;
        weights(:,k) = w;
    end
end

