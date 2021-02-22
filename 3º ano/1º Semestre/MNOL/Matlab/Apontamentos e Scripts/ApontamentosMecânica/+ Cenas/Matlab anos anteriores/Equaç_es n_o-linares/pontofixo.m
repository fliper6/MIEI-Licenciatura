%M�todo de ponto fixo aplicado ao c�lculo 
%de uma raiz xr de f(x)=0 (ponto fixo de x=g(x)) tal que 
%|f(xr)|<tol para uma dada aprox. inicial x0

function [xr,yr]=pontofixo(f, g, x0,tol,maxit)
%entrada: 
%         'f' (fun��o como string)
%         'g' (fun��o iteradora como string),         
%         x0, tol, maxit (m�ximo de itera��es)
%sa�da: xr (vector das sucessivas aproxima��es),
%       yr (=|f(xr)|)

xr(1)=x0;
yr(1)=abs(feval(f,xr(1)));
iter=maxit+1;

for k=2:iter
   
   xr(k)=feval(g,xr(k-1));
   yr(k)=abs(feval(f,xr(k)));
   
   if (yr(k)<tol)
      disp('A iteradora de ponto fixo converge com |f(xr)| < toler�ncia.')
      break;
   end
   
end

if ((k==iter) & (yr(k)>=tol))
   disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
   disp('O ponto fixo n�o foi encontrado com a toler�ncia desejada.')
   disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
end

n=length(xr);
k=0:n-1;
out=[k' xr' yr'];
disp('  ------------------------------')
disp('   itera��o     xk      |f(xk)| ')
disp('  ------------------------------')
disp(out)


%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------
