%simulate the gps signal received by the GPS
D = [ 1 0 0 1 0 1 0 1 1 1 1 1 0 0 0 0 0]; % data to be sent
ca = 3;
G = 2*(cacode([ca])-0.5); %  spreading code
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
mDs =0.02*mD+wgn(p,q,0);
y = xcorrlx(mDs,G,1);
plot(y);
legend(leg);
title('Correlation with spreaded signal')
xlabel('index')
ylabel('value')
