%M�todo da Bissec��o aplicado a f(x) 
%para x em [a,b], obtendo-se a raiz c 
%de f com erro absoluto inferior a tol
%ou com um m�ximo de itera��es maxit

function [c,yc,erromax]=bissec(f,a,b,tol,maxit)
%entrada: 'f' ("function" f como uma "string"), 
%         a, b, tol, maxit 
%sa�da: c, yc(=f(c)), erromax (majorante do erro)

a(1)=a;
b(1)=b;
ya(1)=feval(f,a(1));
yb(1)=feval(f,b(1));

if ya(1)*yb(1)>0.0
   error('A fun��o tem o mesmo sinal nos pontos extremos.')
end

for k=1:maxit
   
   c(k)=(a(k)+b(k))/2;
   yc(k)=feval(f,c(k));
   
   if ((c(k)-a(k))<tol)
      disp('O m�todo da Bissec��o converge com |erro| < toler�ncia.') 
      break;
   end
   
   if (yc(k)==0.0)
      disp('Encontrado o valor exacto da raiz.');
      break;
   elseif ((yc(k)*ya(k))< 0)
      a(k+1)=a(k);
      ya(k+1)=ya(k);
      b(k+1)=c(k);
      yb(k+1)=yc(k);
   else
      a(k+1)=c(k);
      ya(k+1)=yc(k);
      b(k+1)=b(k);
      yb(k+1)=yb(k);
   end;
   
end

if (k==maxit) & ~((c(k)-a(k))<tol)
   disp('A raiz n�o foi encontrada com a toler�ncia desejada.')
end

erromax=(b-a)/2;
n=length(c);
k=1:n;
out = [k' a(1:n)' b(1:n)' c' yc' erromax(1:n)'];
disp('   itera��o     a         b         c        y(c)    erro m�ximo')
disp(out)
c(n)    


%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------
