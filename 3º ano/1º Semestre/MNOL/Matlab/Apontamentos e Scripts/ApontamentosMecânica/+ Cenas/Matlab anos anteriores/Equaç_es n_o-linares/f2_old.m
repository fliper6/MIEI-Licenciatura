function [y, y1] =f2_old(x0)
% ------------------------------------------------------------------
% Calcula os valores para a fun��o do exemplo 2
% f(x)= x^^3 - 2 *e^-x
% Par�metros de entrada
%   x0    - um vector com os valores de x
% Par�metros de sa�da
%   y    - o valor de F(x)
%   y1   - o valor de F'(x)
%-------------------------------------------------------------------- 
  syms x; 
  f = x^3-2*exp(-x); 
  f1 = diff(f);
  y = subs(f,x0); 
  y1 = subs(f1, x0);

