
fID=fopen('data');
readSize = [2 2E6];
data=fread(fID,readSize,'float32');
A = data';
B = A(:,1)+i*A(:,2);    
y = xcorr(B,B);
%ys=smooth(y,1000);
%r = y(2.5E6:3.5E6)-ys(2.5E6:3.5E6);
plot(abs(y))