% -----------------------------------------------------------------
%   FP4 - Exerc. 1
% Dada a função 4/(4*x+1) e o seguinte suporte de interpolação
%             x | 0  0.25  0.5  0.75  1
%             y | 4  2     4/3  1   0.8
% (b) Obtenha o polinómio interpolador de Newton de grau menor ou
%     igual a 4 que interpola f no intervalo [0, 1] .
%     Calcule, a partir desse polinómio, aproximações para 
%            f(0.125), f(0.3), f(0.65) e f(0.9). 
%     Indique majorantes dos erros absolutos de interpolação 
%     cometidos nas aproximações anteriores.
% b) Visualize num único gráfico a função e o polinómio interpolador.
% ------------------------------------------------------------------

% 1º. Determinar os coeficientes do polinómio interpolador de Newton

clc; clear all;
format short;
f=inline('4./4*x+1 ')

disp('Nós de interpolação: ');
X=[0, 0.25, 0.5, 0.75, 1]

disp('Valores nodais: ');
Y=[4, 2, 4/3, 1, 0.8]

disp('Coeficientes do Polinómio de Newton: ');
c = difdivcoef(X,Y) % calcula os coeficientes 

% 2º. Calcular aproximações de f(x) nos pontos dados
disp('Prima uma tecla para calcular aproximações para: ');
xp = [0.125, 0.3, 0.65, 0.9 ]
pause;

format long;

disp('Valores da função f(x)= 4/4*x+1 em xp:');
yf = 4./(4*xp+1)    % valores da função em xp
yf = f(xp)          % valores da função em xp

disp('Aproximações pelo polinómio de Newton: ');
yp = newtondifdiv(xp, X,Y) % valores do polinómio em xp

disp('Erro absoluto das aproximações:');
e = abs(yf - yp) 

% 3º. Indicar majorantes dos erros absolutos de interpolação 
disp('                                                    ');
disp('Prima uma tecla para indicar os majorantes dos erros absolutos de interpolação:');
pause;
for i=1:length(xp) 
   IM = interpmajorante('4/(4*x+1)', [0, 0.25 0.5 0.75 1], xp(i));
end   
disp('                                                    ');

% b) Construir o gráfico da função f(x)=4/4*x+1 
%    e do polinómio interpolador de Lagrange
disp('Prima uma tecla para visualizar o gráfico da função f(x)=4/4*x+1');
disp('e do seu polinómio interpolador de Newton');
disp('                             ');
pause;

% avalia o polinómio de Newton para 0<=x<=1 com incremento 0.005
X1 = 0:0.005:1;
Y1 = f(X1);                        % valores da função f(x)=4/4*x+1 
Y2 = newtondifdiv(X1, X,Y);        % valores do polinómio 

a = min(X1);
b = max(X1);
c = min(Y1);
d = max(Y1);
figure(1);clf;
hold on;
whitebg('w');
axis([a b c d]);
plot(X1,Y1,'-b', X1,Y2,'-m');
legend('f(x)= 4/4*x+1', 'p4(x) - polinómio de Newton');
plot(X,Y,'or');   % desenhar o suporte
xlabel('x');
ylabel('y');
title('Aproximação de f(x) pelo polinómio interpolador de Newton');
grid;
hold off;





%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------
