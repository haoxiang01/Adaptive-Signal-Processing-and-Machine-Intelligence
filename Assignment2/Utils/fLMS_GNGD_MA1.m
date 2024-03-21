function [weights, errorSignal] = fLMS_GNGD_MA1(inputSignal, eta, stepSize, forgettingFactor, filterOrder)
%  fLMS_GNGD_MA1 Implements the Generalized Normalized Gradient Descent (GNGD) 
%  algorithm with Moving Average model of order 1 (MA1) for LMS adaptive filtering.
%  Inputs:  
%   - inputSignal: The input signal to the adaptive filter.
%   - eta: The reference signal for the adaptive filter.
%   - stepSize: The step size parameter (mu) for the algorithm.
%   - forgettingFactor: The forgetting factor (rho) used in updating the regularization factor.
%   - filterOrder: The order of the filter (M).


% Initialization
weights = zeros(filterOrder, length(inputSignal));
errorSignal = zeros(1, length(inputSignal));
regularizationFactor = zeros(1, length(inputSignal));
regularizationFactor(filterOrder+1) = 0.1; % Initial value for regularization factor
muAdaptive = zeros(1, length(inputSignal));

for n = filterOrder+2:length(inputSignal)
    inputSegment = flip(eta(n-filterOrder:n-1));
    desiredOutput = inputSignal(n);
    currentWeights = weights(:,n);
    currentError = desiredOutput - currentWeights' * inputSegment;
    
    % Update of the regularization factor
    inputSegmentPrev = flip(inputSignal(n-filterOrder-1:n-2));
    regularizationFactorPrev = regularizationFactor(n-1);
    regularizationFactor(n) = regularizationFactorPrev - forgettingFactor * stepSize ...
                              * (errorSignal(n)*errorSignal(n-1)*inputSegment'*inputSegmentPrev) ...
                              / ( regularizationFactorPrev + inputSegmentPrev' * inputSegmentPrev )^2;
    
    % Update of the weights
    weights(:,n+1) = currentWeights + stepSize / (regularizationFactor(n) + inputSegment'*inputSegment) ...
                     * currentError * inputSegment;
    errorSignal(n) = currentError;  
    muAdaptive(n) = stepSize / (regularizationFactor(n) + inputSegment'*inputSegment);
    
end

end

