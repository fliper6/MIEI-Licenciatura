function [y, y1] =f2_old(x0)
% ------------------------------------------------------------------
% Calcula os valores para a função do exemplo 2
% f(x)= x^^3 - 2 *e^-x
% Parâmetros de entrada
%   x0    - um vector com os valores de x
% Parâmetros de saída
%   y    - o valor de F(x)
%   y1   - o valor de F'(x)
%-------------------------------------------------------------------- 
  syms x; 
  f = x^3-2*exp(-x); 
  f1 = diff(f);
  y = subs(f,x0); 
  y1 = subs(f1, x0);

