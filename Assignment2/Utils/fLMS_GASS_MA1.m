function [w,e] = fLMS_GASS_MA1(x, eta, type, mu_initial, rho, M)
% fLMS_MA1 implements an LMS algorithm with GASS for a 1st-order MA process.
% Inputs:
%   x         - Input data vector.
%   eta       - Input signal vector for the LMS algorithm.
%   type      - Type of GASS method ('B', 'F', 'M', or others for no GASS).
%   mu_initial- Initial step size for the algorithm.
%   rho       - Learning rate for updating the step size.
%   M         - Order of the filter.
%
% Outputs:
%   w         - Weight matrix of the adaptive filter over time.
%   e         - Error vector between the desired signal and the filter output.

% Initialize variables
w = zeros(M, length(x));        % Weight matrix
mu = zeros(1, length(x));       % Step size vector
e = zeros(1, length(x));        % Error vector
phi = zeros(M, length(x));      % Auxiliary variable for GASS
mu(M+2) = mu_initial;           % Set initial step size

% Main loop to update weights and step size
for n = M+2:length(x)
    % Extract the current and previous input signal samples
    x_n = flip(eta(n-M:n-1));
    d_n = x(n);  
    w_n = w(:,n); 
    mu_n = mu(n); 
    e_n = d_n - w_n' * x_n;
    
    % Update weights
    w(:,n+1) = w_n + mu_n * e_n * x_n;
    e(n) = e_n; 
    
    
    x_n_1 = flip(x(n-M-1:n-2)); 
    
    % Update phi and mu based on the specified GASS method
    if strcmp(type, 'B') % Benveniste's method
        phi_n_1 = phi(:,n-1);
        phi_n = (eye(M) - mu(n-1) * (x_n_1 * x_n_1')) * phi_n_1 + e(n-1) * x_n_1;
        phi(:,n) = phi_n;
        mu(n+1) = mu_n + rho * e_n * x_n' * phi_n;
    elseif strcmp(type, 'F') % Farhang's method
        phi_n_1 = phi(:,n-1);
        phi_n = 0.5 * phi_n_1 + e(n-1) * x_n_1;
        phi(:,n) = phi_n;
        mu(n+1) = mu_n + rho * e_n * x_n' * phi_n;
    elseif strcmp(type, 'M') % Matthews's method
        phi_n = e(n-1) * x_n_1;
        phi(:,n) = phi_n;
        mu(n+1) = mu_n + rho * e_n * x_n' * phi_n; 
    else % No GASS method
        mu(n+1) = mu_n; % Keep step size constant
    end
end

end
