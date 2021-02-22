
function [X,iter,erroX,erroF] = newton2gen(FXJF,Xa,delta,epsilon,maxit)

%---------------------------------------------------------------------------
% Newton Generalizado - m�todo iterativo para sistemas n�o lineares F(X)=0 
%                     F(X)=[f1(x1,...,xn) f2(x1,...,xn) ... fn(x1,...,xn)]'
%
% Entradas: FXJF vector das equa��es do sistema F e matriz jacobiana JF
%                (function [F,JF]=FXJF(X) em FXJF.m)
%           Xa - aproxima��o inicial de X=[x1 x2 ... xn]'
%           delta - toler�ncia para ||X^(k)-X^(k-1)||
%           epsilon - toler�ncia para ||F(X)||
%           (� usada a norma m�xima - inf)
%           maxit - m�ximo de itera��es
%
% Sa�das: X=[x1 x2 ... xn]' aproxima��o da solu��o
%         iter - n�mero m�ximo de itera��es
%         erroX - ||X^(k)-X^(k-1)||_inf
%         erroF - ||F(X^(k))||_inf
%---------------------------------------------------------------------------

%F(Xa) e JF(Xa)
[F,JF]=feval(FXJF,Xa);

for iter=1:maxit
   
   %resolve JF(Xa)*Ha=-F(Xa)
   Ha=-JF\F;
 
   %nova aproxima��o
   X=Xa+Ha;
   [F,JF]=feval(FXJF,X);

   %crit�rio de paragem 
   erroX=norm(X-Xa,inf);
   erroF=norm(F,inf);  
   if (erroX < delta) | (erroF < epsilon)
      break; 
   end
   
   Xa=X;
   
end

%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------
