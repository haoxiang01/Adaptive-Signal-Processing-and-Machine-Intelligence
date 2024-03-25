function [errors, h_weights, g_weights] = fACLMS(x, y, M, mu)
    numSamples = length(x); 
    h_weights = zeros(M, numSamples); % weights matrix h(n)
    g_weights = zeros(M, numSamples); % weights matrix g(n)
    errors = zeros(1, numSamples); % error vector
    h = zeros(M, 1); % adaptive filter coefficients h
    g = zeros(M, 1); % adaptive filter coefficients g
    
    for n = M+1:numSamples
        xn = x(n-1:-1:n-M);
        yn = h' * xn + g' * conj(xn); 
        en = y(n) - yn; 
        
        % Update filter coefficients for h and g
        h = h + mu * conj(en) * xn; 
        g = g + mu * conj(en) * conj(xn);
        
        % Store current state
        h_weights(:, n) = h;
        errors(n) = en;
        g_weights(:, n) = g;
    end
    
    h_weights = h_weights(:, M+1:end);
    errors = errors(M+1:end);
    g_weights = g_weights(:, M+1:end);
end


