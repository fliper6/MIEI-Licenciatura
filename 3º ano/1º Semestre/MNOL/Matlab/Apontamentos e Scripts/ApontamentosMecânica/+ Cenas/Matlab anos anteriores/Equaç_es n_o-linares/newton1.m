%M�todo de Newton-Raphson 
%para o c�lculo de uma raiz x de f(x)=0, tal que 
%( |x(k)-x(k-1)| < tolx ) ou ( |f(x(k))| < toly )  
%para uma dada aproxima��o inicial x0

function [x,y]=newton1(ydy,x0,tolx,toly,maxit)
%entrada: 'f' (fun��o f como string),
%         'df'(fun��o derivada de f como string),
%         x0, tolx, toly, maxit (m�ximo de itera��es)
%sa�da: x (vector das aproxima��es da raiz de f),
%       y (vector dos valores de f(x)) 

x(1)=x0;
[y(1),dy(1)]=feval(ydy,x(1));
iter=maxit+1;

for k=2:iter
   
   x(k)=x(k-1)-y(k-1)/dy(k-1);
   [y(k),dy(k)]=feval(ydy,x(k));
   difx(k)=abs(x(k)-x(k-1));
   
   if ((difx(k)<tolx) | (abs(y(k))<toly))
      disp('O m�todo de Newton-Raphson converge.')
      break;
   end
   
end

if ((difx(k)<tolx) & (abs(y(k))<toly))
   disp('A raiz foi encontrada com as duas toler�ncias desejadas.')
elseif (difx(k)<tolx)
   disp('A raiz foi encontrada com |x(k)-x(k-1)| < toler�ncia.')
elseif (abs(y(k))<toly)
   disp('A raiz foi encontrada com |f(xk)| < toler�ncia.')
else
   disp('*******************************************************')
   disp('A raiz n�o foi encontrada com as toler�ncias desejadas.')
   disp('*******************************************************')
end
   
ym=abs(y);
n=length(x);
k=0:n-1;
out=[k' x' difx' y' ym'];
disp('----------------------------------------------------')
disp('  itera��o     xk   |x(k)-x(k-1)|    yk     |f(xk)|')
disp('----------------------------------------------------')
disp(out)
disp('----------------------------------------------------')


%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------
