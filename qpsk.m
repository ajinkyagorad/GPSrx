SNR = 11;
hMod = comm.QPSKModulator;
hScope = comm.ConstellationDiagram;
hAWGN = comm.AWGNChannel('NoiseMethod','Signal to noise ratio (Es/No)','EsNo',SNR);
data = randi([0 3],1000,1);
modData = step(hMod,data);
ampImb = 10; %dB
txReal = exp(0.5*ampImb/20)*real(modData);
txImag = exp(-0.5*ampImb/20)*imag(modData);
txSig  = complex(txReal,txImag);
rxSig = step(hAWGN,txSig);
step(hScope,rxSig)