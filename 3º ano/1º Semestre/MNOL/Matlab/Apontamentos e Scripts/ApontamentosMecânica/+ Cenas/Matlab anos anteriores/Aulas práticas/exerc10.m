clear all
A=[-200 50 0 0;50 -125 75 0;0 75 -300 225;0 0 -225 225];

%matriz estrita e diagonalmente dominante?
L1=abs(A(1,1))>sum(abs(A(1,:)))-abs(A(1,1))
L2=abs(A(2,2))>sum(abs(A(2,:)))-abs(A(2,2))
%matriz simétrica
S=A==A'

%||CGS||p < 1?
%norma da matriz iteração CGS
D=diag(diag(A))
L=-(tril(A)-D)
U=-(triu(A)-D)
CGS=inv(D-L)*U

norma1=norm(CGS,1)<1
norma_inf=norm(CGS,inf)<1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Esta parte não é necessária para este exercício!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%matriz definida positiva?
dA1=det(A(1,1))>0
dA2=det(A(1:2,1:2))>0
dA3=det(A(1:3,1:3))>0
dA4=det(A(1:4,1:4))>0