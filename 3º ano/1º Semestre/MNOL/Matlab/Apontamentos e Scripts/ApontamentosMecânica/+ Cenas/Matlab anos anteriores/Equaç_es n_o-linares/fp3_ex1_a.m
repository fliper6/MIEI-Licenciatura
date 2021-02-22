function fp3_ex1_a(a,b)
% ---------------------------------------------------------------------------
% Exercicio 1 a) Folha Pratica nº 3
%--------------------------------------------------------------------------
% Esta funçao dada a equação f(x)=exp(x)-sin(7x)=0 e um intervalo [a,b]
% separa graficamente as menor raíz positiva e a raíz mais próxima de 1, 
% representando graficamente as curvas y=exp(x) e y=sin(7x)
%  Para executar chamar:
%   fp3_ex1_a(a,b)
% Parâmetros de entrada
%   a,b  - intervalo [a,b]
%--------------------------------------------------------------------------

echo off;
format long;


disp('Determinar as raizes de f(x)=exp(-x)-sin(7x)=0 é equivalente a determinar');  
disp('as abcissas dos pontos que intersectam y1=exp(-x) e y2=sin(7x)')
disp('Prima uma tecla para mostrar o gráfico das funções e os seus pontos de intersecção') 
disp(['no intervalo (', num2str(a),', ', num2str(b),')']);
pause;

% 1º. Determina os pontos (x,y1), (x,y2) para construir as funções y1=exp(-x) e y2=sin(7x)

x= linspace(a,b);   % 
y1= exp(-x);  % avalia a função y1=exp(x)
y2 = sin(7*x);  % avalia a função y2=sin(7x)

% 2º. Determina a menor raiz positiva de f(x)

r=fzero('f1',[0, 0.2]); % determina uma raiz de f(x)=exp(-x)-sin(7*x) no intervalo [0.5,1]
y1r=exp(-r);            % avalia numa das funçoes (na funçao exponencial)

% 3º. Construi o gráfico das funções g(x)=exp(-x) e h(x)=sin(7x) e os seus pontos de interesecção 

figure(1);		  % visualiza a janela de gráficos que corresponde à figura 1
clf;		      % limpa a figura 1	
hold on;	      % todos os comandos gráficos a continuação são executados num mesmo gráfico
whitebg('w');
title(['Menor raiz positiva da equação f(x)=exp(-x)-sin(7*x)=0 no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('y');
grid;
c=min(y2);
d=max(y1);
axis([a b c d]);	                          %  define os eixos de coordenadas
plot(x,y1,'r',x,y2,'g',r,y1r,'ob', r,0,'or');           % desenha as funções 
legend('g(x)=exp(-x)', 'h(x)=sin(7*x)', 'ponto intersecção', 'menor raiz positiva');
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
hold off;              % fim desenho do gráfico

% 3º. Construi o gráfico da funçao f(x)=exp(-x)-sin(7x)=0 para localizar
% graficamente a raiz mais proxima de 1

disp('Prima uma tecla para mostrar o gráfico da funçao f(x)=exp(-x)-sin(7x)=0');
disp(['no intervalo (', num2str(a),', ', num2str(b),')']);
pause;

r1=fzero('f1',[0.9, 1]); % determina a raiz mais proxima de 1

y=feval('f1',x);
figure(2);		  % visualiza a janela de gráficos que corresponde à figura 2
clf;		      % limpa a figura 1	
hold on;	      % todos os comandos gráficos a continuação são executados num mesmo gráfico
whitebg('w');
title(['Grafico da funçao f(x)=exp(-x)-sin(7*x) no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('y');
grid;
c=min(y);
d=max(y);
axis([a b c d]);	                         % define os eixos de coordenadas
plot(r,0,'ob',r1,0,'db');           % desenha a funçao 
legend('menor raiz positiva de f(x)=0', 'raiz mais próxima de 1');
plot(x,y,'r');           % desenha a funçao 
plot([a b],[0 0],'b',[0 0],[c d],'b' );      % desenha os eixos de coordenadas
hold off;            % fim desenho do gráfico

%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------

