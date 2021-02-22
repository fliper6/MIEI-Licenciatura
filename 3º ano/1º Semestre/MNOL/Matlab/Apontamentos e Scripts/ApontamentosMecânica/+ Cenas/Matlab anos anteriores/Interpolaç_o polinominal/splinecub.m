
function S = splinecub(X,Y,ct)
%---------------------------------------------------------------------------
% Spline Cúbico S (natural, completo ou outro)
%
% Entradas
%      X   vector das abcissas
%      Y   vector das ordenadas
%      ct  curva tipo do Spline Cúbico (natural, completo ou outro) 
%          especificada através das derivadas nos extremos x0 e xn:
%          ct=1 para as primeiras derivadas
%          ct=2 para as segundas derivadas
% Saídas
%      S   matriz dos coeficientes dos polinómios Sk do Spline Cúbico
%          de acordo com a notaçao dada nas aulas teoricas:
%          Sk(x) = dk(x-xk)^3 + ck(x-xk)^2 + bk(x-xk) + yk
%          ( n linhas (k=0,1,...,n-1) por 4 colunas (dk,ck,bk,yk) )         
%---------------------------------------------------------------------------

n = length(X)-1;
H = diff(X);                 
D = diff(Y)./H;
A = H(2:n-1);
B = 2*(H(1:n-1) + H(2:n));
C = H(2:n);
V = 6*diff(D);

if ct==1 
   
   clc,disp(' '),disp('Especificar primeiras derivadas:'),
   Mx0 = ['Enter S`(',num2str(X(1)),') = '];
   dx0 = input(Mx0);
   Mxn = ['Enter S`(',num2str(X(n+1)),') = '];
   dxn = input(Mxn);

   %Modifica matrizes e vectores coluna
   B(1) = B(1) - H(1)/2;
   V(1) = V(1) - 3*(D(1)-dx0);
   B(n-1) = B(n-1) - H(n)/2;
   V(n-1) = V(n-1) - 3*(dxn-D(n));
  
elseif ct==2
   
   clc,disp(' '),disp('Especificar segundas derivadas:'),
   Mx0 = ['Enter S``(',num2str(X(1)),') = '];
   ddx0 = input(Mx0); 
   Mxn = ['Enter S``(',num2str(X(n+1)),') = '];
   ddxn = input(Mxn);
   
   %Modifica matrizes e vectores coluna
   V(1) = V(1) - H(1)*ddx0;
   V(n-1) = V(n-1) - H(n)*ddxn;
   
else  
   disp('Erro no tipo de Spline escolhido!!!');
   return
end

%Resolve sistema tridiagonal
for k = 2:n-1                  
  temp = A(k-1)/B(k-1);
  B(k) = B(k) - temp*C(k-1);
  V(k) = V(k) - temp*V(k-1);
end

M(n-1+1) = V(n-1)/B(n-1);

for k = n-2:-1:1
  M(k+1) = (V(k)-C(k)*M(k+2))/B(k);
end

%Coeficientes finais (extremos)
if ct==1
   M(1) = 3*(D(1)-dx0)/H(1) - M(2)/2;
   M(n+1) = 3*(dxn-D(n))/H(n) - M(n)/2;
elseif ct==2 
   M(1) = ddx0;
   M(n+1) = ddxn;
end

%Calcula os coeficientes dos polinómios Sk 
for k = 0:n-1
   S(k+1,1) = (M(k+2)-M(k+1))/(6*H(k+1));
   S(k+1,2) = M(k+1)/2;
   S(k+1,3) = D(k+1) - H(k+1)*(2*M(k+1)+M(k+2))/6;
   S(k+1,4) = Y(k+1);
end

%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2005 
%-----------------------------------------------------------------------------

