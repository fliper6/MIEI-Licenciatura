function []=gauss_seidel(A,b,x1,eps,nmax)
%Implentação do método de Gauss-Seidel
%Isabel Espírito Santo
%iapinho@dps.uminho.pt
%2012/03/09
D=diag(diag(A));
L=-tril(A)+D;
U=-triu(A)+D;
DL=D-L;
x(:,1)=x1;
CP=inf;
k=0;
while CP>eps && k<nmax
    k=k+1;
    disp(['>>' num2str(k) 'ª' 'iteração'])
    disp(' ')
    aux=U*x(:,k)+b;
    disp(['Ux' num2str(k) '+b'])
    disp(aux)
    x(:,k+1)=DL\aux;
    disp(['x' num2str(k+1) '='])
    disp(x(:,k+1))
    disp('>>Critério de paragem')
    disp(' ')
    CP=norm(x(:,k+1)-x(:,k))/norm(x(:,k+1));
    teste=CP<eps;
    if teste==1
        disp([num2str(CP) '<= eps ' ' Verdadeiro'])
    else
        disp([num2str(CP) '<= eps ' ' Falso'])
    end
    disp(' ')
end
x=x(:,k+1);
disp(['>>Foram feitas ' num2str(k) ' iterações'])
disp(' ')
disp(['>>solução: x <- x(' num2str(k+1) ')='])
disp(x)
