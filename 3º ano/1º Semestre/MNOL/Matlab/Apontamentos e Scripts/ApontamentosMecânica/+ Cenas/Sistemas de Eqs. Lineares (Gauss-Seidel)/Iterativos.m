%Descobrir as soluções:
A=[1 0.5 0.5; 0.5 1 0.5; 0.5 0.5 1];
b=[2 2 2]';
xk=[1.25 1.125 0.8125]';
k=1;
s=k+1;
D=diag(diag(A));
U=-triu(A,1);
L=-tril(A,-1);

Y=D-L;
Z=U*xk+b;
xs=Y\Z

%Critério de Paragem (tem de ser menor que o erro admissível):
numerador=norm(xs-xk,inf);
denominador=norm(xs,inf);
CP=numerador/denominador

