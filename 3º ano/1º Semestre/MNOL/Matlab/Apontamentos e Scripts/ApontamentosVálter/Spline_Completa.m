% Considere a tabela para construir a spline cúbica completa. Estime o valor 
% em x = 5.45.
x=[5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0];
y=[0.0639 0.0800 0.0988 0.1203 0.1442 0.1714 0.2010 0.2331 0.2673 0.3036 0.3414];

x0 = 5.45;
% atenção, matlab arrays começam em 1
% definiçao de derivadas nos extremos, implica remover os pontos da tabela
d0 = (y(2)-y(1))/(x(2)-x(1));
dn = (y(11)-y(10))/(x(11)-x(10));

% isto força a ser uma spline completa (remove o 2 e o n-1 elemento da
% tabela)
pp=spline(x([1,3:9,11]),[d0 y([1,3:9,11]) dn]);

% novamente os coefs da spline
pp.coefs;
% ans =
%
% 0.2962    0.0083    0.1610    0.0639
% -0.3444    0.1860    0.1998    0.0988
% 0.4025    0.0827    0.2267    0.1203
% -0.3656    0.2034    0.2553    0.1442  <- porque o 5.45 € [5.4,5.5]
% 0.1600    0.0937    0.2850    0.1714
% -0.1743    0.1417    0.3086    0.2010
% 0.1373    0.0894    0.3317    0.2331
% -0.2328    0.1306    0.3537    0.2673

% para escolher o (x-xI) escolhe-se a parte mais baixa do intervalo!
% s(x) = ?0.3656(x ? 5.4)3 + 0.2034(x ? 5.4)2 + 0.2553(x ? 5.4) + 0.1442.

% o valor de s(x0) é dado por:
xx=spline(x([1,3:9,11]),[d0 y([1,3:9,1]) dn],x0) 