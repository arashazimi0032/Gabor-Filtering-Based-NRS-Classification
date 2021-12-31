clear all; close all; clc

% for iter = 1
load PaviaU
paviaU = paviaU./max(paviaU(:));
Data = zeros(340,610,103);
for i = 1:size(paviaU,3)
    Data(:,:,i) = paviaU(:,:,i)';
end
[m n d] = size(Data);
load PaviaU_gt
paviaU_gt = paviaU_gt';


NTrain = 70;
no_class = 9;
num_train = ones(1, no_class)*NTrain;
% num_test = ones(1, no_class)*740;
num_test = [6631 , 18649 , 2099 , 3064 , 1345 , 5029 , 1330 , 3682 , 947] - NTrain;
mask = zeros(size(paviaU_gt));
for i = 1: no_class
    tmp  = find(paviaU_gt==i);
    index_i = randperm(length(tmp));
    mask(tmp(index_i(1:num_train(i)+num_test(i)))) = i;
end

Feature_P = Gabor_feature_extraction_PC(Data, 5);

Data = []; Labels = [];
d = size(Feature_P, 3);
Data_tmp = reshape(Feature_P, m*n, d);
for i = 1: no_class
    pos = find(mask==i);
    Data = [Data; Data_tmp(pos, :)];
    Labels = [Labels, length(pos)];
end
clear Data_tmp Feature_P DataTest

DataTrain = []; paviaU = [];
CTrain = num_train; CTest = num_test;
a = 0;
for i = 1: no_class
    Data_tmp = Data((a+1):(Labels(i)+a), :);
    a = Labels(i) + a;
    index_i = randperm(Labels(i));
    DataTrain = [DataTrain; Data_tmp(index_i(1:num_train(i)), :)];
%     paviaU = [paviaU; Data_tmp(index_i(num_train(i)+1:end), :)];
    paviaU = [paviaU; Data_tmp(index_i(1:end), :)];
end


it = 1;
for lambda = 0.1 %logspace(-3,0,10)
    class_NRS = NRS_Classification(DataTrain, CTrain, paviaU, lambda);
%     [confusion, accur_NRS(it)] = confusion_matrix_wei(class_NRS, CTest);
    [confusion, accur_NRS(it)] = confusion_matrix_wei(class_NRS, Labels);
    [lambda,accur_NRS(it)]
    it = it+1;
end
% end
class = zeros(340,610);
C = zeros(340,610,9);
a = 0;
T = [6631 , 18649 , 2099 , 3064 , 1345 , 5029 , 1330 , 3682 , 947];
for i = 1:9
    fi = find(paviaU_gt == i);
    class(fi) = class_NRS(a+1:T(i) + a);
    a = T(i) + a;
end
for i = 1:9
    C(:,:,i) = class == i;
end
final = ToRGB(C);
imshow(final)




% 
% clear all; close all; clc
% it = 1;
% % for delta = 2:2:20
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
% 
% 
% NTrain = 70;
% no_class = 16;
% num_train = ones(1, no_class)*NTrain;
% num_train([1,7,9]) = 0;
% % num_test = ones(1, no_class)*740;
% num_test = [0 , 1428 , 830 , 237 , 483 , 730 , 0 , 478 , 0 , 972 , 2455 , 593 , 205 , 1265 , 386 , 93] - NTrain;
% mask = zeros(size(indian_pines_gt));
% for i = 1: no_class
%     tmp  = find(indian_pines_gt==i);
%     index_i = randperm(length(tmp));
%     mask(tmp(index_i(1:num_train(i)+num_test(i)))) = i;
% end
% 
% Feature_P = Gabor_feature_extraction_PC(Data, 5);
% 
% Data = []; Labels = [];
% d = size(Feature_P, 3);
% Data_tmp = reshape(Feature_P, m*n, d);
% for i = 1: no_class
%     pos = find(mask==i);
%     Data = [Data; Data_tmp(pos, :)];
%     Labels = [Labels, length(pos)];
% end
% clear Data_tmp Feature_P DataTest
% 
% DataTrain = []; indian_pines = [];
% CTrain = num_train; CTest = num_test;
% a = 0;
% for i = 1: no_class
%     Data_tmp = Data((a+1):(Labels(i)+a), :);
%     a = Labels(i) + a;
%     index_i = randperm(Labels(i));
%     DataTrain = [DataTrain; Data_tmp(index_i(1:num_train(i)), :)];
%     %     paviaU = [paviaU; Data_tmp(index_i(num_train(i)+1:end), :)];
%     indian_pines = [indian_pines; Data_tmp(index_i(1:end), :)];
% end
% 
% for lambda = 0.1 %logspace(-3,0,10)
%     class_NRS = NRS_Classification(DataTrain, CTrain, indian_pines, lambda);
%     %     [confusion, accur_NRS(it)] = confusion_matrix_wei(class_NRS, CTest);
%     [confusion, accur_NRS(it)] = confusion_matrix_wei(class_NRS, Labels);
%     [lambda,accur_NRS(it)]
%     it = it+1;
% end
% % end
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

