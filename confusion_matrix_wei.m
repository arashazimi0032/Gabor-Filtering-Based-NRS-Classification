function [confusion, accuracy] = confusion_matrix_wei(class, c)
class = class.';
c = c.';

n = length(class);
c_len = length(c);

if n ~= sum(c)
    disp('WRANING:  wrong inputting!');
    return;
end

confusion = zeros(c_len, c_len);
a = 0;
for i = 1: c_len
    for j = (a + 1): (a + c(i))
        confusion(i, class(j)) = confusion(i, class(j)) + 1;
    end
    a = a + c(i);
end

accuracy = sum(diag(confusion))/sum(c);
