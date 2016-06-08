% generate C/A code and add noise over  it
% with very low SNR ~-20 dB, look for correlation of C/A code
clear

g = cacode([5],10/1.023); %@ 10MHz
[p q] = size(g);
%generate stream of g code
g_s = repmat([g,zeros(1,2*q)],[1 5]); %repeat the code 5 times
g_db = pow2db(bandpower(g_s));%find power of g code we have

info = '';
for powerDiff =40:-10:0 % SNR from -40 to 0
    
noise_db = powerDiff+g_db; % generate noise with dBs more than signal
[p q] = size(g_s); 
noise = wgn(p,q,noise_db); % gaussian white noise , size of g_s
signal = noise+g_s; % add noise to pure signal
r = xcorr(signal,g_s); % check correlation with the signal
t = (1:length(signal))/10E6;
% plot 
subplot(2,1,1)
plot(abs(r))
title('Correlation of gcode with simulated noise')
xlabel('correlation index')
ylabel('corr val')

hold on
subplot(2,1,2);
plot(t,signal)
title('Signal')
xlabel('time')
ylabel('amplitude');
hold on
end
legend('40dB','30dB','20dB','10dB','0dB');

