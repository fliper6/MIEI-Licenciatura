
function It=trapezios(f,a,b,N)

%=====================================================
%Integração Numérica
%Regra dos Trapézios Composta
%It=(h/2)[f(a)+2f(x1)+2f(x2)+...+2f(xN-1)+f(b)]
%-----------------------------------------------------
%
%Entradas   - f função integranda entra como uma
%                      string 'f'
%           - a é o limite inferior de integração
%           - b é o limite superior de integração
%           - N é o número de subintervalos
%Saída      - It é o valor aproximado do integral 
%                calculado com a regra dos Trapézios 
%                composta
%=====================================================

h=(b-a)/N;
It=0;
for k=1:(N-1)
   x=a+h*k;
   It=It+feval(f,x);
end
It=h*(feval(f,a)+feval(f,b))/2+h*It;


%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2005 
%-----------------------------------------------------------------------------
