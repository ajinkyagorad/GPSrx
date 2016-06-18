function z = xcorrl(x,y,step)
%correlate x with y, with y being the smaller vector
%x,y,z are row vectors
lx = length(x);
ly = length(y);

    for k=1:step:lx-ly+1
        z(ceil(k/1000)) = x(k:k+ly-1)*y';
    end
end