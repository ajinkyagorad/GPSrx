%sinc filter design
%Equivalend to Rectangular filter in Frequency domain
clear
X = [1:100];
y = X.*sin(X);
F = @(x) sinc(x);
t = -1:0.1:100;
z = 0;
for k = 1:length(y)
      z = ( z + y(k)*F(t-k));
end
hold on
plot(y,'o')
plot(t,z)
title('Discrete Samples after sinc filter');
xlabel('index')
ylabel('value')
legend('sin(X)','\Sigma Sinc');



    