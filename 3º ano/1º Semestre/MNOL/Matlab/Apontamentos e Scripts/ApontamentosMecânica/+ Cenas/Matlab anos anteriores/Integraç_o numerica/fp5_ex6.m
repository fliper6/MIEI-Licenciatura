% -----------------------------------------------------------------
% FP5- Exerc. 6
% Pretende-se calcular um valor aproximado do integral I de ln(1/x) em
% [1,2]
% (a) Use a regra de Simpson para obter uma aproxima��o de I com tr�s casas
% decimais correctas
% (b) Sem calcular o valor exacto de I diga, justificando, se a aproxima��o
%  calculada � por defeito ou por excesso
% --------------------------------------------------------

clc; clear all; 
format short

a=1
b=2
f=inline('log(1./x)')

disp('Se queremos calcular uma aproxima��o Isc de I com 3 casas decimais correctas,');
disp('ent�o |e(Isc)| <= 0.5*10^-3 -> tol = 0.5*10^-3');

tol=0.5e-3

disp('Devemos determinar qual o menor n�mero de subintervalos que garante obter');
disp('uma aproxima��o com erro de truncatura que n�o exceda, em valor absoluto, 0.5�10^(-3)');
disp('Prima uma tecla para determinar n');
pause;
disp('      ');
disp('|e(Isc)| <= M *(b-a)^5 /(180 n^4) <= tol, M = max |f^4(x)| em [1, 2], ent�o');
disp('o n�mero m�nimo de subintervalos n que garante |e(Isc)| <= tol');
disp(' � dado por n >= raiz quarta de (M*(b-a)^4/(180*tol)');
disp('               ');
disp('1�. Calcular M = max |f^4(x)| em [1, 2]');
disp('Vamos estudar o comportamento da 4� derivada de f(x) em [1,2]');
syms x;
df4=diff(f(x),4)
% Gr�fico de f4(x)
figure(1)
clf;
title(['Gr�fico de f^{(4)}(x)']);
hold on;
grid on;
x=linspace(a,b);
plot(x,subs(df4,x),'b');

disp('Por an�lise do gr�fico vemos que a 4� derivada � decrescente e positiva em [1,2]');
y1= abs(subs(df4,1));
y2 =abs(subs(df4,2));
disp(['|f^4(1)|=', num2str(y1, 4), ', |f^4(2)|=', num2str(y2, 4), ' ent�o M =max |f^4(x)|=|f^4(1)| =', num2str(y1, 4)]);

M=max(y1,y2);

disp('     ');
disp('2�. Determinar n - n�mero m�nimo de subintervalos que garante |e(Isc)| <= tol');
disp('Prima uma tecla para determinar n');
pause;
disp('      ');
disp('Como |e(Isc)| <= M *(b-a)^5 /(180 n^4) <= tol, ent�o');
disp('o n�mero m�nimo de subintervalos n que garante |e(Isc)| <= tol');
disp(' � dado por n >= raiz quarta de (M*(b-a)^4/(180*tol)');

n=nthroot(M*(b-a)^5/(180*tol),4)

disp('Como n deve ser inteiro e par temos que aproximar o valor obtido')
disp('pelo valor inteiro par mais pr�ximo por excesso');

n=ceil(n);
% Mas n tem que ser par para usar a regra de Simpson
if mod(n,2)~=0
  n=n+1; 
end

disp('                  ');
disp(['n = ', num2str(n), ' � o menor n�mero de subintervalos que garante |e(Isc)| <=tol']);
disp(' ----------------------------------------------');
disp('            ');
disp('3�. Calcular o valor aproximado do integral usando a regra de Simpson');
disp('composta com n subintervalos em [a, b]');
disp('                  ');
disp('Prima uma tecla para calcular um valor aproximado do integral'); 
disp('usando a regra de Simpson composta:');
disp('                  ');
pause;

Isc = simpson(f, a, b, n);

disp('                  ');
disp(['O valor aproximado da integral, Isc = ', num2str(Isc, 15)]);
disp('-----------------------------------------------------------------');


disp('Sem calcular o valor exacto de I, � possivel dizer se o valor aproximado');
disp('obtido para I � por excesso ou por defeito? Justifique');
disp('Prima uma tecla para continuar');
pause;

disp('Uma vez que a 4� derivada � sempre positiva em [2,1]');
disp('e(Isc) = -(b-a)/180 h^4 f^(4)(psi) < 0');
disp('Como e(Isc) = I -Isc < 0 <=> I < Isc');
disp('ent�o a aproxima��o Isc de I � por excesso');
disp('  ');

disp('Podemos confirmar os resultados porque sabemos calcular');
disp('o valor do integral da fun��o dada');
disp('Prima uma tecla para continuar');
pause;

syms x;
I = double(int(f(x), a, b));

disp(['O valor do integral....................................I = ', num2str(I, 15)]);
disp(['O valor aproximado pelo regra de Simpson composta....Isc = ', num2str(Isc, 15)]);
eIsc= abs(I-Isc);
disp(['O erro absoluto de Isc.....|e(Isc)|= |I - Isc|= ', num2str(eIsc, 15)]);
if (eIsc<= tol)
  disp(['|e(Isc)| <= ',num2str(tol, 15)]);
end;

disp('Note que realmente a aproxima��o calculada � por excesso e que o erro � menor que 0.5*10^-3');



%------------------------------------------------------------------
%  Gladys Castillo, Ant�nio Pereira, U.A, 2009
%------------------------------------------------------------------


