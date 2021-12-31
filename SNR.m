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
