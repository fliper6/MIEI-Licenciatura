function [y, y1] = f3(x)
% ------------------------------------------------------------------
% Calcula os valores para a função FP 3- Exercicio 4
% f(x)=x^3 - 5*x + 1 e a sua primeira derivada f'(x)
% Parâmetros de entrada
%   x    - um vector com os valores de x
% Parâmetros de saída
%   y    - o valor de f(x)
%   y1   - o valor de f'(x)
%--------------------------------------------------------------
y = polyval([1,0,-5,1], x);
y1 = polyval([3,0,-5], x);
