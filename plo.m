
% acc_bw5 = load('accur_NRS_bw5.mat');
% acc_bw3 = load('accur_NRS_bw3.mat');
% acc_bw1 = load('accur_NRS_bw1.mat');
%
% plot([2:2:20],acc_bw1.accur_NRS,'s-.g','markerfacecolor','green')
% hold on
% grid on
% plot([2:2:20],acc_bw3.accur_NRS,'h-.r','markerfacecolor','red')
% plot([2:2:20],acc_bw5.accur_NRS,'^-.b','markerfacecolor','blue')
% title('\color{blue}PC-Gabor-NRS')
% xlabel('\fontsize{14}\delta')
% ylabel('\fontsize{14}Overall Accuracy (%)')
% legend('bw = 1','bw = 3','bw = 5','location','south')
%--------------------------------------------------%

% acc_70 = load('accur_NRS_70.mat');
% acc_60 = load('accur_NRS_60.mat');
% acc_30 = load('accur_NRS_30.mat');
% semilogx(logspace(-3,0,10),acc_30.accur_NRS,'s-.g','markerfacecolor','green')
% hold on
% grid on
% semilogx(logspace(-3,0,10),acc_60.accur_NRS,'h-.r','markerfacecolor','red')
% semilogx(logspace(-3,0,10),acc_70.accur_NRS,'^-.b','markerfacecolor','blue')
% title('\color{blue}PC-Gabor-NRS')
% xlabel('\fontsize{14}\lambda')
% ylabel('\fontsize{14}Overall Accuracy (%)')
% legend('30 sample per class','60 sample per class','70 sample per class','location','south')

%--------------------------------------------------%
%% indian

