%  BOXPLOTS 
clear; clc;

%% 1. Lampel Ziv Ccomplexity FEATURES 
significant_lz_channels = find(any(H_lz, 2)); % Channels with ANY significant window

if ~isempty(significant_lz_channels)
    figure('Name', 'LZC Features');
    
    for i = 1:length(significant_lz_channels)
        ch = significant_lz_channels(i);
        mci_data = [];
        normal_data = [];
        for win = 1:18  % All 18 windows
            if H_lz(ch, win)  % Only include significant windows
                mci_data = [mci_data; mci_LZC(:, win, ch)];
                normal_data = [normal_data; normal_LZC(:, win, ch)];
            end
        end

        % If no significant windows found, skip
        if isempty(mci_data)
            continue;
        end
        
        subplot(2, ceil(length(significant_lz_channels)/2), i);
        
        groups = [zeros(length(mci_data), 1); ones(length(normal_data), 1)];
        all_data = [mci_data; normal_data];
        
        boxplot(all_data, groups, 'Labels', {'MCI', 'Normal'});
        title(sprintf('LZC - Channel %d', ch));
        ylabel('LZC Value');
        
        fprintf('LZC Channel %d\n', ch);
    end
end

%% 2. BPS FEATURES - All frequency bands
bps_types = {'BPS_delta', 'BPS_theta', 'BPS_alpha', 'BPS_beta', 'BPS_gamma'};
bps_arrays = {H_BPS_delta, H_BPS_theta, H_BPS_alpha, H_BPS_beta, H_BPS_gamma};
bps_data = {mci_BPS_delta, mci_BPS_theta, mci_BPS_alpha, mci_BPS_beta, mci_BPS_gamma};
bps_normal = {normal_BPS_delta, normal_BPS_theta, normal_BPS_alpha, normal_BPS_beta, normal_BPS_gamma};

for b = 1:length(bps_types)
    significant_channels = find(any(bps_arrays{b}, 2));
    
    if ~isempty(significant_channels)
        figure('Name', sprintf('%s ', bps_types{b}));
        
        for i = 1:length(significant_channels)
            ch = significant_channels(i);
            
            % Combine all significant windows for this channel
            mci_data = [];
            normal_data = [];
            
            for win = 1:18
                if bps_arrays{b}(ch, win)
                    mci_data = [mci_data; bps_data{b}(:, win, ch)];
                    normal_data = [normal_data; bps_normal{b}(:, win, ch)];
                end
            end
            
            if isempty(mci_data)
                continue;
            end
            
            subplot(2, ceil(length(significant_channels)/2), i);
            
            groups = [zeros(length(mci_data), 1); ones(length(normal_data), 1)];
            all_data = [mci_data; normal_data];
            
            boxplot(all_data, groups, 'Labels', {'MCI', 'Normal'});
            title(sprintf('%s - Channel %d', bps_types{b}, ch));
            ylabel('Power Value');
        end
    end
end

%% 3. BPN FEATURES - All frequency bands
bpn_types = {'BPN_delta', 'BPN_theta', 'BPN_alphai', 'BPN_alphaii', 'BPN_alphaiii', 'BPN_betai', 'BPN_betaii'};
bpn_arrays = {H_BPN_delta, H_BPN_theta, H_BPN_alphai, H_BPN_alphaii, H_BPN_alphaiii, H_BPN_betai, H_BPN_betaii};
bpn_data = {mci_BPN_delta, mci_BPN_theta, mci_BPN_alphai, mci_BPN_alphaii, mci_BPN_alphaiii, mci_BPN_betai, mci_BPN_betaii};
bpn_normal = {normal_BPN_delta, normal_BPN_theta, normal_BPN_alphai, normal_BPN_alphaii, normal_BPN_alphaiii, normal_BPN_betai, normal_BPN_betaii};

