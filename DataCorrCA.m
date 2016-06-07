%Correlate GPS data with the C/A codes
% read data from file
fID=fopen('data');
readSize = 1E5;
data=fread(fID,readSize);
A = split_vect(data,2);
B = A(:,1)+i*A(:,2);
% B has the data
g = cacode([5],10/1.023);
r = xcorr(B,g);
plot(abs(r));
