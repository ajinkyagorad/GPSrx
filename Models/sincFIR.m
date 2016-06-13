%sinc filter design
clear
y = [1 2 -2 5 6];
F = @(x) sinc(x);
t = -5:0.1  :5;
z = 0;
for k = 1:length(y)
      z = ( z + y(k)*F(t-k));
end
hold on
plot(y,'o')
plot(t,z)



    