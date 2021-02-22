%Integração numérica (quando te dão tabelas)
x=[0 0.1 0.2 0.3 0.5 0.7 1];
f=[0 0.001 0.04 0.0899 0.2280 0.4141 0.7104];
I=trapz(x,f) %utilizas sempre esta função

f = @(x) 4./(1+x.^2)
integral(f,a,b)