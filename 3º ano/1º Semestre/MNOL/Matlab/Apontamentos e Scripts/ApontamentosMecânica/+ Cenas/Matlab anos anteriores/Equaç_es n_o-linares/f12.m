function [y,y1] = f12(x)
% ------------------------------------------------------------------
% Calcula os valores para a fun��o do exercicio 12 da folha pr�tica
% f(x)= exp(x)-1-x-(x^2)/2 - (x^3/6) * exp(0.3.*x)
% Par�metros de entrada
%   x   - um vector com os valores de x
% Par�metros de sa�da
%   y    - o valor de f(x)
%   y1   - o valor de f'(x)
%--------------------------------------------------------------------  
  y = 1 + x + (x.^2)/2 + (x.^3/6) * exp(0.3*x) - exp(x); 
  y1 = x - exp(x) + (x.^2*exp((3*x)./10))/2 + (x.^3*exp((3*x)./10))./20 + 1

  
 
  
  