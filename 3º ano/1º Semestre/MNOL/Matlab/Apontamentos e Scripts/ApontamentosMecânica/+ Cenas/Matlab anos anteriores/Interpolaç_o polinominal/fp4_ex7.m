% -----------------------------------------------------------------
%   FP4 - Exerc. 7
% Aproxime a raiz da equa��o exp(-x)-x = 0, utilizando convenientemente
% interpola��o inversa com os seguintes valores, 
%  tabelados aproximadamente:
%              x   | 0.4       0.5        0.6
%          exp(-x) | 0.670320  0.606531   0.548812
%--------------------------------------------------------------------

% 1�. Determinar os valores da f(x)=exp(-x)-x  nos pontos dados

format long;
clc; clear all;

disp('N�s de interpola��o: ');
X = [0.4, 0.5, 0.6]

disp('Valores nodais para y= exp(-x): ');
Y1 = [0.670320,  0.606531,   0.548812]

disp('Valores nodais para f(x) = exp(-x)-x : ');

Y = Y1- X

% 2�. Determinar um valor aproximado da raiz de f(x)=0 usando interpola��o inversa 
disp('-----------------------------------------------------------');
disp('Seja g(y) a fun��o inversa de f(x)=exp(-x)-x e ');
disp('r a unica raiz de f(x)=0 em [0.4, 0.6]');
disp('Ent�o como y=f(x) <-> x=g(y) logo f(r)=0 <-> r=g(0).');
disp('Podemos aproximar a raiz r de f(x)=0,');
disp('aproximando g(y) pelo polin�mio interpolador de Newton p2(y)');
disp('(basta trocar de posi��o os valores de X e Y na fun��o newtondifdiv)');
disp('e logo obter a aproxima��o da raiz xc=p2(0)');
disp('-----------------------------------------------------------');
disp('Prima uma tecla para determinar as diferen�as divididas do polin�mio');
disp('interpolador de Newton p2(y) que aproxima a inversa de f(x)=exp(-x)-x');
disp('e determina a aproxima��o xc=p2(0) da raiz r');
disp('                                     ');
pause;

yc = 0;
xc = newtondifdiv(yc, Y, X)
disp(' ');
disp(['A aproxima��o da raiz xc usando interpola��o inversa.:         xc=p2(0)= ', num2str(xc, 14)]);

% 3�. Determinar o erro absoluto de xc comparando com o valor para a raiz retornado pela
%     fun��o fzero do Matlab

r= fzero('exp(-x)-x', [0.4, 0.6]);

disp(['O valor da raiz r de f (usando fzero)................:           r=f(0)= ', num2str(r,14)]);
disp(['O erro absoluto......................................: |e(xc)|=|r - xc|= ', num2str(abs(xc - r),14)]);
disp('                                     ');
disp(['O valor da fun�ao f na aproxima��o xc..............:  f(xc) = ', num2str(exp(-xc)-xc, 14)]);
disp(['O valor da fun�ao f na raiz r......................:   f(r) = ', num2str(exp(-r)-r, 14)]);
disp('                                     ');

% 4�. Construir o gr�fico da inversa g(y) da fun��o f(x)=exp(-x)-x e do polin�mio
%     interpolador de Newton 
disp('Prima uma tecla para visualizar o gr�fico da fun��o g(y), inversa de f(x)=exp(-x)-x,'); 
disp('e do polin�mio interpolador de Newton p2(y) que aproxima g(y)');
pause;

Y1 = -0.10:0.005:0.3;
X1 = newtondifdiv(Y1,Y,X);     % valores do polinomio de Newton 
a = min(Y1);
b = max(Y1);
c = min(X1);
d = max(X1);

X2 = c: 0.005: d;    % posso calcular os valores de g(x) trocando os valores 
Y2 = exp(-X2)-X2;    % da fun��o original

figure(1);clf;
hold on;
whitebg('w');
axis([a b c d]);
plot(Y2,X2,'-b', Y1,X1,'-m',  0, r, 'db');
legend('g(y)= inv (exp(-x)-x)', 'p2(y) - polin�mio de Newton', ['xc = p2(0)= ', num2str(xc, 8)]);
plot(Y, X, 'or');  % desenho os pontos de soporte
plot([a 0],[xc xc],'--b',[0 0],[c xc],'--b' ); 
xlabel('y');
ylabel('x = g(y)');
title('Aproxima��o de g(y) pelo polin�mio interpolador de Newton');
grid;
hold off;

% ----------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------

