% Create feature matrix with subject IDs and labels

% collect all significant features from t-test analysis
significant_features = {};

% Lempel-Ziv Complexity features
[lz_ch, lz_win] = find(H_lz);
for i = 1:length(lz_ch)
    significant_features{end+1} = struct('type', 'LZC', 'channel', lz_ch(i), 'window', lz_win(i));
end

% Simple Complexity features
[c_ch, c_win] = find(H_c);
for i = 1:length(c_ch)
    significant_features{end+1} = struct('type', 'Complexity', 'channel', c_ch(i), 'window', c_win(i));
end

% Band Power (standard bands) features
bps_types = {'BPS_delta', 'BPS_theta', 'BPS_alpha', 'BPS_beta', 'BPS_gamma'};
bps_arrays = {H_BPS_delta, H_BPS_theta, H_BPS_alpha, H_BPS_beta, H_BPS_gamma};
for b = 1:length(bps_types)
    [ch, win] = find(bps_arrays{b});
    for i = 1:length(ch)
        significant_features{end+1} = struct('type', bps_types{b}, 'channel', ch(i), 'window', win(i));
    end
end

% Band Power (Narrow bands) features
bpn_types = {'BPN_delta', 'BPN_theta', 'BPN_alphai', 'BPN_alphaii', 'BPN_alphaiii', 'BPN_betai', 'BPN_betaii'};
bpn_arrays = {H_BPN_delta, H_BPN_theta, H_BPN_alphai, H_BPN_alphaii, H_BPN_alphaiii, H_BPN_betai, H_BPN_betaii};
for b = 1:length(bpn_types)
    [ch, win] = find(bpn_arrays{b});
    for i = 1:length(ch)
        significant_features{end+1} = struct('type', bpn_types{b}, 'channel', ch(i), 'window', win(i));
    end
end

% dDTF connectivity features
dDTF_types = {'dDTF_delta', 'dDTF_theta', 'dDTF_alpha', 'dDTF_beta', 'dDTF_gamma'};
dDTF_arrays = {H_dDTF_delta, H_dDTF_theta, H_dDTF_alpha, H_dDTF_beta, H_dDTF_gamma};
for b = 1:length(dDTF_types)
    [r1, r2] = find(dDTF_arrays{b});
    for i = 1:length(r1)
        significant_features{end+1} = struct('type', dDTF_types{b}, 'region1', r1(i), 'region2', r2(i));
    end
end

% GPDC connectivity features
GPDC_types = {'GPDC_delta', 'GPDC_theta', 'GPDC_alpha', 'GPDC_beta', 'GPDC_gamma'};
GPDC_arrays = {H_GPDC_delta, H_GPDC_theta, H_GPDC_alpha, H_GPDC_beta, H_GPDC_gamma};
for b = 1:length(GPDC_types)
    [r1, r2] = find(GPDC_arrays{b});
    for i = 1:length(r1)
        significant_features{end+1} = struct('type', GPDC_types{b}, 'region1', r1(i), 'region2', r2(i));
    end
end

% Display the number of significant features found
fprintf('Found %d significant features\n', length(significant_features));

% Initialize the feature matrix
num_mci = 11;
num_normal = 16;
total_subjects = num_mci + num_normal;
num_features = length(significant_features);

feature_matrix = zeros(total_subjects, num_features + 2); % ID and features and label

feature_matrix(:, 1) = (1:total_subjects)'; % Set subject IDs (1-11: MCI, 12-27: Normal)

