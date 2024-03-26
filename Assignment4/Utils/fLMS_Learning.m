function [y_hat, weights, errors] = fLMS_Learning(x, mu, M, opt, a, bias, pt_epoch)
% fLMS_learning Executes gradient descent for LMS estimation.
%   weights - Dynamics of learned weight.
%   errors - Dynamics of prediction error.
%   y_hat - Predicted output.
%   x - Input signal.
%   M - Filter order.
%   mu - Step size/learning rate.
%   opt - choice of activation function variant.
%   bias - Flag for optional bias.
%   pretrain - epoch of pretrain.

    if nargin < 4, opt = ''; end
    if nargin < 5, a = 1; end
    if nargin < 6, bias = false; end
    if nargin < 7, pt_epoch = 0; end

    N = length(x);

    if bias
        wn = zeros(M+1, 1);
        weights = zeros(M+1, N);
    else
        wn = zeros(M, 1);
        weights = zeros(M, N);
    end

    if pt_epoch > 0
        wn = fPretrain(x, mu, M, a, pt_epoch);
    end

    errors = zeros(N, 1);
    y_hat = zeros(N, 1);
    
    for n = M+1:N
        xn = x(n-1:-1:n-M);

        if bias
            xn = [1;xn];
        end

        if strcmp(opt, 'tanh')
             yn = a * tanh(wn' * xn);
        else
             yn = wn' * xn;
        end

        en = x(n) - yn;
        wn = wn + mu * en * xn;

        y_hat(n) = yn;
        weights(:,n) = wn;
        errors(n) = en;
    end
end
