function [x_hat, weights, errors] = fLMS_ALE(x_noise, mu, order, delta)

% Initialize variables
N = length(x_noise);
weights = zeros(order, N);
w = zeros(order, 1);
x_hat = zeros(N, 1);
errors = zeros(N, 1);
x_delay = zeros(N+order+delta-1,1);
x_delay(order+delta:N+order+delta-1) = x_noise;

% Adaptive filtering
for k = 1:N
    input_vector = x_delay(k+order-1:-1:k);
    filtered_output = input_vector' * w;
    error_signal = x_delay(k+order+delta-1) - filtered_output;
    w = w + mu * error_signal * input_vector;
    errors(k) = error_signal;
    x_hat(k) = filtered_output;
    weights(:, k) = w;
end

end

