% 1Bit sample Simulated Noise, Single CA code
D  = [ 1 0 1 1 0 1 0 1 1 1 1 0 0 1 0 0 0 0 0 ];
g = 2*cacode([17],2/1.023)-1; % 23 at 2MHz sampling rate
G  = repmat(g,1,20); % g ~ 1mS, G~20mS
% construct signal to be transmitted (mD)
mD = 0;
for i=1:length(D)
    if(D(i))
        bitSpread = G;
    else
        bitSpread = -G;
    end
    mD = [mD bitSpread]; % concatenate the signal
end
%attenuate mD and add noise
attn = 0.1;
[p q] = size(mD);
noise = wgn(p, q, 1);
noise = smooth(noise,4)';
signal = noise + attn*mD;

% signal is the received signal
% sample it using 1bit sampling ~convert to 1bit sampling
sampledSx = sign(signal);

% correlate sampled signal with ca code
cx = xcorrl(sampledSx,G,5E-4*2E6);

% plot  results

figure
plot(cx);