% acc_70 = load('accur_NRS_70_I.mat');
% acc_60 = load('accur_NRS_60_I.mat');
% acc_30 = load('accur_NRS_30_I.mat');
% semilogx(logspace(-3,0,10),acc_30.accur_NRS,'s-.g','markerfacecolor','green')
% hold on
% grid on
% semilogx(logspace(-3,0,10),acc_60.accur_NRS,'h-.r','markerfacecolor','red')
% semilogx(logspace(-3,0,10),acc_70.accur_NRS,'^-.b','markerfacecolor','blue')
% title('\color{blue}PC-Gabor-NRS')
% xlabel('\fontsize{14}\lambda')
% ylabel('\fontsize{14}Overall Accuracy (%)')
% legend('30 sample per class','60 sample per class','70 sample per class','location','south')
%--------------------------------------------------%
% acc_bw5 = load('accur_NRS_bw5_I.mat');
% acc_bw3 = load('accur_NRS_bw3_I.mat');
% acc_bw1 = load('accur_NRS_bw1_I.mat');
%
% plot([2:2:20],acc_bw1.accur_NRS,'s-.g','markerfacecolor','green')
% hold on
% grid on
% plot([2:2:20],acc_bw3.accur_NRS,'h-.r','markerfacecolor','red')
% plot([2:2:20],acc_bw5.accur_NRS,'^-.b','markerfacecolor','blue')
% title('\color{blue}PC-Gabor-NRS')
% xlabel('\fontsize{14}\delta')
% ylabel('\fontsize{14}Overall Accuracy (%)')
% legend('bw = 1','bw = 3','bw = 5','location','south')
%--------------------------------------------------%
% 
% load PaviaU
% paviaU = paviaU./max(paviaU(:));
% Data = zeros(340,610,103);
% for i = 1:size(paviaU,3)
%     Data(:,:,i) = paviaU(:,:,i)';
% end
% [m n d] = size(Data);
% load PaviaU_gt
% paviaU_gt = paviaU_gt';
% NTrain = 70;
% no_class = 9;
% num_train = ones(1, no_class)*NTrain;
% CTrain = num_train;
% 
% N_PC = 10;
% [m n d] = size(Data);
% DataTest = reshape(Data, m*n, d);
% Psi = PCA_b(DataTest', N_PC);
% DataTestN = DataTest*Psi;
% DataN = reshape(DataTestN, m, n, N_PC);
% [m n d] = size(DataN);
% 
% pau = [];
% for i=1:9
%     fi = find(paviaU_gt == i);
%     a = [];
%     for j = 1:10
%         b = DataN(:,:,j);
%         a = [a ,b(fi)];
%     end
%     pau = [pau;a];
% end
% 
% 
% 
% dt = [];
% T = [6631 , 18649 , 2099 , 3064 , 1345 , 5029 , 1330 , 3682 , 947];
% for i =1:9
%     nt = 70;
%     fi = find(paviaU_gt == i);
%     rp = randperm(T(i));
%     ffi = fi(rp(1:nt));
%     a = [];
%     for j=1:10
%         b = DataN(:,:,j);
%         a = [a,b(ffi)];
%     end
%     dt = [dt;a];
% end
% 
% 
% it = 1;
% for lambda = 2 %0.1:0.1:2
%     class_NRS = NRS_Classification(dt, CTrain, pau, lambda);
% %     [confusion, accur_NRS(it)] = confusion_matrix_wei(class_NRS, CTest);
%     [confusion, accur_NRS(it)] = confusion_matrix_wei(class_NRS, T);
%     [lambda,accur_NRS(it)]
%     it = it+1;
% end
% 
% class = zeros(340,610);
% C = zeros(340,610,9);
% a = 0;
% T = [6631 , 18649 , 2099 , 3064 , 1345 , 5029 , 1330 , 3682 , 947];
% for i = 1:9
%     fi = find(paviaU_gt == i);
%     class(fi) = class_NRS(a+1:T(i) + a);
%     a = T(i) + a;
% end
% for i = 1:9
%     C(:,:,i) = class == i;
% end
% final = ToRGB(C);
% imshow(final)

%--------------------------------------------------%
% load Indian_pines
% indian_pines = indian_pines./max(indian_pines(:));
% Data = zeros(145,145,220);
% for i = 1:size(indian_pines,3)
%     Data(:,:,i) = indian_pines(:,:,i)';
% end
% [m n d] = size(Data);
% load Indian_pines_gt
% indian_pines_gt(indian_pines_gt == 1) = 0;
% indian_pines_gt(indian_pines_gt == 7) = 0;
% indian_pines_gt(indian_pines_gt == 9) = 0;
% indian_pines_gt = indian_pines_gt';
% NTrain = 70;
% no_class = 16;
% num_train = ones(1, no_class)*NTrain;
% num_train([1,7,9]) = 0;
% CTrain = num_train;
% 
% N_PC = 10;
% [m n d] = size(Data);
% DataTest = reshape(Data, m*n, d);
% Psi = PCA_b(DataTest', N_PC);
% DataTestN = DataTest*Psi;
% DataN = reshape(DataTestN, m, n, N_PC);
% [m n d] = size(DataN);
% 
% inp = [];
% for i=1:16
%     fi = find(indian_pines_gt == i);
%     a = [];
%     for j = 1:10
%         b = DataN(:,:,j);
%         a = [a ,b(fi)];
%     end
%     inp = [inp;a];
% end
% 
% 
% 
% dt = [];
% T = [0 , 1428 , 830 , 237 , 483 , 730 , 0 , 478 , 0 , 972 , 2455 , 593 , 205 , 1265 , 386 , 93];
% for i =1:16
%     nt = 70;
%     fi = find(indian_pines_gt == i);
%     rp = randperm(T(i));
%     if ~isempty(fi)
%         ffi = fi(rp(1:nt));
%     else
%         ffi = [];
%     end
%     a = [];
%     for j=1:10
%         b = DataN(:,:,j);
%         a = [a,b(ffi)];
%     end
%     dt = [dt;a];
% end
% 
% 
% it = 1;
% for lambda = 0.8 %0.1:0.1:2
%     class_NRS = NRS_Classification(dt, CTrain, inp, lambda);
% %     [confusion, accur_NRS(it)] = confusion_matrix_wei(class_NRS, CTest);
%     [confusion, accur_NRS(it)] = confusion_matrix_wei(class_NRS, T);
%     [lambda,accur_NRS(it)]
%     it = it+1;
% end
% 
% class = zeros(145,145);
% C = zeros(145,145,16);
% a = 0;
% T = [0 , 1428 , 830 , 237 , 483 , 730 , 0 , 478 , 0 , 972 , 2455 , 593 , 205 , 1265 , 386 , 93];
% for i = 1:no_class
%     fi = find(indian_pines_gt == i);
%     class(fi) = class_NRS(a+1:T(i) + a);
%     a = T(i) + a;
% end
% for i = 1:no_class
%     C(:,:,i) = class == i;
% end
% final = ToRGB(C);
% imshow(final)

%--------------------------------------------------%

% acc_70 = load('NRS_lambda_70.mat');
% acc_60 = load('NRS_lambda_60.mat');
% acc_30 = load('NRS_lambda_30.mat');
% 
% plot([0.1:0.1:2],acc_30.accur_NRS,'s-.g','markerfacecolor','green')
% hold on
% grid on
% plot([0.1:0.1:2],acc_60.accur_NRS,'h-.r','markerfacecolor','red')
% plot([0.1:0.1:2],acc_70.accur_NRS,'^-.b','markerfacecolor','blue')
% title('\color{blue}PC-NRS')
% xlabel('\fontsize{14}\lambda')
% ylabel('\fontsize{14}Overall Accuracy (%)')
% legend('30 sample per class','60 sample per class','70 sample per class','location','south')


%----------------------------------------------------%
% acc_70 = load('NRS_lambda_70_I.mat');
% acc_60 = load('NRS_lambda_60_I.mat');
% acc_30 = load('NRS_lambda_30_I.mat');
% 
% plot([0.1:0.1:2],acc_30.accur_NRS,'s-.g','markerfacecolor','green')
% hold on
% grid on
% plot([0.1:0.1:2],acc_60.accur_NRS,'h-.r','markerfacecolor','red')
% plot([0.1:0.1:2],acc_70.accur_NRS,'^-.b','markerfacecolor','blue')
% title('\color{blue}PC-NRS')
% xlabel('\fontsize{14}\lambda')
% ylabel('\fontsize{14}Overall Accuracy (%)')
% legend('30 sample per class','60 sample per class','70 sample per class','location','south')