function [x,y]= secante(fun, x0, x1,tolx,toly, maxit)
% ------------------------------------------------------------------
% M�todo da secante para o c�lculo de uma raiz x de f(x)=0, tal que 
%( |x(k)-x(k-1)| < tolx ) ou ( |f(x(k))| < toly )  
% Par�metros de entrada:
% fun - o nome da fun��o do Matlab como string que dado um x,
%       devolve o valor da fun��o, y=f(x)
% x0, x1  - iteradas iniciais
% tolx, toly - toler�ncias para o crit�rio de paragem
%  ( |x(k)-x(k-1)| < tolx ) ou ( |f(x(k))| < toly )  
% maxit - numero m�ximo de itera��es
% Par�metros de sa�da:
%   x - vector das aproxima��es da raiz de f,
%   y - vector dos valores de f(x)
% -------------------------------------------------------------
x(1) = x0;
y(1) = feval(fun,x0);
x(2) = x1;
y(2) = feval(fun,x1);

iter=maxit+2;

for k=3:iter
   x(k) = (y(k-1) * x(k-2) - y(k-2)* x(k-1))/ (y(k-1)-y(k-2));
   y(k) = feval(fun,x(k));

   difx(k)=abs(x(k)-x(k-1));
   
   if ((difx(k)<tolx) | (abs(y(k))<toly))
      disp('O m�todo da secante converge !')
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


