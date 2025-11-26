function [features] = extract_subject_features(eeg_data, subject_id)
% EXTRACT_SUBJECT_FEATURES Extract features for one subject
% Input: eeg_data - 2D (19 channels × samples), subject_id
% Output: features structure with window-level features

    % Step 1: Segment data (40-220 seconds, 18 windows of 10s without overlapping )
    segmented_data = segment_data(eeg_data);
    [num_windows, ~, num_channels] = size(segmented_data);
    
    % Initialize feature structure
    features = struct();
    features.subject_id = subject_id;
    
    % Preallocate feature arrays (windows × channels)
    % Complexity features
    features.LZC = zeros(num_windows, num_channels);
    features.SimpleComp = zeros(num_windows, num_channels);
    % Standard Band Power Features
    features.BPS_delta = zeros(num_windows, num_channels);
    features.BPS_theta = zeros(num_windows, num_channels);
    features.BPS_alpha = zeros(num_windows, num_channels);
    features.BPS_beta = zeros(num_windows, num_channels);
    features.BPS_gamma = zeros(num_windows, num_channels);
    % Narrow Band Power Features
    features.BPN_delta = zeros(num_windows, num_channels);    % 2-3 Hz
    features.BPN_theta = zeros(num_windows, num_channels);    % 5-6 Hz
    features.BPN_alphai = zeros(num_windows, num_channels);   % 9-10 Hz
    features.BPN_alphaii = zeros(num_windows, num_channels);  % 10-11 Hz
    features.BPN_alphaiii = zeros(num_windows, num_channels); % 11-12 Hz
    features.BPN_betai = zeros(num_windows, num_channels);    % 14-15 Hz
    features.BPN_betaii = zeros(num_windows, num_channels);   % 19-21 Hz
    
    % Step 2: Extract features for each window and channel
    for win = 1:num_windows
        for ch = 1:num_channels
            signal = squeeze(segmented_data(win, :, ch));
            
            % 2.1 Lempel-Ziv Complexity
            binary_signal = binarize(signal);
            features.LZC(win, ch) = calc_lz_complexity(binary_signal, 'primitive', 1);
            
            % 2.2 Simple Complexity
            features.SimpleComp(win, ch) = compute_simple_complexity(signal);
            
            % 2.3 Relative Band Power Features
            total_power = bandpower(signal, 256, [0.5 35]); % fs = 256
            if total_power > 0
                % Standard Band Powers
                features.BPS_delta(win, ch) = 100 * bandpower(signal, 256, [0.5 4]) / total_power;
                features.BPS_theta(win, ch) = 100 * bandpower(signal, 256, [4 8]) / total_power;
                features.BPS_alpha(win, ch) = 100 * bandpower(signal, 256, [8 13]) / total_power;
                features.BPS_beta(win, ch)  = 100 * bandpower(signal, 256, [13 25]) / total_power;
                features.BPS_gamma(win, ch) = 100 * bandpower(signal, 256, [25 35]) / total_power;
                % Narrow Band Powers
                features.BPN_delta(win, ch) = 100 * bandpower(signal, 256, [2 3]) / total_power;
                features.BPN_theta(win, ch) = 100 * bandpower(signal, 256, [5 6]) / total_power;
                features.BPN_alphai(win, ch) = 100 * bandpower(signal, 256, [9 10]) / total_power;
                features.BPN_alphaii(win, ch) = 100 * bandpower(signal, 256, [10 11]) / total_power;
                features.BPN_alphaiii(win, ch) = 100 * bandpower(signal, 256, [11 12]) / total_power;
                features.BPN_betai(win, ch) = 100 * bandpower(signal, 256, [14 15]) / total_power;
                features.BPN_betaii(win, ch) = 100 * bandpower(signal, 256, [19 21]) / total_power;
            end
        end
    end

    filename = sprintf('subject_%d_features.mat', subject_id);
    save(filename, 'features');
    
    fprintf('Subject %d complete', subject_id);
end