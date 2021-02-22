%--------------------------------------------------------------------
%  FP4 - Exerc. 2
% A partir da seguinte tabela de valores aproximados da função do erro 
% y = erf(x) (erf em MatLab) 
%        x | 0  0.5    1       1.5
%        y | 0  0.5205 0.8427 0.9661
% determine o polinómio interpolador de Newton de grau 3, 
% calcule o valor p(0.9) e compare com o valor aproximado 
% de erf(0.9), 0.7969.
% ---------------------------------------------------------------

% 1º. Determinar as diferenças divididas do polinómio interpolador de Newton
%     e calcular a aproximação p(0.9)

format short;
clc; clear all;

disp('Nós de interpolação: ');
X = [0, 0.5, 1, 1.5]

disp('Valores nodais: ');
Y = [0, 0.5205, 0.8427, 0.9661]

disp('Prima uma tecla para determinar as diferenças divididas do polinómio');
disp('interpolador de Newton p3(x) que aproxima a função f(x)= erf(x) ');
disp('e calcular a aproximação p3(0.9)');
pause;

yp = newtondifdiv(0.9,X,Y);

% 2º. Calcular o erro absoluto da aproximação yp

format long;
disp('Aproximação pelo polinómio de Newton.... yp =  p3(0.9): ');
yp

disp('Valor da função f(x) em 0.9............. yf = erf(0.9):');
yf = erf(0.9)

disp('Erro absoluto da aproximação yp....... |e3(0.9)| = | yf - yp |:');
e3 = abs(yf - yp) 

% 3º. Construir o gráfico da função f(x)= erf(x) e do polinómio interpolador de Newton
disp('Prima uma tecla para visualizar o gráfico da função f(x)= erf(x)'); 
disp('e do seu polinómio interpolador de Newton p3(x)');
disp('                          ');
pause;

% avalia o polinómio de Newtom para 0<=x<=1.5 com incremento 0.005
X1 = 0:0.005:1.5;
Y1 = erf(X1);                     % valores da função f(x)= erf(x)
Y2 = newtondifdiv(X1,X,Y);        % valores do polinómio de Newton

a = min(X1);
b = max(X1);
c = min(Y1);
d = max(Y1);
figure(1);clf;
hold on;
whitebg('w');
axis([a b c d]);
plot(X1,Y1,'-b', X1,Y2,'-m');
legend('f(x)= erf(x)', 'p3(x) - polinómio de Newton',4);
plot(X,Y,'or');
xlabel('x');
ylabel('y');
title('Aproximação de f(x) = erf(x) pelo polinómio interpolador de Newton');
grid;
hold off;


%----------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------
