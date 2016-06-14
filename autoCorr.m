clear


time = 100E-3;
fID=fopen('data');%1.79 GB ~ 20 sec
    
bytesPerSec= (1.79*1024*1024*1024)/20;
bytes = time*bytesPerSec;
readSize = [2 floor(bytes/2)];
disp('Read Size(MB): ');
disp(bytes/1024/1024);
k = waitforbuttonpress;
data=fread(fID,readSize);
A = data';
                
B = A(:,1)+i*A(:,2);% B has the complex actual sampled data by SDR/USRP
B = B';
B = abs(B);
figure(1)
plot(abs(fft(B)))
y = xcorr(B,B);
figure(2)
plot(y);