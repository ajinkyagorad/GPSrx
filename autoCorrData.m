fID=fopen('data');
readSize = 1E6;
data=fread(fID,readSize);
A = split_vect(data,2);
B = A(:,1)+i*A(:,2);
y = autocorr(B,5000);
plot(abs(y))