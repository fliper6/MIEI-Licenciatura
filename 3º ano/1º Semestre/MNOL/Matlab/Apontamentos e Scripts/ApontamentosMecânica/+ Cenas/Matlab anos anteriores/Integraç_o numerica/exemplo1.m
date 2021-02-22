%Exemplo 1
%Aproxime o integral da função f(x) = 1 + e-x sin (4x)  em [0, 1] usando
%adequadamente as diferentes regras de Newton-Cotes simples. Determine um
%majorante para o valor absoluto do erro de truncatura cometido
%no cálculo de cada uma das aproximações encontradas.

clear all; clc; 
format long;

f = inline('1+exp(-x).*sin(4*x)')
a = 0
b = 1

disp('Aproximação pela regra do Trapézio');

ht = (b-a)
It= ht/2 * (f(a) + f(b))

disp('Aproximação pela regra de Simpson');

n = 2
hs = (b-a)/n
x = a: hs: b
y = f(x)
Is= hs/3 * sum([1 4 1].*y)
% ou alternativamente 
%Is = hs/3 * (y(1) + 4*y(2) + y(3))

disp('Aproximação pela regra de 3/8:');

n = 3
h3_8 = (b-a)/n
x = a:h3_8:b
y = f(x)
I3_8= 3*h3_8/8 * sum([1 3 3 1].*y)
% ou alternativamente 
%I3_8 = 3*h3_8/8 * (y(1) + 3*y(2) + 3*y(3)+ y(4))


disp('   ');
disp('Podemos encontrar majorantes para o erro de cada uma das aproximações obtidas'); 
disp('Prima uma tecla para continuar');
pause;

disp('Para a aproximação It determinada pela regra do Trapézio:');
disp('     |e(It)|=|I - It| <= ((b-a)^3 /12)* M2, onde M2 = max |f''''(x)|, x in (0,1)');

% Para determinar M =  max |f''''(x)| em [a, b] podemos usar a função fminbnd(f,a,b) 
% Como fminbnd calcula o mínimo de f(x) em [a,b] para poder determinar 
% o máximo devemos multiplicar por -1 o valor absoluto de df2

syms x;
df2= diff(f(x), 2)
x_max = fminbnd(['-1 * abs(', char(df2), ')'], a, b); 
M2 = abs(subs(df2, x_max));
disp(['O valor maximo, M2 = ', num2str(M2, 8), ' de |f''''(x)| se atinge em x =', num2str(x_max, 8)]);  

% Gráfico de f''(x)
figure(1);
clf;
title(['Gráfico de f''''(x)']);
hold on;
grid on;
x=linspace(a,b);
y=subs(df2,x);
plot(x, y,'b', x_max,0, 'or');

% Gráfico de |f''(x)|
figure(2);
clf;
title(['Gráfico de |f''''(x)|']);
hold on;
grid on;
x=linspace(a,b);
plot(x,abs(y),'b', x_max, M2, 'or');

% fórmula do majorante

M_eIt = (b-a)^3/12 * M2

disp('Para a aproximação Is determinada pela regra de Simpson:');
disp('    |e(Is)|=|I - Is| <= h^5 /90 * M4, M4= max |f^{4}(x)|, x in (0, 1)');

syms x;
df4= diff(f(x), 4)
x_max = fminbnd(['-1 * abs(', char(df4), ')'], a, b); 
M4 = abs(subs(df4, x_max));
disp(['O valor maximo, M4 = ', num2str(M4, 8), ' de |f^{4}(x)| se atinge em x =', num2str(x_max, 8)]);

% Gráfico de f4(x)
figure(3);
clf;
title(['Gráfico de f^{4}(x)']);
hold on;
grid on;
x=linspace(a,b);
y=subs(df4,x);
plot(x,y,'b', x_max, 0, 'or');

% Gráfico de |f4(x)|
figure(4);
clf;
title(['Gráfico de |f^{4}(x)|']);
hold on;
grid on;
x=linspace(a,b);
y= abs(y);
plot(x,y,'b', x_max, M4, 'or');

M_eIs = hs^5/90 * M4

disp('Para a aproximação I3/8 determinada pela regra de 3/8:');
disp('    |e(I3/8)|=|I - Is|= 3/80 h^5 * M4, M4= max |f^{4}(x)|, x in (0, 1)');

M_eI3_8 = 3/80 * (h3_8)^5 * M4

disp('      ');
disp('Podemos confirmar os majorantes anteriores porque sabemos calcular');
disp('o valor do integral da função dada e o erro absoluto de cada aproximação');
disp('Prima uma tecla para continuar');
pause;

syms x;
I = double(int(f(x), a, b));

disp(['O valor do integral...................... ....I = ', num2str(I, 15)]);
disp(['O valor aproximado pela regra do trapézio....It = ', num2str(It, 15)]);
disp(['O valor aproximado pelo regra de Simpson.....Is = ', num2str(Is, 15)]);
disp(['O valor aproximado pelo regra de 3/8.......I3/8 = ', num2str(I3_8, 15)]);

eIt= abs(I-It);
disp('O erro absoluto de It:')
disp(['|e(It)|= |I - Itc|= ', num2str(eIt, 15), '<= ', num2str(M_eIt, 15)]);

eIs= abs(I-Is);
disp('O erro absoluto de Is:');
disp(['|e(Is)|= |I - Is|= ', num2str(eIs, 15), '<= ',num2str(M_eIs, 15)]);

eI3_8= abs(I-I3_8);
disp('O erro absoluto de I3/8:');
disp(['|e(It3_8)|= |I - I3_8|= ', num2str(eI3_8, 15), ' <= ',num2str(M_eI3_8, 15)]);


