% -----------------------------------------------------------------
% FP5- Exerc. 1
% Calcule um valor aproximado do integral I = int(exp(x)* sin(x)) dx em
% [0,pi/2] com um erro de truncatura não superior, em valor absoluto, a 0.01,
% usando:
% (a) a regra dos Trapézios composta
% (b) a regra de Simpson composta
% --------------------------------------------------------
clc;
format long e;

% Dados de entrada

a=0
b=pi/2
f=inline('exp(x)*sin(x)')
tol=0.01

% 1º. Usando a regra dos trapézios composta
disp('Prima uma tecla para determinar o menor número de subintervalos, n,'); 
disp('que aproxima o integral de f(x)=exp(x) * sin(x) em [0, pi/2] usando a regra dos trapézios');
disp('por forma a que |e_T| <= 0.01');
disp('               ');

disp('1º: Calcular  M2 - valor máximo do valor absoluto da segunda derivada de f(x) em [a, b]');
disp('Prima uma tecla para calcular M2');
pause;

syms x;
df2= diff(f(x), 2)

% Para determinar M2, o valor máximo do valor absoluto da segunda derivada
% em [a, b] podemos usar a função fminbnd(f,a,b) 
% Como fminbnd calcula o mínimo de f(x) em [a,b] para poder determinar 
% o máximo devemos multiplicar por -1 o valor absoluto de df2

x_max = fminbnd(['-1 * abs(', char(df2), ')'], a, b); 
M2 = abs(subs(df2, x_max));

disp(['O valor maximo, M2 = ', num2str(M2, 8), ' de |f''''(x)| se atinge em x =', num2str(x_max, 8)]);
disp('                  ');

disp('Podemos também determinar o valor máximo M2 graficamente...');
figure(1)
clf;
title(['Gráfico de f''''(x)=2*exp(x)*cos(x)']);
hold on;
grid on;
x=linspace(a,b);
plot(x,subs(df2,x),'b', x_max,subs(df2,x_max), 'or');

