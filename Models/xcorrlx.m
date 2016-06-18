function z = xcorrlx(x,y,step)
%extended xcorrl function
%correlate x with y, with y being the smaller vector
%x,y,z are row vectors
lx = length(x);
ly = length(y);

    for k=1:step:lx-ly+1
        z(k) = x(k:k+ly-1)*y';
    end
    for k = lx-ly+2:step:lx
        z(k) = x(k:lx)*(y(1:lx-k+1))';
    end
    z = z/(max(y)*length(y));
end 