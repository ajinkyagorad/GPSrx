clear
fid = fopen('FMsink');
data = fread(fid,[2 2000],'float32');
r = data(1,:);
img = data(2,:);
c = r+i*img;

for theta=0:0.1:6.28*10
    cor = c*exp(i*theta);
    plot(real(cor))
    hold on
    plot(imag(cor))
    hold off
    pause(0.1);
end