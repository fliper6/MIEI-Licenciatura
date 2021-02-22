function [y, y1] = f13(x0)
% ------------------------------------------------------------------
% Calcula os valores para a função do exercício 13 da folha prática 3
% F(x)=(cos(x)-x/2)^2 
% Parâmetros de entrada
%   x0    - um vector com os valores de x
% Parâmetros de saída
%   y    - o valor de F(x)
%   y1   - o valor de F'(x)
%-------------------------------------------------------------------- 
  syms x; 
  f = (cos(x)-x/2)^2 ;
  f1 = diff(f);
  y = subs(f,x0); 
  y1 = subs(f1, x0);
  
 
  
  