function [y, y1] = f5(x)
% ------------------------------------------------------------------
% Calcula os valores para a fun��o do Exercicio 5 da Folha Pratica 3
% f(x)=cos(x^3) - log(x)
% Par�metros de entrada
%   x    - um vector com os valores de x
% Par�metros de sa�da
%   y    - o valor de f(x)
%   y1   - o valor de f'(x)
%-------------------------------------------------------------------- 
  y = cos(x.^3)-log(x);
  y1 = (-3*x.^2).* sin(x.^3) - 1./x;
  
 
  
  