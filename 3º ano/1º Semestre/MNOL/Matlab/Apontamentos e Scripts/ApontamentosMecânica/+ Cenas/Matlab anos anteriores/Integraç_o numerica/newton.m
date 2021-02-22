function [C,D] = newton(X,Y)
%---------------------------------------------------------------------------
%Esta fun��o constr�i o polin�mio interpolador de Newton, dado um conjunto de pontos
%Executar:
%   [C] = Newton(X,Y)
%   [C,D] = lNewton(X,Y)
%Par�metros de entrada:
%   X  - vector das abscissas
%   Y  - vector das ordenadas
%Par�metros de sa�da:
%   C  - vector com os coeficientes do polin�mio interpolador de Newton
%   D  - a tabela das diferen�as divididas
%---------------------------------------------------------------------------
n = length(X);				% determina o n�mero de pontos
D = zeros(n,n);			% inicializa a tabela com as diferen�as divididas
D(:,1) = Y';				% atribui � coluna 1 o vector das ordenadas (inversa do vector Y)
for j=2:n,					% para cada coluna da tabela das diferen�as divididas
  for k=j:n,				% interessa s� calcular os elementos diferente de zeros (debaixo da diagonal)
      D(k,j) = (D(k,j-1)-D(k-1,j-1))/(X(k)-X(k-j+1));  % a formula para calcular as diferen�as
  end
end

C = D(n,n); 			    
 for i=(n-1):-1:1,
   C = conv(C,poly(X(i)));
   m = length(C);
   C(m) = C(m) + D(i,i);   
end;




  
   
   
   
   