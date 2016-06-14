%Correlate GPS data with the C/A codes
clear
%parameteres
sampling_rate_Mhz =10;
time = 40E-3;
ca_codes =[1:1:37]
smoothingN = 1000;
% read data from file
fID=fopen('data');
%1.79 GB ~ 20 sec

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
 title('Response')
 xlabel('index')    
 ylabel('avg Value')
%Add a filter parameters

for kk = 1:length(ca_codes)
    k = ca_codes(kk);
    disp(k);
    g = cacode([k],sampling_rate_Mhz/1.023)-0.5;   % doing at 10Mhz, c/a code sampling
    g20 = repmat(g,1,20);
    r = xcorr(B,g);
    figure(2);
   % r_s = smooth(r,smoothingN);
    plot(real(r));
    
    hold on
end
