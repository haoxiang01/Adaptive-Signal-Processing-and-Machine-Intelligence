function [error, weights] = fCLMS(x, y, M, mu)
    numSamples = length(x); 
    weights = zeros(M, numSamples); 
    error = zeros(1, numSamples); 
    h = zeros(M, 1); 
    
    for idx = M+1:numSamples
        inputSegment = x(idx-1:-1:idx-M);
        outputEstimate = h' * inputSegment;
        currentError = y(idx) - outputEstimate;
        % Update
        h = h + mu * conj(currentError) * inputSegment;
        weights(:, idx) = h;
        error(idx) = currentError;
    end

    % Trim
    weights = weights(:, M+1:end);
    error = error(M+1:end);
end
