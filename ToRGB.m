function final = ToRGB(C)

final = zeros(size(C,1),size(C,2),3);
a = zeros(size(final(:,:,1)));
b = a; c = b;
for i =1:size(C,3)
    d = C(:,:,i);
    rgb = randi([0,255],256,1);
    idx = randi([1,256],256,1);
    a(d == 1) = rgb(idx(randi([1,256],1,1)));
    b(d == 1) = rgb(idx(randi([1,256],1,1)));
    c(d == 1) = rgb(idx(randi([1,256],1,1)));
end
a = uint8(a);
b = uint8(b);
c = uint8(c);
final = cat(3,b,a,c);
end