function [segmented_data] = segment_data(eeg_data)
% SEGMENT_DATA Extract 40-220 seconds and divide into 18 non-overlapping windows of 10s
% Input: eeg_data - 2D matrix (19 channels × samples)
% Output: segmented_data - 3D matrix (18 windows × 2560 samples × 19 channels)

    % Fixed parameters
    fs = 256;               % Sampling frequency
    start_time = 40;        % Start time in seconds
    end_time = 220;         % End time in seconds 
    window_length_sec = 10; % Window length in seconds
    num_windows = 18;       % Number of windows
    num_channels = 19;      % Number of channels
    
    start_sample = (start_time * fs) + 1;
    end_sample = (end_time * fs);
    eeg_segment = eeg_data(:, start_sample:end_sample);
    window_length_samples = window_length_sec * fs;  % 10s × 256Hz = 2560 samples

    % Initialize output matrix (18 windows × 2560 samples × 19 channels)
    segmented_data = zeros(num_windows, window_length_samples, num_channels);
    
    % Segment into 18 non-overlapping windows
    for win = 1:num_windows
        start_win = (win - 1) * window_length_samples + 1;
        end_win = win * window_length_samples;
        segmented_data(win, :, :) = eeg_segment(:, start_win:end_win)';
    end
end