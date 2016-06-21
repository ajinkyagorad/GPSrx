%Correlate GPS data with the C/A codes
clear
%parameteres
sampling_rate_Mhz =10;
time = 100E-3;
ca_codes =[14 27];
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
B = abs(B); % merge both in phase and quadrature component into one

 %B = decimate(B,5);sampling_rate_Mhz=2; %Add a filter parameters
 leg  = cell(1,length(ca_codes));
 figure(2)
 hold all;
for kk = 1:length(ca_codes)
    k = ca_codes(kk);
    g = 2*(cacode([k],sampling_rate_Mhz/1.023)-0.5);   % doing at 10Mhz, c/a code sampling
    g20 = repmat(g,1,20);   % repeat matrix g 20 times gggg....ggg
    r = xcorr(B,g20);
    %figure(2);
    %f = fft(r);
    %r_s = smooth(r,smoothingN);    
    leg{kk}=['CA',num2str(k)];
    plot(r);
end
title('Response')
xlabel('index')    
ylabel(' Value')
legend(leg)