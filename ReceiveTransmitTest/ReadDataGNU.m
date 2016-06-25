clear
fid = fopen('FMsink');
data = fread(fid,[2 4*100],'float32');
r = data(1,:);
i = data(2,:);
