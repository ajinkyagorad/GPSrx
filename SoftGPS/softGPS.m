%Simulate Soft GPS data
% 12MSPS, IF = 3.563M, 1 bit sampling
% The following PRN-s are present in the record: 01, 03, 07, 19, 20, 22, 24, 28, 31.
clear
IF = 3.563E6;
corrTime = 0.1E-3;
time = 300E-3; Fs = 12E6; step = corrTime*Fs;
samples = time*Fs;
[fid, message] = fopen('data', 'r', 'b');
data = fread(fid,samples, 'ubit1')';
data = data * 2 - 1; %To convert values to +/- 1
%%
t = [1:length(data)]/Fs;
%data = data.*sin(2*pi*IF*t); % shift by IF
g = 2*cacode([1],12/1.023)-1;
G = repmat(g,1,20);
r = xcorrl(data,G,step);
plot(r);