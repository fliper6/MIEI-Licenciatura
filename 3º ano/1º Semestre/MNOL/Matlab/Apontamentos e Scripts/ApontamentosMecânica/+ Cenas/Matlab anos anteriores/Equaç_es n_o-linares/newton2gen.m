
function [X,iter,erroX,erroF] = newton2gen(FXJF,Xa,delta,epsilon,maxit)

%---------------------------------------------------------------------------
% Newton Generalizado - método iterativo para sistemas não lineares F(X)=0 
%                     F(X)=[f1(x1,...,xn) f2(x1,...,xn) ... fn(x1,...,xn)]'
%
% Entradas: FXJF vector das equações do sistema F e matriz jacobiana JF
%                (function [F,JF]=FXJF(X) em FXJF.m)
%           Xa - aproximação inicial de X=[x1 x2 ... xn]'
%           delta - tolerância para ||X^(k)-X^(k-1)||
%           epsilon - tolerância para ||F(X)||
%           (é usada a norma máxima - inf)
%           maxit - máximo de iterações
%
% Saídas: X=[x1 x2 ... xn]' aproximação da solução
%         iter - número máximo de iterações
%         erroX - ||X^(k)-X^(k-1)||_inf
%         erroF - ||F(X^(k))||_inf
%---------------------------------------------------------------------------

%F(Xa) e JF(Xa)
[F,JF]=feval(FXJF,Xa);

for iter=1:maxit
   
   %resolve JF(Xa)*Ha=-F(Xa)
   Ha=-JF\F;
 
   %nova aproximação
   X=Xa+Ha;
   [F,JF]=feval(FXJF,X);

   %critério de paragem 
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
