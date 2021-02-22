clear all
A=[1500 1700 1900;25 33 42;100 120 160];
b=[106000 2170 8200]';
x1=[5 5 5]';
eps=0.25;
D=diag(diag(A))
L=-(tril(A)-D)
U=-(triu(A)-D)

%1ª iteração
aux=U*x1+b
x2=(D-L)\aux
%critério de paragem
CP=norm((x2-x1),2)/norm(x2)
if CP<eps
    disp('o método convergiu')
else
    disp('o método ainda não convergiu')
end

%2ª iteração
aux=U*x2+b
x3=(D-L)\aux
%critério de paragem
CP=norm((x3-x2),2)/norm(x3)
if CP<eps
    disp('o método convergiu')
else
    disp('o método ainda não convergiu')
end