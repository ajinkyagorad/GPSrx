%Correlate GPS data with the C/A codes
% read data from file
clear

fID=fopen('data');
%1.79 GB ~ 20 sec
time = 30E-3;
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
% figure(2)
% title('Filtered Response')
% xlabel('index')
% ylabel('avg Value')
%Add a filter parameters
N = 3000;
%figure(3)
%stitle('avg input signal')
%plot(smooth(abs(B),2000));
for k=1:2
    g = cacode([k],10/1.023);   % doing at 10Mhz, c/a code sampling
    g20 = repmat(g,1,20);
    r = xcorr(B,g20);
    
    %r_f = smooth(r,N);
     figure(1);
     plot(abs(r));
     hold on
    
%      figure(2)
%      plot(abs(r_f));
%      hold on
end
