function [M, x_max] = maxderivada(f, n, a, b)
% --------------------------------------------------------
% Esta função determina o máximo do valor absoluto da derivada 
% de ordem n de uma função no intervalo [a,b]
% Entrada:
%    f - a função como string (ex: inline('sin(x)*exp(x)'))
%    n - a derivada de ordem n
%   [a, b] - um intervalo dado
% Saida:
%      M - o valor máximo de |f^n(x)| em [a,b]
%      x_max - a abcissa em [a,b} onde o valor máximo é atingido
%------------------------------------------------------------------
% Calcular derivada f^n(x) 
syms x;
df= diff(f(x), n); 

% Determinar maximo
% Podemos usar a função fminbnd para determinar o máximo de |f^n(x)|
% o valor absoluto de df deve ser expresso como string
% Como esta função calcula o mínimo devemos multiplicar por -1 para
% poder determinar o máximo

x_max = fminbnd(['-1 * abs(', char(df), ')'], a, b);
M = abs(subs(df, x_max));

%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2006
%------------------------------------------------------------------
 