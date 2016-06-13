%simulate the gps signal received by the GPS
D = [ 1 0 0 1 0 1 0 1]; % data to be sent
G = 2*(cacode([3])-0.5); %  spreading code
mD=0; %modulated data
chipFreq = 1.023E6;

for i=1:length(D)
    if(D(i))
        bitSpread = G;
    else
        bitSpread = -G;
    end
    mD = [mD bitSpread];
end
t = [1:length(mD)]/chipFreq;
y = xcorrlx(mD,G);

plot(t,y)