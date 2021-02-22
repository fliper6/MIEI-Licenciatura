% Exemplo 2 (estudo comparativo bissecção, secante e NR)
% Aproximar o único zero da função f(x)=x^3- 2*exp(-x) no intervalo [0.5, 1]
% pelo método da bissecção
% Inclui uma simulação animada com o método da bissecção

format long
a=0.5
b=1
f2=inline('x.^3-2*exp(-x)');

disp('----------------------------------------------------------------------------------------------------');
disp('Exemplo 2: método da bissecção');
disp('Verificar se existe um único zero de f(x)=x^3 - 2*exp(-x) no intervalo [0.5,1]');
disp('é equivalente a verificar se existe um único ponto de intersecção entre g(x)=x^3 e h(x)= 2*exp(-x)')
disp('Prima uma tecla para mostrar o gráfico das duas funções e os seus pontos de intersecção') 
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
title('Gráfico de g(x)=x^3 e h(x)= 2exp(-x) em [0.5,1]');
xlabel('x');						
ylabel('y');
grid;
plot(x,g,'m', x,h, 'b')
legend('g(x)=x^3' ,'h(x)= 2exp(-x)', 'location', 'NorthEast')
plot([a b],[0 0],'b',[0 0],[-0.05, max(h)],'-b');  


disp('Foi verificado graficamente que a função f(x) tem um só zero no intervalo [0.5, 1]');
disp('Podemos determinar esse zero usando a função fzero do Matlab');
pause;

r=fzero('f2',0.9)
plot([r r], [r^3 0], '-.r', r, r^3, 'ob') % ponto de intersecção (r,r^3) e linha vertical que vai de (r,r^3) até (r,0)
plot(r, 0, 'or')  % zero da função 
text(r,0.01, '\leftarrow  zero = 0.9254',... 
    'HorizontalAlignment','left',...
    'FontSize',11) % coloco caption no zero

disp('Aproxime esse zero pelo método da bissecção, usando como critério de paragem');
disp('o valor absoluto da diferença entre aproximações consecutivas de modo a que este');
disp('não exceda 0.5 x10^-3') 
pause;

[c,yc,erromax]=bissec('f2', 0.5,1, 0.5*10^-3, 200);

disp(['Valor do zero obtido pela função fzero do MatLab.....:        r = ', num2str(r,14)]);

r_aprox= c(length(c));
disp(['Aproximação do zero obtido pelo método da bissecção...: r_aprox = ', num2str(r_aprox,14)]);



%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2010 
%--------------------------------------------------------------------------
