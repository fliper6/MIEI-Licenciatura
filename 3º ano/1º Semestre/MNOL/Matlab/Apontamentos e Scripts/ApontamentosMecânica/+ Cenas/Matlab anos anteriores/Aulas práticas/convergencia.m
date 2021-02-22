function []=convergencia(A)
%Estudo da convergência do método de Gauss-Seidel
%Isabel Espírito Santo
%iapinho@dps.uminho.pt
%2012/03/09
n=size(A,1);
for i=1:n
    if abs(A(i,i))>sum(abs(A(i,:)))-abs(A(i,i))
        aux(i)=1;
    else aux(i)=0;
    end
end
if all(aux)==1
    disp('A matriz A é estrita e diagonalmente dominante')
    disp('O método de Gauss-Seidel converge')
    return
else
    disp('A matriz A não é estrita e diagonalmente dominante')
end


teste=A==A';
if all(all(teste))==1
    disp('A matriz A é simétrica')
    teste1=1;
else
    disp('A matriz A não é simétrica')
    teste1=0;
    teste2=0;
end
if teste1==1
    for i=1:n
        dA(i)=det(A(1:i,1:i));
        if dA(i)>0
            aux(i)=1;
        else
            aux(i)=0;
        end
    end
    if all(aux)==1
        disp('A matriz A é definida positiva')
        teste2=1;
    else
        disp('A matriz A não é definida positiva')
        teste2=0;
    end
end
testefinal=[teste1 teste2];
if all(testefinal)==1
    disp('O método de Gauss-Seidel converge')
    return
end

D=diag(diag(A));
L=-tril(A)+D;
U=-triu(A)+D;
%CGS=inv(D-L)*U
CGS=(D-L)\U;
if norm(CGS,1)<1
    disp('A norma um de GS é menor que 1')
    disp('O método de Gauss-Seidel converge')
    return
elseif norm(CGS,inf)<1
    disp('A norma infinita de GS é menor que 1')
    disp('O método de Gauss-Seidel converge')
    return
else
    disp('Nada se pode concluir acerca da convergência do método de Gauss-Seidel')
end