% set the features for each subject
for subj = 1:total_subjects
    for feat = 1:num_features
        feature_type = significant_features{feat}.type;
        
        % Get the feature value based on subject group
        if subj <= num_mci 
            switch feature_type
                case 'LZC'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_LZC(subj, window, channel);
                case 'Complexity'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_SimpleComp(subj, window, channel);
                case 'BPS_delta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPS_delta(subj, window, channel);
                case 'BPS_theta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPS_theta(subj, window, channel);
                case 'BPS_alpha'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPS_alpha(subj, window, channel);
                case 'BPS_beta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPS_beta(subj, window, channel);
                case 'BPS_gamma'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPS_gamma(subj, window, channel);
                case 'BPN_delta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPN_delta(subj, window, channel);
                case 'BPN_theta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPN_theta(subj, window, channel);
                case 'BPN_alphai'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPN_alphai(subj, window, channel);
                case 'BPN_alphaii'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPN_alphaii(subj, window, channel);
                case 'BPN_alphaiii'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPN_alphaiii(subj, window, channel);
                case 'BPN_betai'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPN_betai(subj, window, channel);
                case 'BPN_betaii'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = mci_BPN_betaii(subj, window, channel);
                case 'dDTF_delta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_dDTF_delta(subj, r2, r1);
                case 'dDTF_theta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_dDTF_theta(subj, r2, r1);
                case 'dDTF_alpha'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_dDTF_alpha(subj, r2, r1);
                case 'dDTF_beta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_dDTF_beta(subj, r2, r1);
                case 'dDTF_gamma'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_dDTF_gamma(subj, r2, r1);
                case 'GPDC_delta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_GPDC_delta(subj, r2, r1);
                case 'GPDC_theta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_GPDC_theta(subj, r2, r1);
                case 'GPDC_alpha'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_GPDC_alpha(subj, r2, r1);
                case 'GPDC_beta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_GPDC_beta(subj, r2, r1);
                case 'GPDC_gamma'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = mci_GPDC_gamma(subj, r2, r1);
            end
            
        else 
            normal_idx = subj - num_mci;
            switch feature_type
                case 'LZC'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_LZC(normal_idx, window, channel);
                case 'Complexity'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_SimpleComp(normal_idx, window, channel);
                case 'BPS_delta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPS_delta(normal_idx, window, channel);
                case 'BPS_theta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPS_theta(normal_idx, window, channel);
                case 'BPS_alpha'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPS_alpha(normal_idx, window, channel);
                case 'BPS_beta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPS_beta(normal_idx, window, channel);
                case 'BPS_gamma'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPS_gamma(normal_idx, window, channel);
                case 'BPN_delta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPN_delta(normal_idx, window, channel);
                case 'BPN_theta'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPN_theta(normal_idx, window, channel);
                case 'BPN_alphai'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPN_alphai(normal_idx, window, channel);
                case 'BPN_alphaii'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPN_alphaii(normal_idx, window, channel);
                case 'BPN_alphaiii'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPN_alphaiii(normal_idx, window, channel);
                case 'BPN_betai'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPN_betai(normal_idx, window, channel);
                case 'BPN_betaii'
                    channel = significant_features{feat}.channel;
                    window = significant_features{feat}.window;
                    feature_matrix(subj, feat+1) = normal_BPN_betaii(normal_idx, window, channel);
                case 'dDTF_delta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_dDTF_delta(normal_idx, r2, r1);
                case 'dDTF_theta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_dDTF_theta(normal_idx, r2, r1);
                case 'dDTF_alpha'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_dDTF_alpha(normal_idx, r2, r1);
                case 'dDTF_beta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_dDTF_beta(normal_idx, r2, r1);
                case 'dDTF_gamma'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_dDTF_gamma(normal_idx, r2, r1);
                case 'GPDC_delta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_GPDC_delta(normal_idx, r2, r1);
                case 'GPDC_theta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_GPDC_theta(normal_idx, r2, r1);
                case 'GPDC_alpha'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_GPDC_alpha(normal_idx, r2, r1);
                case 'GPDC_beta'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_GPDC_beta(normal_idx, r2, r1);
                case 'GPDC_gamma'
                    r1 = significant_features{feat}.region1;
                    r2 = significant_features{feat}.region2;
                    feature_matrix(subj, feat+1) = normal_GPDC_gamma(normal_idx, r2, r1);
            end
        end
    end
    
    % Set label (0 for Normal, 1 for MCI)
    if subj <= num_mci
        feature_matrix(subj, end) = 1; 
    else
        feature_matrix(subj, end) = 0; 
    end
end

% Create column names
column_names = cell(1, num_features + 2);
column_names{1} = 'SubjectID';
for feat = 1:num_features
    feature_type = significant_features{feat}.type;
    
    if contains(feature_type, {'LZC', 'Complexity', 'BPS_', 'BPN_'})
        channel = significant_features{feat}.channel;
        window = significant_features{feat}.window;
        column_names{feat+1} = sprintf('%s_ch%d_w%d', lower(feature_type), channel, window);
    else
        r1 = significant_features{feat}.region1;
        r2 = significant_features{feat}.region2;
        column_names{feat+1} = sprintf('%s_r%d_r%d', lower(feature_type), r1, r2);
    end
end
column_names{end} = 'Label';

fprintf('Dimensions of Feature Matrix: %d subjects × %d columns\n', size(feature_matrix, 1), size(feature_matrix, 2));
fprintf('Columns: 1 SubjectID + %d features + 1 Label\n', num_features);

% Display first few rows to verify
fprintf('\nFirst 3 rows of feature matrix:\n');
disp(array2table(feature_matrix(1:3, 1:min(8, size(feature_matrix,2))), 'VariableNames', column_names(1:min(8, size(feature_matrix,2))));

save('feature_matrix.mat', 'feature_matrix');
