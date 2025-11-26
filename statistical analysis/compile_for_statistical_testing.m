function compile_for_statistical_testing()
 
    % COMPILE_FOR_STATISTICAL_TESTING Compile all features for t-test analysis
    
    num_mci = 11;
    num_normal = 16;
    num_windows = 18;
    num_channels = 19;
    
    % Initialize arrays for each feature type (subject × window × channel)
    % MCI group (subjects 1-11)
    mci_LZC = zeros(num_mci, num_windows, num_channels);
    mci_SimpleComp = zeros(num_mci, num_windows, num_channels);
    mci_BPS_delta = zeros(num_mci, num_windows, num_channels);
    mci_BPS_theta = zeros(num_mci, num_windows, num_channels);
    mci_BPS_alpha = zeros(num_mci, num_windows, num_channels);
    mci_BPS_beta = zeros(num_mci, num_windows, num_channels);
    mci_BPS_gamma = zeros(num_mci, num_windows, num_channels);
    mci_BPN_delta = zeros(num_mci, num_windows, num_channels);
    mci_BPN_theta = zeros(num_mci, num_windows, num_channels);
    mci_BPN_alphai = zeros(num_mci, num_windows, num_channels);
    mci_BPN_alphaii = zeros(num_mci, num_windows, num_channels);
    mci_BPN_alphaiii = zeros(num_mci, num_windows, num_channels);
    mci_BPN_betai = zeros(num_mci, num_windows, num_channels);
    mci_BPN_betaii = zeros(num_mci, num_windows, num_channels);
    
    % Healthy group (subjects 12-27)
    normal_LZC = zeros(num_normal, num_windows, num_channels);
    normal_SimpleComp = zeros(num_normal, num_windows, num_channels);
    normal_BPS_delta = zeros(num_normal, num_windows, num_channels);
    normal_BPS_theta = zeros(num_normal, num_windows, num_channels);
    normal_BPS_alpha = zeros(num_normal, num_windows, num_channels);
    normal_BPS_beta = zeros(num_normal, num_windows, num_channels);
    normal_BPS_gamma = zeros(num_normal, num_windows, num_channels);
    normal_BPN_delta = zeros(num_normal, num_windows, num_channels);
    normal_BPN_theta = zeros(num_normal, num_windows, num_channels);
    normal_BPN_alphai = zeros(num_normal, num_windows, num_channels);
    normal_BPN_alphaii = zeros(num_normal, num_windows, num_channels);
    normal_BPN_alphaiii = zeros(num_normal, num_windows, num_channels);
    normal_BPN_betai = zeros(num_normal, num_windows, num_channels);
    normal_BPN_betaii = zeros(num_normal, num_windows, num_channels);
    
    % Load all extracted features from subjects
    all_features = cell(27, 1);
    for i = 1:27
        filename = sprintf('subject_%d_features.mat', i);
        load(filename, 'features');
        all_features{i} = features;
        fprintf('Loaded subject %d features\n', i);
    end
    
    % Separate MCI and Healthy subjects
    mci_idx = 1;
    normal_idx = 1;
       
    for i = 1:length(all_features)
        if all_features{i}.subject_id <= 11  % MCI group
            mci_LZC(mci_idx, :, :) = all_features{i}.LZC;
            mci_SimpleComp(mci_idx, :, :) = all_features{i}.SimpleComp;
            mci_BPS_delta(mci_idx, :, :) = all_features{i}.BPS_delta;
            mci_BPS_theta(mci_idx, :, :) = all_features{i}.BPS_theta;
            mci_BPS_alpha(mci_idx, :, :) = all_features{i}.BPS_alpha;
            mci_BPS_beta(mci_idx, :, :) = all_features{i}.BPS_beta;
            mci_BPS_gamma(mci_idx, :, :) = all_features{i}.BPS_gamma;
            mci_BPN_delta(mci_idx, :, :) = all_features{i}.BPN_delta;
            mci_BPN_theta(mci_idx, :, :) = all_features{i}.BPN_theta;
            mci_BPN_alphai(mci_idx, :, :) = all_features{i}.BPN_alphai;
            mci_BPN_alphaii(mci_idx, :, :) = all_features{i}.BPN_alphaii;
            mci_BPN_alphaiii(mci_idx, :, :) = all_features{i}.BPN_alphaiii;
            mci_BPN_betai(mci_idx, :, :) = all_features{i}.BPN_betai;
            mci_BPN_betaii(mci_idx, :, :) = all_features{i}.BPN_betaii;
            mci_idx = mci_idx + 1;
        else  % Healthy group
            normal_LZC(normal_idx, :, :) = all_features{i}.LZC;
            normal_SimpleComp(normal_idx, :, :) = all_features{i}.SimpleComp;
            normal_BPS_delta(normal_idx, :, :) = all_features{i}.BPS_delta;
            normal_BPS_theta(normal_idx, :, :) = all_features{i}.BPS_theta;
            normal_BPS_alpha(normal_idx, :, :) = all_features{i}.BPS_alpha;
            normal_BPS_beta(normal_idx, :, :) = all_features{i}.BPS_beta;
            normal_BPS_gamma(normal_idx, :, :) = all_features{i}.BPS_gamma;
            normal_BPN_delta(normal_idx, :, :) = all_features{i}.BPN_delta;
            normal_BPN_theta(normal_idx, :, :) = all_features{i}.BPN_theta;
            normal_BPN_alphai(normal_idx, :, :) = all_features{i}.BPN_alphai;
            normal_BPN_alphaii(normal_idx, :, :) = all_features{i}.BPN_alphaii;
            normal_BPN_alphaiii(normal_idx, :, :) = all_features{i}.BPN_alphaiii;
            normal_BPN_betai(normal_idx, :, :) = all_features{i}.BPN_betai;
            normal_BPN_betaii(normal_idx, :, :) = all_features{i}.BPN_betaii;
            normal_idx = normal_idx + 1;
        end
    end
    
    % Save for statistical testing
    save('compiled_features_for_ttest.mat', ...
         'mci_LZC', 'normal_LZC', 'mci_SimpleComp', 'normal_SimpleComp', ...
         'mci_BPS_delta', 'normal_BPS_delta', 'mci_BPS_theta', 'normal_BPS_theta', ...
         'mci_BPS_alpha', 'normal_BPS_alpha', 'mci_BPS_beta', 'normal_BPS_beta', ...
         'mci_BPS_gamma', 'normal_BPS_gamma', 'mci_BPN_delta', 'normal_BPN_delta', ...
         'mci_BPN_theta', 'normal_BPN_theta', 'mci_BPN_alphai', 'normal_BPN_alphai', ...
         'mci_BPN_alphaii', 'normal_BPN_alphaii', 'mci_BPN_alphaiii', 'normal_BPN_alphaiii', ...
         'mci_BPN_betai', 'normal_BPN_betai', 'mci_BPN_betaii', 'normal_BPN_betaii');
    
    fprintf('Features compiled for statistical testing\n');
    fprintf('Dimensions: %d windows × %d channels × 14 feature types\n', num_windows, num_channels);
    
end