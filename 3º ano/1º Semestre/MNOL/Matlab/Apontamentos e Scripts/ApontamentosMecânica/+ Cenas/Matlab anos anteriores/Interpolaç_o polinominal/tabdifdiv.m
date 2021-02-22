% Calcula as diferen�as divididas que figuram no 
% polin�mio interpolador de Newton nas diferen�as
% divididas, Pn(x):

function d = tabdifdiv(x,y)

%Entrada - x � um vector que cont�m os n�s
%        - y � um vector que cont�m os valores nodais
%Sa�da   - d- a tabela das diferen�as divididas

n = length(x);
% c�lculo das diferen�as divididas de primeira ordem

for k = 1 : n-1
   d(k,1) = (y(k+1) - y(k))/(x(k+1) - x(k));
end

% c�lculo das diferen�as divididas de ordem j

for j = 2 : n-1
   for k = 1 : n-j
      d(k,j) = (d(k+1,j-1) - d(k,j-1))/(x(k+j) - x(k));
   end
end

disp('Tabela das diferen�as divididas')
disp(d)




%-----------------------------------------------------------------------------
% adaptado de AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------


