function DataGabor = Gabor_feature_extraction_PC(Data, BW)

N_PC = 10;
[m n d] = size(Data);
DataTest = reshape(Data, m*n, d);
Psi = PCA_b(DataTest', N_PC);
DataTestN = DataTest*Psi;
DataN = reshape(DataTestN, m, n, N_PC);
[m n d] = size(DataN);


delta  = 18;
psi     = [0 pi/2];
gamma   = 0.5;
N       = 8;
DataGabor = zeros(m, n, N*N_PC);
for i = 1: N_PC
    img_in = DataN(:, :, i);
    bw = BW;
    theta   = 0;
    for n=1:N
        gb = gabor_fn(bw,gamma,psi(1),delta,theta) + 1i * gabor_fn(bw,gamma,psi(2),delta,theta);
        DataGabor(:,:,(i-1)*N+n)=abs(imfilter(img_in, gb, 'symmetric'));
        theta = theta + 2*pi/N;
    end
end
end


function gb=gabor_fn(bw,gamma,psi,delta,theta)

sigma = delta/pi*sqrt(log(2)/2)*(2^bw+1)/(2^bw-1);
sigma_x = sigma;
sigma_y = sigma/gamma;

sz=fix(8*max(sigma_y,sigma_x));
if mod(sz,2)==0, sz=sz+1;end

[x y]=meshgrid(-fix(sz/2):fix(sz/2),fix(sz/2):-1:fix(-sz/2));

x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);
 
gb=exp(-0.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/delta*x_theta+psi);
end

function Psi = PCA_b(input, pc)

[~, M] = size(input);

X_mean = mean(input, 2);
input = input - repmat(X_mean, 1, M);


Sigma = (input * input')/M;
  
[Psi, ~, ~] = svd(Sigma);

Psi = Psi(:, 1:pc);
end
