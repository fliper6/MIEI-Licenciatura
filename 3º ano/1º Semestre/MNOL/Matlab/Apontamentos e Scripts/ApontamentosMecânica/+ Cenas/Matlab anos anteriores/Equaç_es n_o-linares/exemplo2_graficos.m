% Exemplo 2
% Estudo comparativo com m�todos da Bissec��o, Secante e Newton Raphson
% Considere a fun��o f(x) = x3 - 2 e-x. Verifique, graficamente
% que a fun��o tem um s� zero no intervalo [0.5, 1].
% Determine esse zero usando a fun��o fzero do Matlab

% 
a=0.5
b=1
x=linspace(a,b);
y =f2(x);
r=fzero('f2',0.9)


figure(1);	% visualiza a janela de gr�ficos que corresponde � figura 1
clf;		% limpa a figura 1	
hold on;	% todos os comandos gr�ficos s�o executados num mesmo gr�fico
whitebg('w');
% desenha os eixos de coordenadas
axis([a b min(y) max(y)])  % define os eixos de coordenadas
title('Gr�fico de f(x)=x^3-2exp(-x) em [0.5,1]');
xlabel('x');						
ylabel('y');
grid;
plot(r,0, 'or')
legend('zero=0.92547892', 'location', 'NorthWest')
plot(x,y,'m')
plot([a b],[0 0],'b',[0 0],[min(y), max(y)],'-b');  
grid on;

disp('Prima uma tecla para desenhar o grafico com duas fun��es');
pause;

figure(2);	
g= x.^3;
h= 2* exp(-x);
clf;	
hold on;
whitebg('w');
% desenha os eixos de coordenadas
axis([a b -0.05 max(h)])  % define os eixos de coordenadas
title('Gr�fico de g(x)=x^3 e h(x)= 2exp(-x) em [0.5,1]');
xlabel('x');						
ylabel('y');
grid;
plot(x,g,'m', x,h, 'b', r, 0, 'or')
legend('g(x)=x^3' ,'h(x)= 2exp(x)', 'location', 'NorthEast')
plot([r r], [r^3 0], '-.r', r, r^3, 'ob')
plot([a b],[0 0],'b',[0 0],[-0.05, max(h)],'-b');  
text(r,0.01, '\leftarrow  zero = 0.9254',... 
    'HorizontalAlignment','left',...
    'FontSize',11)
grid on;

disp('Prima uma tecla para desenhar o grafico da 1� derivada');
disp('f''(x)= 3x^2 + 2 * exp(-x)');
pause;
figure(3);	% visualiza a janela de gr�ficos que corresponde � figura 1
clf;		% limpa a figura 1	
hold on;	% todos os comandos gr�ficos s�o executados num mesmo gr�fico
a=0.3;
b=1.3;
x=linspace(a,b);
[dy, y]= f2(x);
whitebg('w');
% desenha os eixos de coordenadas
axis([a b min(dy) max(dy)])  % define os eixos de coordenadas
title('Gr�fico da 1� derivada, f''(x)= 3x^2+2exp(-x), da fun��o f(x)=x^3-2exp(-x) em [0.5,1]');
xlabel('x');						
ylabel('y');
grid;
plot(x,dy,'r');
plot([a b],[0 0],'b',[0 0],[min(dy), max(dy)],'-b'); 
% desenhar linhas para delimitar intervalo
plot([0.5 0.5],[min(dy),max(dy)],'b'); 
plot([1 1], [min(dy),max(dy)],'b'); 
disp('Prima uma tecla para mostrar o valor m�nimo da 1� derivada');
pause;
[dymin, ymin]= f2(0.5)
plot(0.5,dymin,'ob');
text(0.5,dymin,'\leftarrow min |f''(x)|=1.9630',... 
    'HorizontalAlignment','left',...
    'FontSize',11)

disp('Prima uma tecla para desenhar o grafico da 2� derivada');
disp('f''''(x)= 6x- 2 * exp(-x)');
pause;
figure(4);clf;		
hold on;	% todos os comandos gr�ficos s�o executados num mesmo gr�fico
a=0.3;
b=1.3;
x=linspace(a,b);
y=6*x-2*exp(-x);
whitebg('w');
% desenha os eixos de coordenadas
axis([a b min(y) max(y)])  % define os eixos de coordenadas
title('Gr�fico da 2� derivada, f''''(x)= 6x-2exp(-x), da fun��o f(x)=x^3-2exp(-x) em [0.5,1]');
xlabel('x');						
ylabel('y');
grid;
plot(x,y,'r');
plot([a b],[0 0],'b',[0 0],[min(y), max(y)],'-b'); 
% desenhar linhas para delimitar intervalo
plot([0.5 0.5],[min(y),max(y)],'b'); 
plot([1 1], [min(y),max(y)],'b'); 
ymax=6- 2*exp(-1);
disp('Prima uma tecla para mostrar o valor m�ximo da 2� derivada');
pause;
plot(1,ymax,'ob');
text(1,ymax,'\leftarrow max |f''''(x)|=5.2642',... 
    'HorizontalAlignment','left',...
    'FontSize',11)
disp('Prima uma tecla para mostrar o valor m�nimo da 1� derivada');
pause;

%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------

