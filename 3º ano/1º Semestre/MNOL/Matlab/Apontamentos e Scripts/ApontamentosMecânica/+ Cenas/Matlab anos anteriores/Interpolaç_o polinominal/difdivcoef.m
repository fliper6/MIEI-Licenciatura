% Calcula as diferen�as divididas que figuram no 
% polin�mio interpolador de Newton nas diferen�as
% divididas, Pn(x):
% a=[a0 a1 ... an], com Pn(x)=a0+a1(x-x0)+a2(x-x0)(x-x1)+...
%                      +an(x-x0)(x-x1)...(x-xn-1)
%
% d � uma matriz auxiliar que sob a forma diagonal superior,
% nos fornece a tabela de diferen�as divididas (diferen�as
% de primeira ordem em diante)

function a = difdivcoef(x,y)

%Entrada - x � um vector que cont�m os n�s
%        - y � um vector que cont�m os valores nodais
%Sa�da   - a � um vector que cont�m as diferen�as divididas 
%          que figuram no polin�mio interpolador de Newton

n = length(x);
a(1) = y(1);

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

for j = 2 : n
   a(j) = d(1,j-1);
end


%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------


