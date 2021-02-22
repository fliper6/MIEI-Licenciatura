
function Is=simpson(f,a,b,N)

%=================================================
%Integra��o Num�rica
%Regra de Simpson Composta
%Is=(h/3)[f(a)+4f(x1)+2f(x2)+...+4f(xN-1)+f(b)]
%-------------------------------------------------
%
%Entradas   - f fun��o integranda entra como uma
%                      string 'f'
%           - a � o limite inferior de integra��o
%           - b � o limite superior de integra��o
%           - N (par) � o n�mero de subintervalos
%Sa�da      - Is � o valor aproximado do integral 
%                calculado com a regra de Simpson 
%                composta
%=================================================

h=(b-a)/N;
Is=0;
for k=1:2:(N-1)
   x=a+h*k;
   Is=Is+4*feval(f,x);
end
for k=2:2:(N-2)
   x=a+h*k;
   Is=Is+2*feval(f,x);
end
Is=h*(Is+(feval(f,a)+feval(f,b)))/3;


%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2005 
%-----------------------------------------------------------------------------
