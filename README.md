# Early Diagnosis of Alzheimer's Disease in Mild Cognitive Impairment Stage

# Project Overview
This project develops a machine learning pipeline for distinguishing between subjects with Mild Cognitive Impairment (MCI) and Normal healthy controls using Electroencephalography (EEG) data. The methodology involves EEG preprocessing, multi-domain feature extraction, statistical feature selection, and classification using K-Nearest Neighbors (KNN) and Support Vector Machine (SVM) algorithms.

# Key Results
- Best Model: Support Vector Machine (SVM) with linear and 2nd-order polynomial kernels
- Highest Accuracy: 92.57% Error Rate: 0.0741
- Narrow frequency band power in features (BPN) outperformed standard frequency band power features (BPS)

# Methodological Pipeline
# 1. EEG Data Preprocessing
Tool: EEGLAB toolbox
- Filtering: Bandpass filter (1-40 Hz)
- Artifact Removal: Artifact Subspace Reconstruction (ASR) and Independent Component Analysis (ICA)

# 2. Feature Extraction: Stage 1 - Spectral Power & Complexity
- Script: `extract_subject_features.m`
- Data Segmentation: 18 non-overlapping 10-second time windows
- Features Computed:
  - Complexity Measures: Lempel-Ziv Complexity (LZC), Simple Complexity
  - Spectral Power in Standard Bands (BPS): Delta, Theta, Alpha, Beta, Gamma
  - Spectral Power in Narrow Bands (BPN): Detailed sub-bands analysis
- Data Structure: [subjects × 18 windows × 19 channels] (16 Normal, 11 MCI)

# 3. Feature Extraction: Stage 2 - Connectivity Features
- Brain Regions: 9 broader regions grouped from 19 channels
- Connectivity Measures:
  - Generalized Partial Directed Coherence (GPDC)
  - directed Directed Transfer Function (dDTF)
- frequency Bands: Delta, Theta, Alpha, Beta, Gamma
- Data Structure: [subjects × 9 regions × 9 regions] - 5 (frequency bands) 9x9 for each subject

# 4. Statistical Feature Selection
- Script: `compile_for_statistical_testing.m` & `Ttest_for_features.m`
- Method: Two-sample T-test (α = 0.05)
- Output: Binary matrices indicating statistically significant features

# 5. Machine Learning Classification
- Script: `feature_matrix_ready_for_ML.m` & `classifier_KNN_SVM.m`
- Validation: Leave-One-Out (LOO) Cross-Validation
- Classifiers:
  - K-Nearest Neighbors (KNN): K values [3, 5, 7, 9]
  - Support Vector Machine (SVM): Kernels {'rbf', 'linear', 'polynomial'}

# 6. Result Visualization
- Script: `boxplot_for_features.m`
- Visualization: Boxplots of most significant features

# Feature Set Comparison
## Set 1: Standard Frequency Bands
- Components: LZC, GPDC, dDTF, Band Power Standard (BPS) in Delta (0.5-4 Hz), Theta (4-8 Hz), Alpha (8-13 Hz),
 Beta (13-25 Hz), Gamma (25-35 Hz) bands

## Set 2: Narrow Frequency Bands (Optimal)
- Components: LZC, GPDC, dDTF, Band Power Narrow (BPN) in Delta (2-3 Hz), Theta (5-6 Hz), Alpha I (9-10 HZ),
Alpha II (10-11 Hz), Alpha III (11-12 Hz), Beta I (14-15 Hz), Beta II (20-21 Hz)

## Installation & Usage
### Prerequisites
- MATLAB R2020a or newer
- EEGLAB toolbox
- Statistics and Machine Learning Toolbox

### Execution Order
1. preprocessing in EEGLAB tool box
2.  `extract_subject_features.m`
3.  `compile_for_statistical_testing.m`
4.  `Ttest_for_features.m`
5.  `feature_matrix_ready_for_ML.m`
6.  `classifier_KNN_SVM.m`
7.  `boxplot_for_features.m`
