clc
A = input ('Introduza a matriz A do problema\n');
b = input ('Introduza o vector b do problema\n');
D = diag(diag(A))     % Diagonal da Matriz esparsa A
L = tril(-A,-1)       % Triangular Inferior da Matriz A com sinais trocados
U = triu(-A,1)        % Triangular Superior da Matriz A com sinais trocados
DL= D-L% Diferen�a da diagonal com a triangular Inferior com os sinais trocados
reply = input('Pretenda calcular  a Cgs? S/N [S] :', 's'); % introdu��o dos dados de itera��o
if isempty(reply)
    reply = 'S';
    CGS = inv(DL)*U       % Matriz de itera��o de Gauss-seidel (Cgs)
end
reply2 = input('Pretenda utilizar o m�todo de Gaus-seidel? S/N [S] :', 's'); % introdu��o dos dados de itera��o
if isempty(reply2)
    reply = 'S';
    x1= input ('Introduza 0 vector inicial para a itera��o do problema\n');
    cp = input ('Introduza o valor do cr�terio de Paragaem\n');
    nmax = input ('Introduza o valor das itera��es m�ximas\n');
end
x(:,1)=x1;    % Algoritmo de gaus-seidel da aula
CP=inf;
k=0;
while CP>eps && k<nmax
    k=k+1;
    disp(['>>' num2str(k) '�' 'itera��o'])
    disp(' ')
    auxx=U*x(:,k)+b;
    disp(['Ux' num2str(k) '+b'])
    disp(auxx)
    x(:,k+1)=DL\auxx;
    disp(['x' num2str(k+1) '='])
    disp(x(:,k+1))
    disp('>>Crit�rio de paragem')
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
disp(['>>Foram feitas ' num2str(k) ' itera��es'])
disp(' ')
disp(['>>solu��o: x <- x(' num2str(k+1) ')='])
disp(x)
reply3 = input('Pretenda verificar as condi��es de Converg�ncia  S/N [S]:', 's'); % iAlgoritmo da aula sobre a analise de converg�ncia
if isempty(reply3)
    reply = 'S';
    n=size(A,1);
    for i=1:n
        if abs(A(i,i))>sum(abs(A(i,:)))-abs(A(i,i))
            aux(i)=1;
        else aux(i)=0;
        end
    end
    if all(aux)==1
        disp('A matriz A � estrita e diagonalmente dominante')
        disp('O m�todo de Gauss-Seidel converge')
        return
    else
        disp('A matriz A n�o � estrita e diagonalmente dominante')
    end
    teste=A==A';
    if all(all(teste))==1
        disp('A matriz A � sim�trica')
        teste1=1;
    else
        disp('A matriz A n�o � sim�trica')
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
            disp('A matriz A � definida positiva')
            teste2=1;
        else
            disp('A matriz A n�o � definida positiva')
            teste2=0;
        end
    end
    testefinal=[teste1 teste2];
    if all(testefinal)==1
        disp('O m�todo de Gauss-Seidel converge')
        return
    end
    if norm(CGS,1)<1
        disp('A norma um de GS � menor que 1')
        disp('O m�todo de Gauss-Seidel converge')
        return
    elseif norm(CGS,inf)<1
        disp('A norma infinita de GS � menor que 1')
        disp('O m�todo de Gauss-Seidel converge')
        return
    else
        disp('Nenhuma das norma � menor que 1 ,nada se pode concluir acerca da converg�ncia do m�todo de Gauss-Seidel')
    end
end