disp('Por análise do gráfico vemos que a 2ª derivada é positiva em [0,pi/2] mas');
disp('não é monótona crescente nem descrecente, pelo que');
disp('para determinar o máximo é preciso determinar x: f''''''(x)=0');
disp('f''''''(x) = 0 <=> cos x = sin x <=> x = pi/4');
disp(['Logo, M2=max |f''''(x)| = |f''''(pi/4)| =', num2str(M2, 8)]);

disp('     ');
disp('2º: Determinar n - número mínimo de subintervalos que garante |e(Itc)| <= tol');
disp('Prima uma tecla para determinar n');
pause;
disp('      ');
disp('Como |e(Itc)| <= M2 *(b-a)^3 /(12 n^2) <= tol, então');
disp('o número mínimo de subintervalos n que garante |e(Itc)| <= tol');
disp('é dado pelo menor valor inteiro positivo que garante que');
disp(' n >= sqrt(M2*(b-a)^3/(12*tol)');

n = sqrt(M2*(b-a)^3/(12*tol))

disp('Como n deve ser inteiro temos que aproximar o valor obtido pelo valor inteiro mais próximo por excesso');

n = ceil(n);  % rounds the result to the nearest integer

disp('                  ');
disp(['n = ', num2str(n), ' é o menor número de subintervalos que garante |e(Itc)| <=0.01']);
disp(' ----------------------------------------------');

disp('            ');
disp('3º: Calcular o valor aproximado do integral usando a regra dos trapezios');
disp('composta com n subintervalos em [a, b]');
disp('                  ');
disp('Prima uma tecla para calcular um valor aproximado do integral'); 
disp('usando a regra dos trapézios composta:');
disp('                  ');
pause;
disp('-----------------------------------------------------------------');

Itc = trapezios(f, a, b, n);

disp('                  ');
disp(['O valor aproximado da integral, Itc = ', num2str(Itc, 15)]);
disp('-----------------------------------------------------------------');
    
% 2º. Usando a regra de Simpson;
disp('                  ');
disp('Prima uma tecla para determinar o menor número de subintervalos, n,'); 
disp('que aproxima o integral de f(x)=exp(x) * sin(x) usando a regra de Simpson');
disp('por forma a que |e(Itc)| <= 0.01');
disp('                  ');
pause;

disp(' ----------------------------------------------');

disp('               ');
disp('1º: Calcular máximo de |f^4(x)| em [a, b]');
disp('Prima uma tecla para calcular M4=  max |f^4(x)| em [a, b]');
pause;

syms x;
df4= diff(f(x), 4) 

% Para determinar o máximo do valor absoluto de df4 podemos usar a função fminbnd(f,a,b) 
% Como fminbnd calcula o mínimo de f(x) em [a,b] para poder determinar 
% o máximo devemos multiplicar por -1 o valor absoluto de df4

x_max = fminbnd(['-1 * abs(', char(df4), ')'], a, b); 
M4 = abs(subs(df4, x_max)); 
disp(['O valor maximo, M4 = ', num2str(M4, 8), ' de |f^4(x)| se atinge em x =', num2str(x_max, 8)]);
disp('                  ');

% Outra variante para determinar M4 é analizar o gráfico da quarta derivada de f4(x) 
% Gráfico de f4(x)
figure(2)
clf;
title(['Gráfico da quarta derivada de f(x)']);
hold on;
grid on;
x=linspace(a,b);
plot(x,subs(df4,x),'b', x_max,subs(df4,x_max), 'or');

disp('Por análise do gráfico vemos que f^(4)(x) = - 4 e^x  sin(x) é negativa');
disp('e decrescente em [0, pi/2], pelo que |f^(4)(x)| é uma função positiva e crescente');
disp('e o seu valor máximo se atinge em x=pi/2');

disp('     ');
disp('Passo 2: Determinar n - número mínimo de subintervalos que garante |e(Isc)| <= tol');
disp('Prima uma tecla para determinar n');
pause;
disp('      ');
disp('Como |e(Isc)| <= M4 *(b-a)^5 /(180 n^4) <= tol, então');
disp('o número mínimo de subintervalos n que garante |e(Isc)| <= tol');
disp('é dado pelo menor valor inteiro positivo PAR n que garante que');
disp('  n >= raiz quarta de (M4*(b-a)^4/(180*tol)');

n=nthroot(M4*(b-a)^5/(180*tol),4)

disp('Como n deve ser inteiro e par temos que aproximar o valor obtido')
disp('pelo valor inteiro par mais próximo por excesso');

n=ceil(n);

% Mas n tem que ser par para usar a regra de Simpson
if mod(n,2)~=0
  n=n+1; 
end

disp('                  ');
disp(['n = ', num2str(n), ' é o menor número de subintervalos que garante |e(Isc)| <=0.01']);
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
disp('aproximações determinadas são por excesso ou por defeito?');
disp('Prima uma tecla para continuar');
pause;

disp('   ');
disp('Para a aproximação Itc determinada pela regra de Trapézio Composta:');
disp('Como e(Itc) = - ((b-a)^3 /12 *n^2) * f''''(psi), psi in (a,b)');
disp('e f''''(x)> 0 em (0,pi/2), então e(Itc) = I -Itc < 0 <=> I < Itc');
disp('então a aproximação Itc de I é por excesso');
disp('  ');
disp('Para a aproximação Isc determinada pela regra de Simpson Composta:');
disp('Como e(Isc) = - ((b-a)^5 /180 *n^4) * f^4(psi), psi in (a, b)');
disp('e f^4(x)< 0 em (0,pi/2), então e(Isc) = I -Isc > 0 <=> I > Isc');
disp('então a aproximação Isc de I é por defeito');

disp('      ');
disp('Podemos ainda confirmar o dito anteriormente porque sabemos calcular');
disp('o valor do integral da função dada');
disp('Prima uma tecla para continuar');
pause;

syms x;
I = double(int(f(x), a, b));

disp(['O valor do integral....................................I = ', num2str(I, 15)]);
disp(['O valor aproximado pela regra do trapézio composta...Itc = ', num2str(Itc, 15)]);
disp(['O valor aproximado pelo regra de Simpson composta....Isc = ', num2str(Isc, 15)]);

disp(' ');
disp(' Também podemos confirmar que para as aproximações Itc e Isc de I calculadas');
disp('o erro não excede em valor absoluto o valor da tolerancia dada');
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
