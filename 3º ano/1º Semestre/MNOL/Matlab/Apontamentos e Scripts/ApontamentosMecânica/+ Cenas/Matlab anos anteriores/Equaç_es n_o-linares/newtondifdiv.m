%Calcula o(s) valor(es) do Polin�mio interpolador 
%de Newton nas diferen�as divididas, Pn, num ou mais pontos
%  

function p = newtondifdiv(t,x,y)

%Entrada - t � um vector que indica a(s) abcissa(s) onde
%          queremos calcular o(s) valor(es) de Pn(x)
%        - x � um vector que cont�m os n�s
%        - y � um vector que cont�m os valores nodais
%Sa�da   - p � um vector que cont�m o(s) valor(es) de Pn(x)
%          calculado(s) na(s) abcissa(s) de t

a = difdivcoef(x,y);
n = length(x);
for i = 1 : length(t)
   d(1) = 1;
   c(1) = a(1);
   for j = 2 : n
      d(j) = (t(i) - x(j-1)).*d(j-1);
      c(j) = a(j).*d(j);
   end
   p(i) = sum(c);
end

%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------


