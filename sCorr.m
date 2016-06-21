%SELF CONTAIN CORRELATION
clear
%parameteres
sampling_rate_Mhz =10;
time = 50E-3;
ca_codes =[17 22 23 24 27];
smoothingN = 1E4;
% read data from file
fID=fopen('data');
%1.79 GB ~ 20 sec
    
bytesPerSec= (1.79*1024*1024*1024)/20;
bytes = time*bytesPerSec;
readSize = [2 floor(bytes/2)];
disp('Read Size(MB): ');
disp(bytes/1024/1024);
k = waitforbuttonpress;
data=fread(fID,readSize);
A = data';
% B has the complex actual sampled data by SDR/USRP
B = A(:,1)+i*A(:,2);
B = B';

 leg  = cell(1,length(ca_codes));
 figure(2)
 hold all;
a = B(1:20E4);
r = xcorr(B,a);
plot(abs(smooth(r,30)));
title('Response')
xlabel('index')    
ylabel(' Value')
legend(leg)