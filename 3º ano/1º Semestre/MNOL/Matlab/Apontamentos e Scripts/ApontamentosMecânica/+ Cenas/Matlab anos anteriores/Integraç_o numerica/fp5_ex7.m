% -----------------------------------------------------------------
%   FP5- Exerc. 7
% ---------------------------------------------------------------
disp('Um carro inicia um percurso e um aparelho mede o consumo de gasolina no');
disp('instante em que percorreu x km. Na tabela seguinte foram registados os');
disp('consumos de combustível, designando f(x) o consumo do carro,');
disp('naquele instante, em litros/km');

format short;
clear all; clc;

disp('Distância em km: ');

x = [0.00 1.25 2.50 3.75 5.00 6.50 8.00 9.50 10.00]

disp('Consumo do carro, em litros/km:');

y = [0.260 0.208 0.172 0.145 0.126 0.113 0.104 0.097 0.092]

disp('Prima uma tecla para calcular valores aproximados para o consumo total de');
disp('gasolina, dado por I = int (f(x) dx em [0, 10]'); 
disp('usando adequadamente as regras de integração numérica que estudou.');
disp('                             ');
pause;

disp('Vamos a usar 3 regras de integraçao de Newton-Cotes')
disp('por forma a minorar o erro de truncatura.');
disp('Para isto devemos seleccionar para cada subconjunto de pontos');
disp('com igual espaçamento h, a regra mais simples entre aquelas que');
disp('apresentam o maior grau de exactidão.');
disp('Note que as regras de Newton-Cotes se baseiam na aproximação da');
disp('função integranda pelo seu polinómio interpolador Pn de grau<=n:');
disp(' Regra dos trapézios.................. n = 1');
disp(' Regra de Simpson..................... n = 2');
disp(' Regra de 3/8......................... n = 3');
disp('As regras de Newton-Cotes têm grau de exactidão');
disp('           =   n se n é impar'); 
disp('           = n+1 se n é par'); 
disp('--------------------------------------------------------');
disp('Vamos considerar:');
disp('no intervalo [0, 5],    h=1.25,  4 subintervalos: regra de Simpson composta (grau 3)');
disp('no intervalo [5, 9.5],  h=1.50,  3 subintervalos: regra de 3/8              (grau 3)');
disp('no intervalo [9.5, 10], h=0.5,   1 subintervalos: regra dos trapezios       (grau 1)');

format long;

%  Usando a regra de Simpson em [0,5];
disp('                  ');
disp('Prima uma tecla para calcular um valor aproximado da integral'); 
disp('no intervalo [0, 10] usando estas 3 regras:');
disp('                  ');
pause;

disp('O valor aproximado da integral em [0, 5] usando a regra de Simpson composta:');
hSC = (x(5)-x(1))/4 ;
ISC = hSC * ( y(1) + 4 * y(2) + 2 * y(3) + 4 * y(4) + y(5)) /3

disp('O valor aproximado da integral em [5, 9.5] usando a regra de 3/8:');
h3_8 = (x(8)-x(5))/3; 
I3_8 = 3 * h3_8 * ( y(5) + 3 * y(6) + 3 * y(7) +  y(8)) / 8

disp('O valor aproximado da integral em [9.5, 10] usando a regra dos Trapezios:');
IT =  (x(9)-x(8)) * (y(8) + y(9)) / 2

Iaprox =  ISC + I3_8 + IT;

disp('-----------------------------------------------------------------------');
disp(['O valor aproximado do integral em [0, 10], Iaprox = ', num2str(Iaprox, 15)]);
disp('-----------------------------------------------------------------------');

% (b ) Determine uma estimativa para o erro de truncatura cometido, 
%  em valor absoluto, no cálculo de I.

disp('    ');
disp('Prima uma tecla para determinar uma estimativa para o erro de truncatura');
disp('em valor absoluto, cometido no cálculo de I');
pause;

