function [errors,weights] = fLMS(x, M, mu, leak)

w = zeros(M,1);
N = length(x);
errors = [];
weights = [];
for k = 3:N
    xk = [x(k-1); x(k-2)];
    ek = x(k) - w' * xk;
    w = (1 - mu * leak) * w + mu * ek *xk;
    errors = [errors ek];
    weights = [weights w];
end

end

