
function Gamma = omp(D, X, T)
% Orthogonal Matching Pursuit for sparse coding
% D: dictionary [m x K]
% X: data [m x N]
% T: sparsity level

[m, N] = size(X);
K = size(D, 2);
Gamma = zeros(K, N);

for i = 1:N
    x = X(:, i);
    residual = x;
    indx = [];
    a = [];

    for j = 1:T
        proj = D' * residual;
        [~, pos] = max(abs(proj));
        indx = unique([indx, pos]);
        subD = D(:, indx);
        a = pinv(subD) * x;
        residual = x - subD * a;
    end

    if ~isempty(indx)
        Gamma(indx, i) = a;
    end
end
end
