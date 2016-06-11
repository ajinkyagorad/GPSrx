function z = xcorrl(x,y)
%correlate with y, with y being the smaller vector
lx = length(x);
ly = length(y);
    for k=1:lx-ly+1
        z(:,k) = x(:,k:k+ly).*y;
    end
end