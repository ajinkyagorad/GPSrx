clear
fid = fopen('SimGPSsink');
 bytes = getfield(dir('SimGPSsink'), 'bytes');
data = fread(fid,[2 bytes/4/2],'float32');
I = data(1,:);
Ib =((int8(sign(I))+1)/2)+48; %convert to byte, +1 -1 and 0;
Q = data(2,:);
Qb = sign(Q);

fWriteReal = fopen('r.bin','w');
fwrite(fWriteReal,Ib);
fclose(fWriteReal);

