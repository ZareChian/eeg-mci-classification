function binary_data = binarize(data)
    % Input: Your 18 × 2560 × 19 matrix
    % Output: 18 × 2560 × 19 logical matrix where each element is:
    %  1 if the original value > mean of its row
    %  0 if the original value ≤ mean of its row
    binary_data = data > mean(data, 2);
end