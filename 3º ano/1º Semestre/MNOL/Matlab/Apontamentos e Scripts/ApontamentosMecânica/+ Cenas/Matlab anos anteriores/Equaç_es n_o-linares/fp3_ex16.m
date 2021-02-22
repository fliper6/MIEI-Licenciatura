figure(1);
clf;
axis([-6 6 -3 3])
hold on;
ezplot('187.7*q1^(1/0.56) + 31.28*q2^(1/0.56)-1000');
ezplot('q1-2*q2');
grid on;
format long e;
Xa=[2 1 1 2]';
[X, iter, erroX, erroF]=newton2gen('f16', Xa, 10^-4, 10^-4, 100)
Xb=[-2 -2 -2 2]';
[X, iter, erroX, erroF]=newton2gen('f16', Xb, 10^-4, 10^-4, 100)