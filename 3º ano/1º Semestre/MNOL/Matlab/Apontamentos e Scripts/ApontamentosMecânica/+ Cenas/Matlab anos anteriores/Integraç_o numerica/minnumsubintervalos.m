function [n, M] = minnumsubintervalos(fun, a, b, tol, regra)
% --------------------------------------------------------
% Esta função determina o menor número de subintervalos
% que aproxima a integral da função dada usando a regra indicada 
% por forma a que o erro de truncatura nao exceda, em valor absoluto
% uma tolerância dada
% Entrada:
%    fun - a função integranda como string (ex: inline('exp(x)sin(x)')
%    [a, b] - o intervalo dado
%     tol   - a tolerância indicada por forma a que |e(It)|<= tol
%    regra - indica a regra de integração:
%      tc - trapézio composto
%      sc - Simpson composto
% Saida:
%   n  - o número de subintervalos
%   M -  o valor máximo da derivada (f'' para trapezio, f4 para Simpson) 
%------------------------------------------------------------------
if (lower(regra)=='tc')
   M = maxderivada(fun, 2, a, b);
   n = ceil(sqrt(M*(b-a)^3/(12*tol))); % rounds the result to the nearest integer
elseif (lower(regra)=='sc')
   M = maxderivada(fun, 4, a, b);
   n=ceil(nthroot(M*(b-a)^5/(180*tol),4)); %  ntroot(X, n) returns the real nth root of the elements of X.
  % Mas n tem que ser par para usar a regra de Simpson
   if mod(n,2)~=0
      n=n+1;       
   end
end


%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------