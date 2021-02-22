%Método de ponto fixo aplicado ao cálculo 
%de uma raiz xr de f(x)=0 (ponto fixo de x=g(x)) tal que 
%|f(xr)|<tol para uma dada aprox. inicial x0

function [xr,yr]=pontofixo(f, g, x0,tol,maxit)
%entrada: 
%         'f' (função como string)
%         'g' (função iteradora como string),         
%         x0, tol, maxit (máximo de iterações)
%saída: xr (vector das sucessivas aproximações),
%       yr (=|f(xr)|)

xr(1)=x0;
yr(1)=abs(feval(f,xr(1)));
iter=maxit+1;

for k=2:iter
   
   xr(k)=feval(g,xr(k-1));
   yr(k)=abs(feval(f,xr(k)));
   
   if (yr(k)<tol)
      disp('A iteradora de ponto fixo converge com |f(xr)| < tolerância.')
      break;
   end
   
end

if ((k==iter) & (yr(k)>=tol))
   disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
   disp('O ponto fixo não foi encontrado com a tolerância desejada.')
   disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
end

n=length(xr);
k=0:n-1;
out=[k' xr' yr'];
disp('  ------------------------------')
disp('   iteração     xk      |f(xk)| ')
disp('  ------------------------------')
disp(out)


%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------
