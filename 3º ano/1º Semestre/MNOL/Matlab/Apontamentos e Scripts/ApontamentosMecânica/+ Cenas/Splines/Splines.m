%Splines Completas (manuais)
x=[15 20 25 30 40 50];
f=[16 20 34 40 60 90];

d0 = (f(2)-f(1))/(x(2)-x(1));
dn = (f(6)-f(5))/(x(6)-x(5)); %para n=6

%s3completa=spline([x(1),x(3:4),x(6)],[d0,f(1),f(3:4),f(6),dn]);
%ramos=s3completa.coefs
%valor=spline([x(1),x(3:4),x(6)],[d0,f(1),f(3:4),f(6),dn],45)

s3=spline(x,f,1.5)
s3.coefs
spline(x,f,1.5)

SE FOR SPLINE COMPLETA:
 
s3 = spline(x,[d0 f dn])