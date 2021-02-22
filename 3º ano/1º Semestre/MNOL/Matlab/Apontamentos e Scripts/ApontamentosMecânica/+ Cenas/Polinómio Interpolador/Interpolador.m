%Tendo a tabela. Escolher n+1 valores (n- grau do polinomio a obter).
%Escolher os valores que rodeiam o valor do qual se pretende saber a
%ordenada e os outros de forma a que estejam o mais proximo possivel do
%valor referido.

x=[-2 -1 0 0.25 1 2 ];
f=[-17 -1 1 1.421875 7 35];

p3=polyfit(x(3:6),f(3:6),3);%colocar os valores de x e os valores de y correspodentes/
%O ultimo valor entre parentises corresponde ao grau do polinomio. Os
%valores resultantes sao os coeficientes do grau do polinomio até o grau 0.
f(0.5)=polyval(p3,0.5);