%Método de Newton-Raphson 
%para o cálculo de uma raiz x de f(x)=0, tal que 
%( |x(k)-x(k-1)| < tolx ) ou ( |f(x(k))| < toly )  
%para uma dada aproximação inicial x0

function [x,y]=newton1(ydy,x0,tolx,toly,maxit)
%entrada: 'f' (função f como string),
%         'df'(função derivada de f como string),
%         x0, tolx, toly, maxit (máximo de iterações)
%saída: x (vector das aproximações da raiz de f),
%       y (vector dos valores de f(x)) 

x(1)=x0;
[y(1),dy(1)]=feval(ydy,x(1));
iter=maxit+1;

for k=2:iter
   
   x(k)=x(k-1)-y(k-1)/dy(k-1);
   [y(k),dy(k)]=feval(ydy,x(k));
   difx(k)=abs(x(k)-x(k-1));
   
   if ((difx(k)<tolx) | (abs(y(k))<toly))
      disp('O método de Newton-Raphson converge.')
      break;
   end
   
end

if ((difx(k)<tolx) & (abs(y(k))<toly))
   disp('A raiz foi encontrada com as duas tolerâncias desejadas.')
elseif (difx(k)<tolx)
   disp('A raiz foi encontrada com |x(k)-x(k-1)| < tolerância.')
elseif (abs(y(k))<toly)
   disp('A raiz foi encontrada com |f(xk)| < tolerância.')
else
   disp('*******************************************************')
   disp('A raiz não foi encontrada com as tolerâncias desejadas.')
   disp('*******************************************************')
end
   
ym=abs(y);
n=length(x);
k=0:n-1;
out=[k' x' difx' y' ym'];
disp('----------------------------------------------------')
disp('  iteração     xk   |x(k)-x(k-1)|    yk     |f(xk)|')
disp('----------------------------------------------------')
disp(out)
disp('----------------------------------------------------')


%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2003 
%-----------------------------------------------------------------------------
