function [y, y1] = f13(x0)
% ------------------------------------------------------------------
% Calcula os valores para a fun��o do exerc�cio 13 da folha pr�tica 3
% F(x)=(cos(x)-x/2)^2 
% Par�metros de entrada
%   x0    - um vector com os valores de x
% Par�metros de sa�da
%   y    - o valor de F(x)
%   y1   - o valor de F'(x)
%-------------------------------------------------------------------- 
  syms x; 
  f = (cos(x)-x/2)^2 ;
  f1 = diff(f);
  y = subs(f,x0); 
  y1 = subs(f1, x0);
  
 
  
  