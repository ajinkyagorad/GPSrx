% generate C/A code and add noise over  it
% with very low SNR ~-20 dB, look for correlation of C/A code
clear

g = cacode([5],10/1.023); %@ 10MHz
figure(3);
plot(g)

[p q] = size(g);
%generate stream of g code
g_s = repmat([g,zeros(1,2*q)],[1 5]); %repeat the code 5 times
g_db = pow2db(bandpower(g_s));%find power of g code we have

figure(1)
for SNR =-20:10:-10 % SNR from -40 to 0
noise_db = -SNR+g_db; 
[p q] = size(g_s); 
attenuation_db = -noise_db;
attn = 10^(attenuation_db/20);
g_s_a = attn*g_s;     % attenuate  the signal to get desired SNR
noise = wgn(p,q,0); % gaussian white noise , size of g_s
signal = noise+g_s_a; % add noise to pure signal
r = xcorr(signal,g_s_a); % check correlation with the signal
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
legend('20dB','10dB','0dB');

