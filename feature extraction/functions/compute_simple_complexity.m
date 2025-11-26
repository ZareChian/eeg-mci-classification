function [c] = compute_simple_complexity(signal)
% COMPUTE_SIMPLE_COMPLEXITY Calculate complexity measure based on signal variance
% Input: signal - 1D time series
% Output: c - complexity value

    eegvar0 = var(signal);          % Variance of original signal
    eegdiff1 = diff(signal);        % First derivative
    eegvar1 = var(eegdiff1);        % Variance of first derivative
    eegdiff2 = diff(eegdiff1);      % Second derivative  
    eegvar2 = var(eegdiff2);        % Variance of second derivative
    % Calculate complexity measure
    c = sqrt((eegvar2/eegvar1) - (eegvar1/eegvar0));
end