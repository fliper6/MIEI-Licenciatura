% Exemplo 2
% Estudo comparativo com métodos da Bissecção, Secante e Newton Raphson
% Considere a função f(x) = x3 - 2 e-x
%  Simulação do método de Newton Raphson (com animação)

a=0.5
b=1.1
x=linspace(a,b);
y=f2(x);
r=fzero('f2',0.9)
x0=0.5
figure(1);	
clf;		
hold on;	
whitebg('w');
% desenha os eixos de coordenadas
axis([a b min(y) max(y)])  % define os eixos de coordenadas
title('Método de Newton-Raphson para determinar zero de f(x)=x^3-2exp(-x) em [0.5,1]');
xlabel('x');						
ylabel('y');
plot(x,y,'m'); 
plot(r,0, 'or');
legend('f(x)=x^3-2exp(-x)', 'zero=0.92547892','location', 'NorthWest')
plot([a b],[0 0],'b',[0 0],[min(y), max(y)],'-b');  
% determinando x1
[y0,dy0]=f2(x0);
x1=x0-(y0/dy0);


% grafico da tangente 

pause
plot(x0,y0,'ob',[x0, x1], [y0,0], 'b');
pause
plot(x1, 0, 'db')
text(x1,0.05,'x1',... 
     'HorizontalAlignment','right',...
     'FontSize',10)
plot([x1,x1], [0, f2(x1)], '-.k')
% determinando x2
[y1,dy1]=f2(x1)
x2=x1-(y1/dy1)
% grafico da tangente 
pause
plot(x1,y1,'ob', [x1, x2], [y1,0], 'r');
pause
plot(x2, 0, 'dg')
plot([x2,x2], [0, f2(x2)], '-.k')
text(x2,0.05,'x2',... 
     'HorizontalAlignment','right',...
     'FontSize',10)
 hold off;
 
%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------

