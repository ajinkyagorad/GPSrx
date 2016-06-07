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
% B has the complex actual sampled data by SDR/USRP
B = A(:,1)+i*A(:,2);
figure(1)
title('Correlation with code')
xlabel('index')
ylabel('correlated value')
figure(2)
title('Filtered Response')
xlabel('index')
ylabel('avg Value')
%Add a filter parameters
a = 1;
N = 300;
b = ones(1,N)/N;

for k=1:3
    g = cacode([k],10/1.023);   % doing at 10Mhz, c/a code sampling
    r = xcorr(B,g);
    %r_f= filter(b,a,abs(r));
    r_f = smooth(r,N);
    figure(1);
    plot(abs(r));
    hold on
    
    figure(2)
    plot(abs(r_f));
    hold on
end
