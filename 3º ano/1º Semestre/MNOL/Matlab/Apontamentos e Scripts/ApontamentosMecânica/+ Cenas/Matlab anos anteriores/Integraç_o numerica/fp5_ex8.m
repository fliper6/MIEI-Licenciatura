
% -----------------------------------------------------------------
% FP5- Exerc. 8
% Pretendese aproximar o integral I = int(exp(x^2)) dx em [0,1]
% (a) Usando a regra dos trap�zios composta, com o menor n�mero de subintervalos poss�vel,
%  aproxime I por forma a que o erro de truncatura cometido n�o exceda, em valor absoluto,
%  0.5�10^(-2). Sem calcular o valor exacto de I, � poss�vel dizer se o valor aproximado obtido
%  para I � por excesso ou por defeito? Justifique.
%  b) Obtenha aproxima��es para o valor do integral I, usando as f�rmulas de quadratura de
%  Gauss, com 2,3,4 e 5 pontos.
%
% --------------------------------------------------------
clc;
format long e;

% Dados de entrada
a=0
b=1
f=inline('exp(x.^2)')
tol=0.5e-2

% (a) Usando a regra dos trap�zios composta, com o menor n�mero de subintervalos poss�vel,
%  aproxime I por forma a que o erro de truncatura cometido n�o exceda, em valor absoluto,
%  0.5�10^(?2). Sem calcular o valor exacto de I, � poss�vel dizer se o valor aproximado obtido
%  para I � por excesso ou por defeito? Justifique.

disp('1�. Calcular M2 - valor m�ximo do valor absoluto da segunda derivada de f(x) em [a, b]');
disp('Prima uma tecla para continuar');
pause;

df2= inline('2*exp(x.^2) + 4*x.^2.*exp(x.^2)');  
disp('Podemos determinar o valor m�ximo M2 graficamente...');

% Gr�fico da segunda derivada de f(x) em [0,1]'
figure(1)
clf;
title(['Gr�fico da segunda derivada de f(x) em [0,1]']);
hold on;
grid on;
x=linspace(a,b);
y=df2(x);
plot(x,y,'b');

disp('Por an�lise do gr�fico vemos que a 2� derivada de f(x) � crescente e positiva');
disp('em [0,1]. Logo M2 = |f^2(1)| ');

M2 = df2(1)

plot(1,M2, 'or');

disp('     ');
disp('2�. Determinar n - n�mero m�nimo de subintervalos que garante |e(Itc)| <= tol');
disp('Prima uma tecla para determinar n');
pause;
disp('      ');
disp('Como |e(Itc)| <= M2 *(b-a)^3 /(12 n^2) <= tol, ent�o');
disp('o n�mero m�nimo de subintervalos n que garante |e(Itc)| <= tol');
disp('� dado pelo menor valor inteiro positivo que garante que');
disp(' n >= sqrt(M2*(b-a)^3/(12*tol)');

n = sqrt(M2*(b-a)^3/(12*tol))

disp('Devemos aproximar o valor obtido pelo valor inteiro mais pr�ximo por excesso');
n = ceil(n);  % rounds the result to the nearest integer

disp('                  ');
disp(['n = ', num2str(n), ' � o menor n�mero de subintervalos que garante |e(Itc)| <= tol']);
disp(' ----------------------------------------------');

disp('            ');
disp('3�. Calcular o valor aproximado do integral usando a regra dos trapezios');
disp('composta com n subintervalos em [a, b]');
disp('                  ');
disp('Prima uma tecla para calcular um valor aproximado do integral'); 
disp('usando a regra dos trap�zios composta:');
disp('                  ');
pause;
disp('-----------------------------------------------------------------');

Itc = trapezios(f, a, b, n);

disp('                  ');
disp(['O valor aproximado do integral, Itc = ', num2str(Itc, 15)]);
disp('-----------------------------------------------------------------');


disp('4�. Sem conhecer o valor real do integral I podemos concluir que esta'); 
disp('aproxima��o � por excesso. Como e(Itc) = - ((b-a)^3 /12 *n^2) * max f''''(x)');
disp('e f''''(x)> 0 em [0,1], ent�o e(Itc) = I -Itc < 0 <=> I < Itc');

disp('      ');
disp('Podemos ainda confirmar que para a aproxima��o Itc de I o erro n�o excede, em');
disp('valor absoluto, o valor da tolerancia dada calculando o valor exacto do integral dado:');
disp('      ');

syms x;
I = double(int(f(x), a, b));

disp(['O valor do integral..................I = ', num2str(I, 15)]);
disp(['O valor aproximado da integral.....Itc = ', num2str(Itc, 15)]);
erro= abs(I-Itc);
disp(['O erro absoluto.....|e(Itc)|= |I - Itc|= ', num2str(erro, 15)]);
if (erro<= tol)
  disp(['O erro � menor que a tolerancia: ',num2str(tol, 15)]);
end;  
disp('      ');

%  b) Obtenha aproxima��es para o valor do integral I, usando as f�rmulas de quadratura de
%  Gauss, com 2,3,4 e 5 pontos.

disp('Prima um tecla para determinar aproxima��es para o valor do integral I,');
disp('usando as f�rmulas de quadratura de Gauss, com 2,3,4 e 5 pontos');
pause;

for n=2:5
  IG = quadgauss(f,a,b,n);
  disp(['Com n=', num2str(n),' pontos.....:   IG = ', num2str(IG, 15)]);
end
  






%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2010
%------------------------------------------------------------------
