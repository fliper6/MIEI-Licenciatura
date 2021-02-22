% Exemplo 2 (estudo comparativo bissec��o, secante e NR)
% Aproximar o �nico zero da fun��o f(x)=x^3- 2*exp(-x) no intervalo [0.5, 1]
% pelo m�todo da bissec��o
% Inclui uma simula��o animada com o m�todo da bissec��o

format long
a=0.5
b=1
f2=inline('x.^3-2*exp(-x)');

disp('----------------------------------------------------------------------------------------------------');
disp('Exemplo 2: m�todo da bissec��o');
disp('Verificar se existe um �nico zero de f(x)=x^3 - 2*exp(-x) no intervalo [0.5,1]');
disp('� equivalente a verificar se existe um �nico ponto de intersec��o entre g(x)=x^3 e h(x)= 2*exp(-x)')
disp('Prima uma tecla para mostrar o gr�fico das duas fun��es e os seus pontos de intersec��o') 
disp('no intervalo [0.5, 1]');
pause;

figure(1);
x=linspace(a,b);
g= x.^3;
h= 2* exp(-x);
clf;	
hold on;
whitebg('w');
% desenha os eixos de coordenadas
axis([a b -0.05 max(h)])  % define os eixos de coordenadas
title('Gr�fico de g(x)=x^3 e h(x)= 2exp(-x) em [0.5,1]');
xlabel('x');						
ylabel('y');
grid;
plot(x,g,'m', x,h, 'b')
legend('g(x)=x^3' ,'h(x)= 2exp(-x)', 'location', 'NorthEast')
plot([a b],[0 0],'b',[0 0],[-0.05, max(h)],'-b');  


disp('Foi verificado graficamente que a fun��o f(x) tem um s� zero no intervalo [0.5, 1]');
disp('Podemos determinar esse zero usando a fun��o fzero do Matlab');
pause;

r=fzero('f2',0.9)
plot([r r], [r^3 0], '-.r', r, r^3, 'ob') % ponto de intersec��o (r,r^3) e linha vertical que vai de (r,r^3) at� (r,0)
plot(r, 0, 'or')  % zero da fun��o 
text(r,0.01, '\leftarrow  zero = 0.9254',... 
    'HorizontalAlignment','left',...
    'FontSize',11) % coloco caption no zero

disp('Aproxime esse zero pelo m�todo da bissec��o, usando como crit�rio de paragem');
disp('o valor absoluto da diferen�a entre aproxima��es consecutivas de modo a que este');
disp('n�o exceda 0.5 x10^-3') 
pause;

[c,yc,erromax]=bissec('f2', 0.5,1, 0.5*10^-3, 200);

disp(['Valor do zero obtido pela fun��o fzero do MatLab.....:        r = ', num2str(r,14)]);

r_aprox= c(length(c));
disp(['Aproxima��o do zero obtido pelo m�todo da bissec��o...: r_aprox = ', num2str(r_aprox,14)]);



%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2010 
%--------------------------------------------------------------------------
