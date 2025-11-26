% performs statistical comparison (ttest) between Normal controls 
% and Mild Cognitive Impairment (MCI) patients using EEG-derived features.

% Identify statistically significant differences in EEG patterns between groups

% true = reject H0 (significant difference found)
% false = fail to reject H0 (no significant difference)

% features (Lempel-Ziv compelxity, Simple Complexity, Band power in standard and narrow band frequency) 
% were calculated for 19 EEG channels and 18 time windows. 
% Each feature matric is 18*19, where each element (i,j) represents 
% the feature for ith window of and jth channel.
% Data dimensions: 16×18×19 for normal subjects, 11×18×19 for MCI subjects
% (subjects × windows × channels)

H_lz = false(19, 18);          % 19 channels × 18 windows
H_c = false(19, 18);
H_BPS_delta = false(19, 18);
H_BPS_theta = false(19, 18);
H_BPS_alpha = false(19, 18);
H_BPS_beta  = false(19, 18);
H_BPS_gamma = false(19, 18);
H_BPN_delta = false(19, 18);
H_BPN_theta = false(19, 18);
H_BPN_alphai   = false(19, 18);
H_BPN_alphaii  = false(19, 18);
H_BPN_alphaiii = false(19, 18);
H_BPN_betai  = false(19, 18);
H_BPN_betaii = false(19, 18);

for channel = 1:19
    for window = 1:18
        H_lz(channel, window) = ttest2(normal_LZC(:, window, channel), mci_LZC(:, window, channel), 'Alpha', 0.05);
        H_c(channel, window) = ttest2(normal_SimpleComp(:,window, channel), mci_SimpleComp(:,window, channel), 'Alpha', 0.05) ;
        H_BPS_delta(channel, window) = ttest2(normal_BPS_delta(:,window, channel), mci_BPS_delta(:,window, channel),'Alpha', 0.05) ;
        H_BPS_theta(channel, window) = ttest2(normal_BPS_theta(:,window, channel), mci_BPS_theta(:,window, channel), 'Alpha', 0.05) ;
        H_BPS_alpha(channel, window) = ttest2(normal_BPS_alpha(:,window, channel), mci_BPS_alpha(:,window, channel), 'Alpha', 0.05) ;
        H_BPS_beta(channel, window) = ttest2(normal_BPS_beta(:,window, channel),mci_BPS_beta(:,window, channel), 'Alpha', 0.05) ;
        H_BPS_gamma(channel, window) = ttest2(normal_BPS_gamma(:,window, channel),mci_BPS_gamma(:,window, channel), 'Alpha', 0.05) ;
        H_BPN_theta(channel, window) = ttest2(normal_BPN_theta(:,window, channel),mci_BPN_theta(:,window, channel), 'Alpha',0.05) ;
        H_BPN_delta(channel, window) = ttest2(normal_BPN_delta(:,window, channel),mci_BPN_delta(:,window, channel), 'Alpha',0.05) ;
        H_BPN_alphai(channel, window) = ttest2(normal_BPN_alphai(:,window, channel),mci_BPN_alphai(:,window, channel), 'ALPHA',0.05) ;
        H_BPN_alphaii(channel, window) = ttest2(normal_BPN_alphaii(:,window, channel),mci_BPN_alphaii(:,window, channel), 'ALPHA',0.05) ;
        H_BPN_alphaiii(channel, window) = ttest2(normal_BPN_alphaiii(:,window, channel),mci_BPN_alphaiii(:,window, channel), 'ALPHA',0.05) ;
        H_BPN_betai(channel, window) = ttest2(normal_BPN_betai(:,window, channel),mci_BPN_betai(:,window, channel), 'ALPHA',0.05) ;
        H_BPN_betaii(channel, window) = ttest2(normal_BPN_betaii(:,window, channel),mci_BPN_betaii(:,window, channel), 'ALPHA',0.05) ;
    end
end

% Connectivity features (dDTF and GPDC) were calculated for 9 brain regions 
% using EEGLAB toolbox. Each region represents the mean of multiple channels.
% The connectivity matrices are 9x9, where each element (i,j) represents 
% the connectivity between region i and region j.
% Data dimensions: 16×9×9 for normal subjects, 11×9×9 for MCI subjects
% (subjects × regions × regions)

H_dDTF_theta = false(9, 9);          % 9 regions * 9 regions
H_dDTF_delta = false(9, 9);
H_dDTF_alpha = false(9, 9);
H_dDTF_beta  = false(9, 9);
H_dDTF_gamma = false(9, 9);
H_GPDC_theta = false(9, 9);
H_GPDC_delta = false(9, 9);
H_GPDC_alpha = false(9, 9);
H_GPDC_beta  = false(9, 9);
H_GPDC_gamma = false(9, 9);

for r1 = 1 : 9
    for r2 = 1:9
        H_dDTF_theta(r1,r2) = ttest2(normal_dDTF_theta(:,r2,r1),mci_dDTF_theta(:,r2,r1), 'Alpha',0.05);
        H_dDTF_delta(r1,r2) = ttest2(normal_dDTF_delta(:,r2,r1),mci_dDTF_delta(:,r2,r1), 'Alpha',0.05);
        H_dDTF_alpha(r1,r2) = ttest2(normal_dDTF_alpha(:,r2,r1),mci_dDTF_alpha(:,r2,r1), 'Alpha',0.05);
        H_dDTF_beta (r1,r2) = ttest2(normal_dDTF_beta (:,r2,r1),mci_dDTF_beta (:,r2,r1), 'Alpha',0.05) ;
        H_dDTF_gamma(r1,r2) = ttest2(normal_dDTF_gamma(:,r2,r1),mci_dDTF_gamma(:,r2,r1), 'Alpha',0.05);
    
        H_GPDC_theta(r1,r2) = ttest2(normal_GPDC_theta(:,r2,r1),mci_GPDC_theta(:,r2,r1), 'Alpha',0.05);
        H_GPDC_delta(r1,r2) = ttest2(normal_GPDC_delta(:,r2,r1),mci_GPDC_delta(:,r2,r1), 'Alpha',0.05);
        H_GPDC_alpha(r1,r2) = ttest2(normal_GPDC_alpha(:,r2,r1),mci_GPDC_alpha(:,r2,r1), 'Alpha',0.05);
        H_GPDC_beta (r1,r2) = ttest2(normal_GPDC_beta (:,r2,r1),mci_GPDC_beta (:,r2,r1), 'Alpha',0.05) ;
        H_GPDC_gamma(r1,r2) = ttest2(normal_GPDC_gamma(:,r2,r1),mci_GPDC_gamma(:,r2,r1), 'Alpha',0.05);
    end
end  
