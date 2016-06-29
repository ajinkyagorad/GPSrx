%%simulate the gps signal received by the GPS
% in phase , zero frequency offset
clear;
D = [ 1 0 0 1 0 1 0 1 1 1 1 1 0 0 0 0 0]; % data to be sent
ca = 3;
g = 2*(cacode([ca],10)-0.5); %  spreading code
G = repmat(g,[1 20]); % repeat 20 times CA code, 1 data bit
mD=0; %modulated data
chipFreq = 1.023E6;
leg = 'D = ';
for i=1:length(D)
    if(D(i))
        bitSpread = G;
    else
        bitSpread = -G;
    end
    mD = [mD bitSpread]; % concatenate the signal
    leg = [leg num2str(D(i)) ' ']
end
leg = [leg '@g' num2str(ca)]
t = [1:length(mD)]/chipFreq;
[p q] = size(mD);
mDs =0.1*mD+wgn(p,q,0);
%mDs = sin(2*3.14*10*[1:length(mDs)]).*mDs;
%% now correlate signal with the code
%y = xcorrlx(mDs,G,50); % get cross correlation
r = xcorr(mDs,g);
y = r(end-length(mDs)+1:end);
plot(y);
legend(leg);
title('Correlation with spreaded signal')
xlabel('index')
ylabel('value')
%%find the avg value over the intervals
bitSamples = length(g);
bit = 0;
for begin = 1:length(G):length(mDs)-length(G)
    bit = [bit sum(y(begin:begin+length(G)))];
end
figure(2)
plot(bit(2:end));



