clear
fid = fopen('FMsink');
 bytes = getfield(dir('FMsink'), 'bytes');
data = fread(fid,[2 bytes/4/2],'float32');
I = data(1,:);
Ib = sign(I);
Q = data(2,:);
Qb = sign(Q);
data = Ib+Qb*i;

fWriteReal = fopen('r.bin','w');
fwrite(fWriteReal,Ib);
fclose(fWriteReal);

