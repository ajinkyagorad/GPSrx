for k=1:5
    g = cacode([k])-0.5;
    r = xcorr(g,g);
    plot(abs(r))
    hold on
end 