%Correlate GPS data with the C/A codes
% read data from file
fID=fopen('data');
%1.79 GB ~ 20 sec
time = 10E-3;
bytesPerSec= (1.79*1024*1024*1024)/20;
bytes = time*bytesPerSec;
readSize = [2 floor(bytes/2)];
disp('Read Size(MB): ');
disp(bytes/1024/1024 );
k = waitforbuttonpress;
data=fread(fID,readSize);
A = data';
%A = split_vect(data,2);
B = A(:,1)+i*A(:,2);
figure(2)
title('Correlation with code')
xlabel('index')
ylabel('correlated value')
% B has the data
for k=1:3
    g = cacode([k],10/1.023);   % doing at 10Mhz, c/a code sampling
    r[k] = xcorr(B,g);
    plot(abs(r[k]));
    hold on
end
