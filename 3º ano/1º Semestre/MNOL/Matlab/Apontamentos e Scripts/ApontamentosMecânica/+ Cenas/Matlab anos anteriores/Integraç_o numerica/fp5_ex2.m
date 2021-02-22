% -----------------------------------------------------------------
%   FP5- Exerc. 2
% Calcular o valor aproximado do integral I = int(exp(-x^2)) dx em [0,1]
% pelas regras dos trapézios e Simpson, usando 20 subintervalos. 
% --------------------------------------------------------

clc;
format long e;

% Dados de entrada
a=0
b=1
f=inline('exp(-x.^2)')
n=20

% Usando a regra dos Trapezios Composta;

disp('Prima uma tecla para calcular um valor aproximado do integral'); 
disp('usando as rotinas de MN que implementam as regras dos trapézios');
disp('e Simpson compostas');
disp('   ');
pause;
disp('-----------------------------------------------------------------');

Itc = trapezios(f, a, b, n)
Isc = simpson(f, a, b, n)

disp('-----------------------------------------------------------------');
disp('Prima uma tecla para calcular um valor aproximado do integral'); 
disp('usando um conjunto de comandos de MatLab que implementam as regras');
disp('dos trapézios e de Simpson compostas');
disp('                  ');
pause;
disp('-----------------------------------------------------------------');

h=(b-a)/n
x=a:h:b;
y=f(x);

% Regra dos trapézios
Ctc(1)=1; Ctc(n+1)=1;
Ctc(2:n)=2
Itc= h/2 * sum(Ctc.*y)

% Regra do Simpson

Csc(1)=1; Csc(n+1)=1;
Csc(2:2:n)=4;  % elementos com índices pares
Csc(3:2:n-1)=2 % elementos com índices impares
Isc= h/3 * sum(Csc.*y)

disp('-----------------------------------------------------------------');

disp('Podemos verificar as aproximações obtidas calculando o');
disp('o valor do integral da função dada');
disp('Prima uma tecla para continuar');
syms x;
I = double(int(f(x), a, b));

disp(['O valor do integral....................................I = ', num2str(I, 15)]);
disp(['O valor aproximado pela regra do trapézio composta...Itc = ', num2str(Itc, 15)]);
disp(['O valor aproximado pelo regra de Simpson composta....Isc = ', num2str(Isc, 15)]);

eItc= abs(I-Itc);
disp(['O erro absoluto de Itc.....|e(Itc)|= |I - Itc|= ', num2str(eItc, 15)]);
eIsc= abs(I-Isc);
disp(['O erro absoluto de Isc.....|e(Isc)|= |I - Isc|= ', num2str(eIsc, 15)]);







%------------------------------------------------------------------
%  Gladys Castillo, António Pereira, U.A, 2009
%------------------------------------------------------------------
