%Considere a equa��o f(x)= 1 -x tan(x) =0 para x ?0. 
% Localize graficamente as duas menores ra�zes positivas. 

x= linspace(0,5);
y1=1./x;
y2=tan(x);

figure(1)
hold on
axis([0  5 0 5]) 
plot(x,y1,'r', x, y2, 'b')
grid on

% podemos determinar as ra�zes com fzero
f=inline('1-x.*tan(x)');

display('Um intervalo que cont�m a menor ra�z positiva � [0.5, 1]');
r1=fzero(f, [0.5 1])

display('Um intervalo que cont�m a segunda ra�z positiva � [3, 3.5]');
r2=fzero(f, [3, 3.5])

% podemos agora incluir no gr�fico as ra�zes eos pontos de intersec��o

plot(r1, 0, 'or', r2, 0, 'or')
plot(r1, tan(r1), 'or', r2, tan(r2), 'or')





