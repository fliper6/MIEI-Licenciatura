function [M, x_max] = maxderivada(f, n, a, b)
% --------------------------------------------------------
% Esta fun��o determina o m�ximo do valor absoluto da derivada 
% de ordem n de uma fun��o no intervalo [a,b]
% Entrada:
%    f - a fun��o como string (ex: inline('sin(x)*exp(x)'))
%    n - a derivada de ordem n
%   [a, b] - um intervalo dado
% Saida:
%      M - o valor m�ximo de |f^n(x)| em [a,b]
%      x_max - a abcissa em [a,b} onde o valor m�ximo � atingido
%------------------------------------------------------------------
% Calcular derivada f^n(x) 
syms x;
df= diff(f(x), n); 

% Determinar maximo
% Podemos usar a fun��o fminbnd para determinar o m�ximo de |f^n(x)|
% o valor absoluto de df deve ser expresso como string
% Como esta fun��o calcula o m�nimo devemos multiplicar por -1 para
% poder determinar o m�ximo

x_max = fminbnd(['-1 * abs(', char(df), ')'], a, b);
M = abs(subs(df, x_max));

%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2006
%------------------------------------------------------------------
 