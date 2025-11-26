% EEG Classification with LOO Validation
clear; clc;

load('feature_matrix.mat');

X = feature_matrix(:, 2:end-1); % Features
T = feature_matrix(:, end);     % Labels

% Shuffle data
rng(42);
N = numel(T);
PR = randperm(N);
X = X(PR, :);
T = T(PR);

fprintf('Data: %d subjects, %d features\n', size(X,1), size(X,2));
fprintf('Normal: %d, MCI: %d\n\n', sum(T==0), sum(T==1));

%% KNN Classification (K = 3,5,7,9)
fprintf('\n KNN CLASSIFICATION (Leave-One-Out)\n');
k_values = [3, 5, 7, 9];

for i = 1:length(k_values)
    k = k_values(i);
    knn_mdl = fitcknn(X, T, 'NumNeighbors', k, 'Standardize', true);
    cvmodel = crossval(knn_mdl, 'Leaveout', 'on');
    label = kfoldPredict(cvmodel);
    C = confusionmat(T, label);

    TN = C(1,1); FP = C(1,2); FN = C(2,1); TP = C(2,2);

    Accuracy    = 100 * (TP + TN) / sum(C(:));
    Sensitivity = 100 * TP / (TP + FN);
    Specificity = 100 * TN / (TN + FP);
    Error       = 100 * (1 - (TP + TN) / sum(C(:)));
    
    fprintf('KNN - K=%d: Accuracy=%.2f%%, Error=%.2f%%, Sensitivity=%.2f%%, Specificity=%.2f%%\n', ...
            k, Accuracy, Error, Sensitivity, Specificity);
end

%% SVM Classification (Different Kernels)
fprintf('\n SVM CLASSIFICATION (Leave-One-Out)\n');
kernels = {'linear', 'polynomial', 'polynomial', 'rbf'};
degrees = [0, 2, 3, 0];

for i = 1:length(kernels)
    kernel = kernels{i};
    degree = degrees(i);
    
    if degree > 0
        svm_mdl = fitcsvm(X, T, 'KernelFunction', kernel, 'PolynomialOrder', degree, 'Standardize', true);
    else
        svm_mdl = fitcsvm(X, T, 'KernelFunction', kernel, 'Standardize', true);
    end
    
    cvmodel = crossval(svm_mdl, 'Leaveout', 'on');
    label = kfoldPredict(cvmodel);
    C = confusionmat(T, label);

    TN = C(1,1); FP = C(1,2); FN = C(2,1); TP = C(2,2);

    Accuracy    = 100 * (TP + TN) / sum(C(:));
    Sensitivity = 100 * TP / (TP + FN);
    Specificity = 100 * TN / (TN + FP);
    Error       = 100 * (1 - (TP + TN) / sum(C(:)));
    
    if degree > 0
        fprintf('SVM-%s (degree %d): Accuracy=%.2f%%, Error=%.2f%%, Sensitivity=%.2f%%, Specificity=%.2f%%\n', ...
                kernel, degree, Accuracy, Error, Sensitivity, Specificity);
    else
        fprintf('SVM-%s: Accuracy=%.2f%%, Error=%.2f%%, Sensitivity=%.2f%%, Specificity=%.2f%%\n', ...
                kernel, Accuracy, Error, Sensitivity, Specificity);
    end
end