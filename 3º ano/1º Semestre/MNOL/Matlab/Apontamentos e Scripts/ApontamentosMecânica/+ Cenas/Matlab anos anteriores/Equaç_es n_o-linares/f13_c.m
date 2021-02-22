function [y, y1] = f14_c(x0)
% ------------------------------------------------------------------
% Calcula os valores para a fun��o da FP 3- Exercicio 14
% f(x)=(cos(x)-x/2)
% Par�metros de entrada
%   x0    - um vector com os valores de x
% Par�metros de sa�da
%   y    - o valor de F(x)
%   y1   - o valor de F'(x)
%-------------------------------------------------------------------- 
  syms x; 
  f = (cos(x)-x/2) ;
  f1 = diff(f);
  y = subs(f,x0); 
  y1 = subs(f1, x0);
  
 
  
  