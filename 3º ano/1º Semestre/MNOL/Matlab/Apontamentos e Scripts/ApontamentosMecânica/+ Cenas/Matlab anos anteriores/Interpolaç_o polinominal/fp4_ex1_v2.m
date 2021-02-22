% -----------------------------------------------------------------
%   FP4 - Exerc. 1
% Dada a fun��o 4/(4*x+1) e o seguinte suporte de interpola��o
%             x | 0  0.25  0.5  0.75  1
%             y | 4  2     4/3  1   0.8
% (b) Obtenha o polin�mio interpolador de Newton de grau menor ou
%     igual a 4 que interpola f no intervalo [0, 1] .
%     Calcule, a partir desse polin�mio, aproxima��es para 
%            f(0.125), f(0.3), f(0.65) e f(0.9). 
%     Indique majorantes dos erros absolutos de interpola��o 
%     cometidos nas aproxima��es anteriores.
% b) Visualize num �nico gr�fico a fun��o e o polin�mio interpolador.
% ------------------------------------------------------------------

% 1�. Determinar os coeficientes do polin�mio interpolador de Newton

clc; clear all;
format short;
f=inline('4./4*x+1 ')

disp('N�s de interpola��o: ');
X=[0, 0.25, 0.5, 0.75, 1]

disp('Valores nodais: ');
Y=[4, 2, 4/3, 1, 0.8]

disp('Coeficientes do Polin�mio de Newton: ');
c = difdivcoef(X,Y) % calcula os coeficientes 

% 2�. Calcular aproxima��es de f(x) nos pontos dados
disp('Prima uma tecla para calcular aproxima��es para: ');
xp = [0.125, 0.3, 0.65, 0.9 ]
pause;

format long;

disp('Valores da fun��o f(x)= 4/4*x+1 em xp:');
yf = 4./(4*xp+1)    % valores da fun��o em xp
yf = f(xp)          % valores da fun��o em xp

disp('Aproxima��es pelo polin�mio de Newton: ');
yp = newtondifdiv(xp, X,Y) % valores do polin�mio em xp

disp('Erro absoluto das aproxima��es:');
e = abs(yf - yp) 

% 3�. Indicar majorantes dos erros absolutos de interpola��o 
disp('                                                    ');
disp('Prima uma tecla para indicar os majorantes dos erros absolutos de interpola��o:');
pause;
for i=1:length(xp) 
   IM = interpmajorante('4/(4*x+1)', [0, 0.25 0.5 0.75 1], xp(i));
end   
disp('                                                    ');

% b) Construir o gr�fico da fun��o f(x)=4/4*x+1 
%    e do polin�mio interpolador de Lagrange
disp('Prima uma tecla para visualizar o gr�fico da fun��o f(x)=4/4*x+1');
disp('e do seu polin�mio interpolador de Newton');
disp('                             ');
pause;

% avalia o polin�mio de Newton para 0<=x<=1 com incremento 0.005
X1 = 0:0.005:1;
Y1 = f(X1);                        % valores da fun��o f(x)=4/4*x+1 
Y2 = newtondifdiv(X1, X,Y);        % valores do polin�mio 

a = min(X1);
b = max(X1);
c = min(Y1);
d = max(Y1);
figure(1);clf;
hold on;
whitebg('w');
axis([a b c d]);
plot(X1,Y1,'-b', X1,Y2,'-m');
legend('f(x)= 4/4*x+1', 'p4(x) - polin�mio de Newton');
plot(X,Y,'or');   % desenhar o suporte
xlabel('x');
ylabel('y');
title('Aproxima��o de f(x) pelo polin�mio interpolador de Newton');
grid;
hold off;





%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------
