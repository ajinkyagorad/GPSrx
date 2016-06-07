%Correlate GPS data with the C/A codes
% read data from file
clear
fID=fopen('data');
%1.79 GB ~ 20 sec
time = 500E-3;
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
 figure(2)
 title('Filtered Response')
 xlabel('index')    
 ylabel('avg Value')
%Add a filter parameters
N = 1000;
for k=10
    g = cacode([k],10/1.023);   % doing at 10Mhz, c/a code sampling
    g20 = repmat(g,1,20);
    r = xcorr(B,g20);
    figure(2);
    r_s = smooth(r,N);
    plot(abs(r_s));
    hold on
end
