% -----------------------------------------------------------------
% FP5- Exerc. 1
% Calcule um valor aproximado do integral I = int(exp(x)* sin(x)) dx em
% [0,pi/2] com um erro de truncatura n�o superior, em valor absoluto, a 0.01,
% usando:
% (a) a regra dos Trap�zios composta
% (b) a regra de Simpson composta
% --------------------------------------------------------
clc;
format long e;

% Dados de entrada

a=0
b=pi/2
f=inline('exp(x)*sin(x)')
tol=0.01

% 1�. Usando a regra dos trap�zios composta
disp('Prima uma tecla para determinar o menor n�mero de subintervalos, n,'); 
disp('que aproxima o integral de f(x)=exp(x) * sin(x) em [0, pi/2] usando a regra dos trap�zios');
disp('por forma a que |e_T| <= 0.01');
disp('               ');

disp('1�: Calcular  M2 - valor m�ximo do valor absoluto da segunda derivada de f(x) em [a, b]');
disp('Prima uma tecla para calcular M2');
pause;

syms x;
df2= diff(f(x), 2)

% Para determinar M2, o valor m�ximo do valor absoluto da segunda derivada
% em [a, b] podemos usar a fun��o fminbnd(f,a,b) 
% Como fminbnd calcula o m�nimo de f(x) em [a,b] para poder determinar 
% o m�ximo devemos multiplicar por -1 o valor absoluto de df2

x_max = fminbnd(['-1 * abs(', char(df2), ')'], a, b); 
M2 = abs(subs(df2, x_max));

disp(['O valor maximo, M2 = ', num2str(M2, 8), ' de |f''''(x)| se atinge em x =', num2str(x_max, 8)]);
disp('                  ');

disp('Podemos tamb�m determinar o valor m�ximo M2 graficamente...');
figure(1)
clf;
title(['Gr�fico de f''''(x)=2*exp(x)*cos(x)']);
hold on;
grid on;
x=linspace(a,b);
plot(x,subs(df2,x),'b', x_max,subs(df2,x_max), 'or');

