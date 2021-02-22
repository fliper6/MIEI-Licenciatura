function [C,D] = newton(X,Y)
%---------------------------------------------------------------------------
%Esta função constrói o polinómio interpolador de Newton, dado um conjunto de pontos
%Executar:
%   [C] = Newton(X,Y)
%   [C,D] = lNewton(X,Y)
%Parâmetros de entrada:
%   X  - vector das abscissas
%   Y  - vector das ordenadas
%Parâmetros de saída:
%   C  - vector com os coeficientes do polinómio interpolador de Newton
%   D  - a tabela das diferenças divididas
%---------------------------------------------------------------------------
n = length(X);				% determina o número de pontos
D = zeros(n,n);			% inicializa a tabela com as diferenças divididas
D(:,1) = Y';				% atribui à coluna 1 o vector das ordenadas (inversa do vector Y)
for j=2:n,					% para cada coluna da tabela das diferenças divididas
  for k=j:n,				% interessa só calcular os elementos diferente de zeros (debaixo da diagonal)
      D(k,j) = (D(k,j-1)-D(k-1,j-1))/(X(k)-X(k-j+1));  % a formula para calcular as diferenças
  end
end

C = D(n,n); 			    
 for i=(n-1):-1:1,
   C = conv(C,poly(X(i)));
   m = length(C);
   C(m) = C(m) + D(i,i);   
end;




  
   
   
   
   