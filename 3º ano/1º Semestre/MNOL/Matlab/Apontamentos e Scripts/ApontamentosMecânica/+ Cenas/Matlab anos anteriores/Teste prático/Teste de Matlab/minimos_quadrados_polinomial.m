clear all
x=[0 1.25 2.5 3.75 5 6.25];
f=[0.26 0.208 0.172 0.145 0.126 0.113];
[p2,res]=polyfit(x,f,5)
%2 grau do polinomio res=S 
%"polyval" serve para estimar um ponto.
%[1 2]-para2 pontos.
valor=polyval(p2,[1 2])