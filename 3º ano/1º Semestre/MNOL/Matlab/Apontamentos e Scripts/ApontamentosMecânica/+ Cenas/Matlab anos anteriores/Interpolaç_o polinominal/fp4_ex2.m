%--------------------------------------------------------------------
%  FP4 - Exerc. 2
% A partir da seguinte tabela de valores aproximados da fun��o do erro 
% y = erf(x) (erf em MatLab) 
%        x | 0  0.5    1       1.5
%        y | 0  0.5205 0.8427 0.9661
% determine o polin�mio interpolador de Newton de grau 3, 
% calcule o valor p(0.9) e compare com o valor aproximado 
% de erf(0.9), 0.7969.
% ---------------------------------------------------------------

% 1�. Determinar as diferen�as divididas do polin�mio interpolador de Newton
%     e calcular a aproxima��o p(0.9)

format short;
clc; clear all;

disp('N�s de interpola��o: ');
X = [0, 0.5, 1, 1.5]

disp('Valores nodais: ');
Y = [0, 0.5205, 0.8427, 0.9661]

disp('Prima uma tecla para determinar as diferen�as divididas do polin�mio');
disp('interpolador de Newton p3(x) que aproxima a fun��o f(x)= erf(x) ');
disp('e calcular a aproxima��o p3(0.9)');
pause;

yp = newtondifdiv(0.9,X,Y);

% 2�. Calcular o erro absoluto da aproxima��o yp

format long;
disp('Aproxima��o pelo polin�mio de Newton.... yp =  p3(0.9): ');
yp

disp('Valor da fun��o f(x) em 0.9............. yf = erf(0.9):');
yf = erf(0.9)

disp('Erro absoluto da aproxima��o yp....... |e3(0.9)| = | yf - yp |:');
e3 = abs(yf - yp) 

% 3�. Construir o gr�fico da fun��o f(x)= erf(x) e do polin�mio interpolador de Newton
disp('Prima uma tecla para visualizar o gr�fico da fun��o f(x)= erf(x)'); 
disp('e do seu polin�mio interpolador de Newton p3(x)');
disp('                          ');
pause;

% avalia o polin�mio de Newtom para 0<=x<=1.5 com incremento 0.005
X1 = 0:0.005:1.5;
Y1 = erf(X1);                     % valores da fun��o f(x)= erf(x)
Y2 = newtondifdiv(X1,X,Y);        % valores do polin�mio de Newton

a = min(X1);
b = max(X1);
c = min(Y1);
d = max(Y1);
figure(1);clf;
hold on;
whitebg('w');
axis([a b c d]);
plot(X1,Y1,'-b', X1,Y2,'-m');
legend('f(x)= erf(x)', 'p3(x) - polin�mio de Newton',4);
plot(X,Y,'or');
xlabel('x');
ylabel('y');
title('Aproxima��o de f(x) = erf(x) pelo polin�mio interpolador de Newton');
grid;
hold off;


%----------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------
