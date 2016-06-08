% plots C/A codes for fun

%CA codes to plot
ca_codes = [5 17];
freq_Mhz = 5;
L = length(ca_codes);
color = ['b','r'];
for kk = 1:L
    k = ca_codes(kk);
    g = cacode([k],freq_Mhz/1.023);
    subplot(L,1,kk);
    plot(g,'color',color(kk))
    title('C/A PRN gold Codes')
    xlabel('index')
    a = sprintf('g%i',k);
    legend(a)
end 
