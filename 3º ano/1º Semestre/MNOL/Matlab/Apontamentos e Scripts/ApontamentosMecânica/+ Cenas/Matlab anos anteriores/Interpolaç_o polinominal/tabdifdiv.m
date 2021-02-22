% Calcula as diferenças divididas que figuram no 
% polinómio interpolador de Newton nas diferenças
% divididas, Pn(x):

function d = tabdifdiv(x,y)

%Entrada - x é um vector que contém os nós
%        - y é um vector que contém os valores nodais
%Saída   - d- a tabela das diferenças divididas

n = length(x);
% cálculo das diferenças divididas de primeira ordem

for k = 1 : n-1
   d(k,1) = (y(k+1) - y(k))/(x(k+1) - x(k));
end

% cálculo das diferenças divididas de ordem j

for j = 2 : n-1
   for k = 1 : n-j
      d(k,j) = (d(k+1,j-1) - d(k,j-1))/(x(k+j) - x(k));
   end
end

disp('Tabela das diferenças divididas')
disp(d)




%-----------------------------------------------------------------------------
% adaptado de AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------


