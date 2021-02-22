function [y, y1] =f2(x)
% ------------------------------------------------------------------
% Calcula os valores para a fun��o do exemplo 2
% f(x)= x^^3 - 2 *e^-x
% e a sua primeira derivada
% Par�metros de entrada
%   x    - um vector com os valores de x
% Par�metros de sa�da
%   y    - o valor de f(x)
%   y1   - o valor de f'(x)
%-------------------------------------------------------------------- 
  y = x.^3-2*exp(-x);
  y1= 2./exp(x) + 3*x.^2;

