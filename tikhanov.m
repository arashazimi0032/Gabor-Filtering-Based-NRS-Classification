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

