
function It=trapezios(f,a,b,N)

%=====================================================
%Integra��o Num�rica
%Regra dos Trap�zios Composta
%It=(h/2)[f(a)+2f(x1)+2f(x2)+...+2f(xN-1)+f(b)]
%-----------------------------------------------------
%
%Entradas   - f fun��o integranda entra como uma
%                      string 'f'
%           - a � o limite inferior de integra��o
%           - b � o limite superior de integra��o
%           - N � o n�mero de subintervalos
%Sa�da      - It � o valor aproximado do integral 
%                calculado com a regra dos Trap�zios 
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
