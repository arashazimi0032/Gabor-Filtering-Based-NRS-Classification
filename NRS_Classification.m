function class = NRS_Classification(DataTrain, CTrain, DataTest, lambda)

numClass = length(CTrain);
[m Nt]= size(DataTest);
for j = 1: m
    Y = DataTest(j, :);
    a = 0;
    for i = 1: numClass 
        HX = DataTrain((a+1): (CTrain(i)+a), :);
        a = CTrain(i) + a;

        Y_hat = tikhanov(Y, HX, lambda);
        
        Y_snr(i) = SNR(Y, Y_hat);
    end
   [value class(j)] = max(Y_snr);
end
end

function predicted_vector = tikhanov(y, reference, lambda)

[m Nt]= size(reference);
lambda2 = lambda^2;


H = reference';

norms = sum((H - repmat(y', [1 m])).^2);

G = diag(lambda2.*norms);

weights = (H'*H + G)\(H'*y');

predicted_vector = H*weights(:);
predicted_vector = predicted_vector';
end

function S = SNR(x, x_hat)

if (~isvector(x) || ~isvector(x_hat))
  error('x and x_hat must be vectors');
end

x = x(:);
x_hat = x_hat(:);

diff = x - x_hat;
mse = diff' * diff / length(x);

variance = cov(x);
S = 10*log10(variance / mse);
end
