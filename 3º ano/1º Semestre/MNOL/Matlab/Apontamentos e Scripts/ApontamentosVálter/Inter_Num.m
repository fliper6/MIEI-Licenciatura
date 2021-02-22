% Considere a tabela com 5 pontos e calcule o polinómio
% interpolador de grau 4 para estimar o valor em x = 2
% x -2 0 1 5 7
% y 88 10 13 1005 4021

x=[-2  0  1    5    7];
y=[88 10 13 1005 4021];

p=polyfit(x,y,4); % grau 4
% p = 2.0000   -3.0000    5.0000   -1.0000   10.0000
% ou da forma "canónica"
% p = 2x^4 - 3x^3 + 5x^2 - x + 10; -> aparecem apenas os coeficientes!!

y=polyval(p,2) % x = 2

% y = 36 é o valor do p(2);