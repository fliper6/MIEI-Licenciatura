function y = f5_f2(x)
% ------------------------------------------------------------------
% Calcula os valores para a segunda derivada dafun��o da FP 3- Exercicio 5
% f''(x)= -9 x^4 * cos(x^3)- 6 *x *sin(x^3) + 1/x^2;
% Par�metros de entrada
%   x    - um vector com os valores de x
% Par�metros de sa�da
%   y    - o valor de f''(x)
%-------------------------------------------------------------------- 

  y = -9 *x.^4 * cos(x.^3)- 6 *x *sin(x.^3) + 1./x^2;

