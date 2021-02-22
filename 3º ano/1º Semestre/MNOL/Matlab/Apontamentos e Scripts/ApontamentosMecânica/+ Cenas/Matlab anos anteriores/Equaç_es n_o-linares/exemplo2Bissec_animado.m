% Simulação do método da bissecção (com animação) do exemplo 2
% Aproxima o único zero da função f(x)=x^3- 2*exp(-x) no intervalo [0.5, 1]

format long
a=0.5
b=1
f2=inline('x.^3-2*exp(-x)');
r=fzero(f2,[a,b]);

figure(1);
x=linspace(a,b);
y=f2(x);
clf;		
hold on;	
whitebg('w');
% desenha os eixos de coordenadas
axis([a b min(y) max(y)])  % define os eixos de coordenadas
title('Método da bisecção para determinar zero de f(x)=x^3-2exp(-x), I=[0.5,1]');
xlabel('x');						
ylabel('y');

plot(x,y,'m', r,0, 'or');
plot([a b],[0 0],'b',[0 0],[min(y), max(y)],'-b'); 
% determinando x1
pause;
x1=(a + b)/2;
plot(x1, 0, 'ob');
text(x1,0.05,'x1=0.75',... 
     'HorizontalAlignment','right',...
     'FontSize',10);
pause;
plot(x1,f2(x1),'*r');
text(x1,f2(x1),'f(x1)<0',... 
     'HorizontalAlignment','right',...
     'FontSize',10);
pause;
plot([x1,x1],[min(y), max(y)], '-r');

pause;
x2=(x1 + b)/2;
plot(x2, 0, '*m');
text(x2,0.05,'x2=0.875',... 
     'HorizontalAlignment','right',...
     'FontSize',10);
pause; 
plot(x2,f2(x2),'*r');
text(x2,f2(x2),'f(x2)<0',... 
     'HorizontalAlignment','right',...
     'FontSize',10);
pause;
plot([x2,x2],[min(y), max(y)], '-r');
pause;
x3=(x2 + b)/2;
plot(x3, 0, 'dg');
text(x3, -0.05,'x3=0.9375',... 
     'HorizontalAlignment','left',...
     'FontSize',10);
pause;
plot(x3,f2(x3),'*r');
text(x3,f2(x3),'f(x3)>0',... 
     'HorizontalAlignment','left',...
     'FontSize',10);
pause;
plot([x3,x3],[min(y), max(y)], '-r');
pause;
x4=(x2 + x3)/2;
plot(x4, 0, 'sb');
text(x4,0.05,'x4',... 
     'HorizontalAlignment','right',...
     'FontSize',10);
pause;
plot(x4,f2(x4),'*r');
plot([x4,x4],[min(y), max(y)], '-r');


%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2010 
%--------------------------------------------------------------------------