for b = 1:length(bpn_types)
    significant_channels = find(any(bpn_arrays{b}, 2));
    
    if ~isempty(significant_channels)
        figure('Name', sprintf('%s', bpn_types{b}));
        
        for i = 1:length(significant_channels)
            ch = significant_channels(i);
            
            mci_data = [];
            normal_data = [];
            
            for win = 1:18
                if bpn_arrays{b}(ch, win)
                    mci_data = [mci_data; bpn_data{b}(:, win, ch)];
                    normal_data = [normal_data; bpn_normal{b}(:, win, ch)];
                end
            end
            
            if isempty(mci_data)
                continue;
            end
            
            subplot(2, ceil(length(significant_channels)/2), i);
            
            groups = [zeros(length(mci_data), 1); ones(length(normal_data), 1)];
            all_data = [mci_data; normal_data];
            
            boxplot(all_data, groups, 'Labels', {'MCI', 'Normal'});
            title(sprintf('%s - Channel %d', bpn_types{b}, ch));
            ylabel('Power Value');
        end
    end
end

%% 4. CONNECTIVITY FEATURES

% dDTF features
dDTF_types = {'dDTF_delta', 'dDTF_theta', 'dDTF_alpha', 'dDTF_beta', 'dDTF_gamma'};
dDTF_arrays = {H_dDTF_delta, H_dDTF_theta, H_dDTF_alpha, H_dDTF_beta, H_dDTF_gamma};
dDTF_data = {mci_dDTF_delta, mci_dDTF_theta, mci_dDTF_alpha, mci_dDTF_beta, mci_dDTF_gamma};
dDTF_normal = {normal_dDTF_delta, normal_dDTF_theta, normal_dDTF_alpha, normal_dDTF_beta, normal_dDTF_gamma};

for b = 1:length(dDTF_types)

    [significant_r1, significant_r2] = find(dDTF_arrays{b});
    
    if ~isempty(significant_r1)
        figure('Name', sprintf('%s', dDTF_types{b}));
        
        for i = 1:length(significant_r1)
            r1 = significant_r1(i);
            r2 = significant_r2(i);
            
            mci_data = dDTF_data{b}(:, r2, r1); 
            normal_data = dDTF_normal{b}(:, r2, r1);
            
            subplot(2, ceil(length(significant_r1)/2), i);
            
            groups = [zeros(length(mci_data), 1); ones(length(normal_data), 1)];
            all_data = [mci_data; normal_data];
            
            boxplot(all_data, groups, 'Labels', {'MCI', 'Normal'});
            title(sprintf('%s - R%d→R%d', dDTF_types{b}, r1, r2));
            ylabel('Connectivity Value');
        end
    end
end

% GPDC features
GPDC_types = {'GPDC_delta', 'GPDC_theta', 'GPDC_alpha', 'GPDC_beta', 'GPDC_gamma'};
GPDC_arrays = {H_GPDC_delta, H_GPDC_theta, H_GPDC_alpha, H_GPDC_beta, H_GPDC_gamma};
GPDC_data = {mci_GPDC_delta, mci_GPDC_theta, mci_GPDC_alpha, mci_GPDC_beta, mci_GPDC_gamma};
GPDC_normal = {normal_GPDC_delta, normal_GPDC_theta, normal_GPDC_alpha, normal_GPDC_beta, normal_GPDC_gamma};

for b = 1:length(GPDC_types)
    [significant_r1, significant_r2] = find(GPDC_arrays{b});
    
    if ~isempty(significant_r1)
        figure('Name', sprintf('%s', GPDC_types{b}));
        
        for i = 1:length(significant_r1)
            r1 = significant_r1(i);
            r2 = significant_r2(i);
            
            mci_data = GPDC_data{b}(:, r2, r1);
            normal_data = GPDC_normal{b}(:, r2, r1);
            
            subplot(2, ceil(length(significant_r1)/2), i);
            
            groups = [zeros(length(mci_data), 1); ones(length(normal_data), 1)];
            all_data = [mci_data; normal_data];
            
            boxplot(all_data, groups, 'Labels', {'MCI', 'Normal'});
            title(sprintf('%s: R%d→R%d', GPDC_types{b}, r1, r2));
            ylabel('Connectivity Value');
            
            fprintf('%s: Region %d → Region %d\n', GPDC_types{b}, r1, r2);
        end
    end
end