disp('Estimativa do erro de truncatura para a regra de Simpson em [0,5]:');
disp('O erro de truncatura, em valor absoluto, é dado pela fórmula:');
disp('|es| = (b-a)/180 h^4 |f^(4)(zi)|, 0 < zi < 5.00');
disp('Como não conhecemos a função f(x) para determinar uma estimativa');
disp('de f^(4)(xi) usamos as diferença divididas de ordem 4');
disp('           f^(4)(zi) = 4! * f[xi, xi+1, xi+2, xi+3, xi+4]');
disp('                          xi < zi < xi+4'           );
disp('Para determinar uma estimativa de f^(4)(zi) no intervalo ]0,5[');
disp('podemos usar a diferença dividida f[0.00 1.25 2.50 3.75 5.00]');
disp(' Existe 0 < zi < 5: f^(4)(zi) = 4! * f[0.00 1.25 2.50 3.75 5.00]');
disp('                       ');

format short;
x = [0.00 1.25 2.50 3.75 5.00]
y = [0.260 0.208 0.172 0.145 0.126]
format long;
[c, tab] = difdivcoef(x, y); % foi alterada a rotina difdivcoef para obter como output também a tabela

absdf4 = abs(tab(1, 4))* factorial(4);  % f[0.00 1.25 2.50 3.75 5.00]=tab(1, 4)

disp('Estimativa do erro de truncatura usando a regra de Simpson composta: ');

eSC = ((x(5)-x(1)) * hSC^4 * absdf4)  / 180

disp('               ');
disp('Calculando estimativa do erro de truncatura para a regra de 3/8 em [5, 9.5]');
disp('               ');
disp('O erro de truncatura, em valor absoluto, é dado pela fórmula:');
disp('|e3/8| = 3/80 h^5 |f^(4)(zi)|, para um zi tal que: 5 < zi < 9.5');
disp('Como não conhecemos a função f(x), podemos usar as diferenças divididas de ordem 4'); 
disp('              f^(4)(zi) = 4! * f[xi, xi+1, xi+2, xi+3, xi+4]');
disp('                                   xi < zi < xi+4');
disp('    ');
disp('Para determinar uma estimativa de f^(4)(zi) no intervalo ]5, 9.5[');
disp('podemos usar a diferença dividida f[5.00 6.50 8.00 9.50 10.00]');
disp(' Existe 5< zi < 10: f^(4)(zi) = 4! * f[5.00 6.50 8.00 9.50 10.00]');

format short;
x = [5.00 6.50 8.00 9.50 10.00]
y = [0.126 0.113 0.104 0.097 0.092]
format long;
[c, tab] = difdivcoef(x, y);
absdf4 = abs(tab(1, 4)) * factorial(4)

disp('Estimativa do erro de truncatura usando a regra de 3/8 composta');

e3_8 = (3 * h3_8^5 * absdf4)  / 80

disp('               ');
disp('Calculando estimativa do erro de truncatura para a regra dos trapezios em [9.5, 10]');
disp('               ');
disp('O erro de truncatura, em valor absoluto, é dado pela fórmula:');
disp('|et| = (b-a)^3/12 |f^(2)(zi)|, 9.5 < zi < 10');
disp('Como não conhecemos a função f(x), podemos usar as diferenças divididas de ordem 2'); 
disp('         f^(2)(zi) = 2! * f[xi, xi+1, xi+2], xi < zi < xi+2');
disp('                                  xi < zi < xi+2'); 
disp('    ');
disp('Para determinar uma estimativa de f^(4)(zi) no intervalo ]9.5, 10[');
disp('podemos usar a diferença dividida f[8.00 9.50 10.00]');
disp(' Existe 8 < zi < 10 : f^(2)(zi) = 2! * f[8.00 9.50 10.00]');
disp('                     ');

format short;
x = [8.00 9.50 10.00]
y = [0.104 0.097 0.092]
format long;
[c, tab] = difdivcoef(x, y);

absdf2 = abs(tab(1, 2)) * factorial(2);

disp('Estimativa do erro de truncatura usando a regra dos Trapezios: ');
    
eT = ((x(3)-x(2))^3 * absdf2)  / 12

disp('     ');

e = eSC + e3_8 + eT;

disp('-----------------------------------------------------------------------');
disp(['Estimativa total do erro de truncatura: ', num2str(e, 14)]);
disp('-----------------------------------------------------------------------');