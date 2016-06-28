%%Correlate GPS data with the C/A codes
clear;
%parameteres
ca_codes =[1:1:37]; % array conntaining all the CA codes
sampling_rate_Mhz =10;
time = 50E-3;
datalen = time *sampling_rate_Mhz*1E6;
% read data from file
fID=fopen('data');
fileSize = datalen * 8 % filesize in bytes
k = waitforbuttonpress;
disp('...');
data=fread(fID,[2 datalen],'float32');
% A = data';
% % B has the complex actual sampled data by SDR/USRP
% B = A(:,1)+i*A(:,2);
% B = B';
% B = abs(B); % merge both in phase and quadrature component into one
B = data(1,:)+i*data(2,:);

%B = decimate(B,5);sampling_rate_Mhz=2; %Add a filter parameters
leg  = cell(1,length(ca_codes));

%hold all;
for kk = 1:length(ca_codes)
    k = ca_codes(kk);
    g = 2*(cacode([k],sampling_rate_Mhz/1.023)-0.5);   % doing at 10Mhz, c/a code sampling
    %g20 = repmat(g,1,20);   % repeat matrix g 20 times gggg....ggg
    r = xcorrlx(real(B),g,1);
    %figure(2);
    %f = fft(r);
    %r_s = smooth(r,smoothingN);    
    %leg{kk}=['CA',num2str(k)];
    pause(1)
    plot(r);
    
end
% title('Response')
% xlabel('index')    
% ylabel(' Value')
% legend(leg)