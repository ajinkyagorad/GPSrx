for k=1:5
    g = cacode([k]);
    r = xcorr(g,g);
    plot(abs(r))
    hold on
end 