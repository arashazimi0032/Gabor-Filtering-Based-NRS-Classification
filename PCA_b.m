function Psi = PCA_b(input, pc)

[~, M] = size(input);

X_mean = mean(input, 2);
input = input - repmat(X_mean, 1, M);


Sigma = (input * input')/M;
  
[Psi, ~, ~] = svd(Sigma);

Psi = Psi(:, 1:pc);
end
