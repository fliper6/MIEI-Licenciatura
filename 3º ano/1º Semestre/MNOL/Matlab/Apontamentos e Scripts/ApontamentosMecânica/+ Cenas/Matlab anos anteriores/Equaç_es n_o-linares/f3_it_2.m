function [y, y1] = f4_it_2(x0)
% ------------------------------------------------------------------
% Calcula os valores para a função iteradora da FP 3- Exercicio 4
% g(x)=(x^3 + 1) /5 e a sua primeira derivada g'(x)
% Parâmetros de entrada
%   x0    - um vector com os valores de x
% Parâmetros de saída
%   y    - o valor de g(x)
%   y1   - o valor de g'(x)
%-------------------------------------------------------------------- 
  syms x; 
  g = (x^3 + 1) /5  ;
  g1 = diff(g);
  y = subs(g,x0); 
  y1 = subs(g1, x0);
  
 
  
  