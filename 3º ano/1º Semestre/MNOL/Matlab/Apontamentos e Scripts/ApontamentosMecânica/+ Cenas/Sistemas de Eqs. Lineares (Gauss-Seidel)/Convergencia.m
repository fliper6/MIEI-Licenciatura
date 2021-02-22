%Assumindo uma matriz 3 x 3
A=[2 1 1; 2 3 1; 1 1 3];
%Se uma destas condi��es se verificar o m�todo converge. Quando uma das
%condi��es n�o se verificar nada se pode concluir e passa-se para a
%condi��o seguinte.

%ESTRITA E DIAGONALMENTE DOMINANTE

%A soma do valor absolutos da linha que est�o fora da diagonal tem de ser
%menor que o valor da linha que est� na diagonal
A
linha1=sum(abs(A(1,2:3)))
linha2=sum(abs(A(2,1:2:3)))
linha3=sum(abs(A(3,1:2)))

%SIM�TRICA E DEFINIDA POSITIVA

%Sim�trica:
Simetria=A-A'

%Definida Positiva (cada um dos determinantes deve de ser > 0:

Determin1=det(A(1:1,1:1))
Determin2=det(A(1:2,1:2))
Determin3=det(A(1:3,1:3))

%DETERMINANTE DA MATRIZ ITERA��O < 1 - (D-L)Cgs=U

D=diag(diag(A))
U=-triu(A,1)
L=-tril(A,-1)

%Para verificar UM destes valores dever� ser menor do que zero
C_GS=(D-L)\U
INFINITO=norm(C_GS,inf)
UM=norm(C_GS,1)
