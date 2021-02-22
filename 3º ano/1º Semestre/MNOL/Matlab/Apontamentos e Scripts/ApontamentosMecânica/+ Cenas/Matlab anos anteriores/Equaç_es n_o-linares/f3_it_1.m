function [y, y1] = f4_it_1(x)
% ------------------------------------------------------------------
% Calcula os valores para a função iteradora da FP 3- Exercicio 3
% g(x)=(5*x-1)^(1/3) e a sua primeira derivada g'(x)= 5/3 * (5*x-1)^(-2/3)
% Parâmetros de entrada
%   x    - um vector com os valores de x
% Parâmetros de saída
%   y    - o valor de g(x)
%   y1   - o valor de g'(x)
% ---------------------------------------------------------------------
% Para obter a raiz real de um número real negativo "x", em vez de executar:
% x.^(1/3)devemos usar sign(x).*abs(x.^(1/3)). Isto porque a raiz retornada pelo
% operador ^ do MatLab é a raiz complexa com o menor angulo de fase.
% Cada número tem três raízes cúbicas. Estas três raízes podem ser todas reais,
% ou pelo contrário ser apenas uma real, enquanto as duas outras são números complexos conjugados. 
% Se expressarmos um número real negativo x =- a, a (real positivo) como 
% um número complexo z = a e^(i pi) (note que e(i pi) = cos(pi) + i sin(pi) = -1) então
% as 3 raízes de x  podem ser calculadas pela fórmula: 
% (a)^(1/3) x exp(i*k* pi/3), k=1,2,3. Assim a raiz retornada pelo Matlab e
% aquela onde k=1. 
% -------------------------------------------------------------------------

y= sign(5*x-1).*abs((5*x-1).^(1/3));
y1= 5/3 * abs((5*x-1).^(-2/3));
