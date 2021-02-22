% -----------------------------------------------------------------
%   FP5- Exerc. 2
% Calcular o valor aproximado do integral I = int(exp(-x^2)) dx em [0,1]
% pelas regras dos trapézios e Simpson, usando 20 subintervalos. 
% --------------------------------------------------------

clc;
format long e;

% Dados de entrada
a=0
b=1
f=inline('exp(-x.^2)')
n=20

% Usando a regra dos Trapezios Composta;

disp('Prima uma tecla para calcular um valor aproximado do integral'); 
disp('usando a regra dos trapézios e de Simpson compostas:');
disp('                  ');
pause;
disp('-----------------------------------------------------------------');

Itc = trapezios(f, a, b, n);
Isc = simpson(f, a, b, n);

disp('                  ');
disp(['O valor aproximado do integral I usando a regra de trapézios composta: Itc = ', num2str(Itc, 15)]);
disp(['O valor aproximado do integral I usando a regra de Simpson composta..: Isc = ', num2str(Isc, 15)]);
disp('-----------------------------------------------------------------');
disp('Para calcular a precisão que é possivel garantir em cada uma das aproximações');
disp('obtidas para I (# de casas decimais correctas) podemos calcular um majorante'); 
disp('do erro de truncatura para cada aproximação'); 
disp('Prima uma tecla para continuar');
pause;

disp('Para a aproximação Itc obtida pela regra dos trapézios composta');
disp('|e(Itc)| <= M *(b-a)^3 /(12 n^2) , M =  max |f''''(x)| em [a, b]');
disp('Calcular máximo de |f''''(x)| em [a, b]');
disp('Prima uma tecla para calcular M =  max |f''''(x)| em [a, b]');
pause;

syms x;
df2= diff(f(x), 2)

disp('Para determinar M podemos analizar o gráfico de f''''(x) em [0,1]');
% Gráfico de f''
figure(1)
clf;
title(['Gráfico de f''''(x)']);
hold on;
grid on;
x=linspace(a,b);
plot(x,subs(df2,x),'b'); 

disp('Por análise do gráfico vemos que a função é monótona crescente');
y1= abs(subs(df2,0));
y2 =abs(subs(df2,1));

disp(['Como |f''''(0)|=', num2str(y1, 4), ' e |f''''(1)|=', num2str(y2, 4), ' então M=max |f''''(x)|=|f''''(0)| =', num2str(y1, 4)]);
plot(0, y1, 'or');
M=max(y1,y2);
IM = ((b-a)^3 / (12 * n^2) )* M; 

disp([' Como |e(Itc)| <= ', num2str(IM, 8), '<  0.0005 = 0.5 x 10^-3']);
disp('então a aproximação Itc de I tem pelo menos 3 casas decimais correctas');

disp('    ');
disp('Para a aproximação Isc obtida pela regra de Simpson composta');
disp('|e(Isc)| <= M *(b-a)^5 /(180 n^4) , M =  max |f^(4)(x)| em [a, b]');

disp('               ');
disp('Calcular máximo de |f^4(x)| em [a, b]');
disp('Prima uma tecla para calcular M =  max |f^4(x)| em [a, b]');
pause;

syms x;
df4= diff(f(x), 4) 

disp('Para determinar M podemos analizar o gráfico de f^4(x) em 0,1]');
% Gráfico da quarta derivada de f(x)
figure(2)
clf;
title(['Gráfico da quarta derivada de f(x)']);
hold on;
grid on;
x=linspace(a,b);

% Para determinar M =  max |f^(4)(x)| em [a, b] podemos usar a função fminbnd(f,a,b) 
% Como fminbnd calcula o mínimo de f(x) em [a,b] para poder determinar 
% o máximo devemos multiplicar por -1 o valor absoluto de df2

x_max = fminbnd(['-1 * abs(', char(df4), ')'], a, b); 

plot(x,subs(df4,x),'b', x_max,subs(df4,x_max), 'or');

disp('Por análise do gráfico vemos que a função é monótona decrescente');

y1= abs(subs(df4,0));
y2 =abs(subs(df4,1));

disp(['Como |f^4(0)|=', num2str(y1, 4), ' e |f^4(1)|=', num2str(y2, 4), ' então M =max |f^4(x)|=|f^4(0)| =', num2str(y1, 4)]);

M=max(y1,y2);

% podemos agora calcular o majorante do erro absoluto
IM = ((b-a)^5 / (180 * n^4) )* M;  
disp(['Como |e(Isc)| <= ', num2str(IM, 8), '<  0.5 x 10^(-6)']);
disp('então a aproximação Itc de I tem pelo menos 6 casas decimais correctas');
disp('    ');

disp('Podemos confirmar a precisão das aproximações porque sabemos calcular');
disp('o valor do integral da função dada');
disp('Prima uma tecla para continuar');
pause;

syms x;
I = double(int(f(x), a, b));

disp(['O valor do integral....................................I = ', num2str(I, 15)]);
disp(['O valor aproximado pela regra do trapézio composta...Itc = ', num2str(Itc, 15)]);
disp(['O valor aproximado pelo regra de Simpson composta....Isc = ', num2str(Isc, 15)]);

eItc= abs(I-Itc);
disp(['O erro absoluto de Itc.....|e(Itc)|= |I - Itc|= ', num2str(eItc, 15)]);
eIsc= abs(I-Isc);
disp(['O erro absoluto de Isc.....|e(Isc)|= |I - Isc|= ', num2str(eIsc, 15)]);







%------------------------------------------------------------------
%  Gladys Castillo, António Pereira, U.A, 2009
%------------------------------------------------------------------