disp('Por an�lise do gr�fico vemos que a 2� derivada � positiva em [0,pi/2] mas');
disp('n�o � mon�tona crescente nem descrecente, pelo que');
disp('para determinar o m�ximo � preciso determinar x: f''''''(x)=0');
disp('f''''''(x) = 0 <=> cos x = sin x <=> x = pi/4');
disp(['Logo, M2=max |f''''(x)| = |f''''(pi/4)| =', num2str(M2, 8)]);

disp('     ');
disp('2�: Determinar n - n�mero m�nimo de subintervalos que garante |e(Itc)| <= tol');
disp('Prima uma tecla para determinar n');
pause;
disp('      ');
disp('Como |e(Itc)| <= M2 *(b-a)^3 /(12 n^2) <= tol, ent�o');
disp('o n�mero m�nimo de subintervalos n que garante |e(Itc)| <= tol');
disp('� dado pelo menor valor inteiro positivo que garante que');
disp(' n >= sqrt(M2*(b-a)^3/(12*tol)');

n = sqrt(M2*(b-a)^3/(12*tol))

disp('Como n deve ser inteiro temos que aproximar o valor obtido pelo valor inteiro mais pr�ximo por excesso');

n = ceil(n);  % rounds the result to the nearest integer

disp('                  ');
disp(['n = ', num2str(n), ' � o menor n�mero de subintervalos que garante |e(Itc)| <=0.01']);
disp(' ----------------------------------------------');

disp('            ');
disp('3�: Calcular o valor aproximado do integral usando a regra dos trapezios');
disp('composta com n subintervalos em [a, b]');
disp('                  ');
disp('Prima uma tecla para calcular um valor aproximado do integral'); 
disp('usando a regra dos trap�zios composta:');
disp('                  ');
pause;
disp('-----------------------------------------------------------------');

Itc = trapezios(f, a, b, n);

disp('                  ');
disp(['O valor aproximado da integral, Itc = ', num2str(Itc, 15)]);
disp('-----------------------------------------------------------------');
    
% 2�. Usando a regra de Simpson;
disp('                  ');
disp('Prima uma tecla para determinar o menor n�mero de subintervalos, n,'); 
disp('que aproxima o integral de f(x)=exp(x) * sin(x) usando a regra de Simpson');
disp('por forma a que |e(Itc)| <= 0.01');
disp('                  ');
pause;

disp(' ----------------------------------------------');

disp('               ');
disp('1�: Calcular m�ximo de |f^4(x)| em [a, b]');
disp('Prima uma tecla para calcular M4=  max |f^4(x)| em [a, b]');
pause;

syms x;
df4= diff(f(x), 4) 

% Para determinar o m�ximo do valor absoluto de df4 podemos usar a fun��o fminbnd(f,a,b) 
% Como fminbnd calcula o m�nimo de f(x) em [a,b] para poder determinar 
% o m�ximo devemos multiplicar por -1 o valor absoluto de df4

x_max = fminbnd(['-1 * abs(', char(df4), ')'], a, b); 
M4 = abs(subs(df4, x_max)); 
disp(['O valor maximo, M4 = ', num2str(M4, 8), ' de |f^4(x)| se atinge em x =', num2str(x_max, 8)]);
disp('                  ');

% Outra variante para determinar M4 � analizar o gr�fico da quarta derivada de f4(x) 
% Gr�fico de f4(x)
figure(2)
clf;
title(['Gr�fico da quarta derivada de f(x)']);
hold on;
grid on;
x=linspace(a,b);
plot(x,subs(df4,x),'b', x_max,subs(df4,x_max), 'or');

disp('Por an�lise do gr�fico vemos que f^(4)(x) = - 4 e^x  sin(x) � negativa');
disp('e decrescente em [0, pi/2], pelo que |f^(4)(x)| � uma fun��o positiva e crescente');
disp('e o seu valor m�ximo se atinge em x=pi/2');

disp('     ');
disp('Passo 2: Determinar n - n�mero m�nimo de subintervalos que garante |e(Isc)| <= tol');
disp('Prima uma tecla para determinar n');
pause;
disp('      ');
disp('Como |e(Isc)| <= M4 *(b-a)^5 /(180 n^4) <= tol, ent�o');
disp('o n�mero m�nimo de subintervalos n que garante |e(Isc)| <= tol');
disp('� dado pelo menor valor inteiro positivo PAR n que garante que');
disp('  n >= raiz quarta de (M4*(b-a)^4/(180*tol)');

n=nthroot(M4*(b-a)^5/(180*tol),4)

disp('Como n deve ser inteiro e par temos que aproximar o valor obtido')
disp('pelo valor inteiro par mais pr�ximo por excesso');

n=ceil(n);

% Mas n tem que ser par para usar a regra de Simpson
if mod(n,2)~=0
  n=n+1; 
end

disp('                  ');
disp(['n = ', num2str(n), ' � o menor n�mero de subintervalos que garante |e(Isc)| <=0.01']);
disp(' ----------------------------------------------');


disp('            ');
disp('Passo 3: Calcular o valor aproximado do integral usando a regra de Simpson');
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

disp('   ');
disp('Sem conhecer o valor real do integral I podemos concluir que as'); 
disp('aproxima��es determinadas s�o por excesso ou por defeito?');
disp('Prima uma tecla para continuar');
pause;

disp('   ');
disp('Para a aproxima��o Itc determinada pela regra de Trap�zio Composta:');
disp('Como e(Itc) = - ((b-a)^3 /12 *n^2) * f''''(psi), psi in (a,b)');
disp('e f''''(x)> 0 em (0,pi/2), ent�o e(Itc) = I -Itc < 0 <=> I < Itc');
disp('ent�o a aproxima��o Itc de I � por excesso');
disp('  ');
disp('Para a aproxima��o Isc determinada pela regra de Simpson Composta:');
disp('Como e(Isc) = - ((b-a)^5 /180 *n^4) * f^4(psi), psi in (a, b)');
disp('e f^4(x)< 0 em (0,pi/2), ent�o e(Isc) = I -Isc > 0 <=> I > Isc');
disp('ent�o a aproxima��o Isc de I � por defeito');

disp('      ');
disp('Podemos ainda confirmar o dito anteriormente porque sabemos calcular');
disp('o valor do integral da fun��o dada');
disp('Prima uma tecla para continuar');
pause;

syms x;
I = double(int(f(x), a, b));

disp(['O valor do integral....................................I = ', num2str(I, 15)]);
disp(['O valor aproximado pela regra do trap�zio composta...Itc = ', num2str(Itc, 15)]);
disp(['O valor aproximado pelo regra de Simpson composta....Isc = ', num2str(Isc, 15)]);

disp(' ');
disp(' Tamb�m podemos confirmar que para as aproxima��es Itc e Isc de I calculadas');
disp('o erro n�o excede em valor absoluto o valor da tolerancia dada');
disp(' ');
eItc= abs(I-Itc);
disp(['O erro absoluto de Itc.....|e(Itc)|= |I - Itc|= ', num2str(eItc, 15)]);
if (eItc<= tol)
  disp(['|e(Itc)| <= ',num2str(tol, 15)]);
end;
eIsc= abs(I-Isc);
disp(['O erro absoluto de Isc.....|e(Isc)|= |I - Isc|= ', num2str(eIsc, 15)]);
if (eIsc<= tol)
  disp(['|e(Isc)| <= ',num2str(tol, 15)]);
end;





%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2010
%------------------------------------------------------------------
