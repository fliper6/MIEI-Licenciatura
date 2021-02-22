function fp3_ex1_a(a,b)
% ---------------------------------------------------------------------------
% Exercicio 1 a) Folha Pratica n� 3
%--------------------------------------------------------------------------
% Esta fun�ao dada a equa��o f(x)=exp(x)-sin(7x)=0 e um intervalo [a,b]
% separa graficamente as menor ra�z positiva e a ra�z mais pr�xima de 1, 
% representando graficamente as curvas y=exp(x) e y=sin(7x)
%  Para executar chamar:
%   fp3_ex1_a(a,b)
% Par�metros de entrada
%   a,b  - intervalo [a,b]
%--------------------------------------------------------------------------

echo off;
format long;


disp('Determinar as raizes de f(x)=exp(-x)-sin(7x)=0 � equivalente a determinar');  
disp('as abcissas dos pontos que intersectam y1=exp(-x) e y2=sin(7x)')
disp('Prima uma tecla para mostrar o gr�fico das fun��es e os seus pontos de intersec��o') 
disp(['no intervalo (', num2str(a),', ', num2str(b),')']);
pause;

% 1�. Determina os pontos (x,y1), (x,y2) para construir as fun��es y1=exp(-x) e y2=sin(7x)

x= linspace(a,b);   % 
y1= exp(-x);  % avalia a fun��o y1=exp(x)
y2 = sin(7*x);  % avalia a fun��o y2=sin(7x)

% 2�. Determina a menor raiz positiva de f(x)

r=fzero('f1',[0, 0.2]); % determina uma raiz de f(x)=exp(-x)-sin(7*x) no intervalo [0.5,1]
y1r=exp(-r);            % avalia numa das fun�oes (na fun�ao exponencial)

% 3�. Construi o gr�fico das fun��es g(x)=exp(-x) e h(x)=sin(7x) e os seus pontos de interesec��o 

figure(1);		  % visualiza a janela de gr�ficos que corresponde � figura 1
clf;		      % limpa a figura 1	
hold on;	      % todos os comandos gr�ficos a continua��o s�o executados num mesmo gr�fico
whitebg('w');
title(['Menor raiz positiva da equa��o f(x)=exp(-x)-sin(7*x)=0 no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('y');
grid;
c=min(y2);
d=max(y1);
axis([a b c d]);	                          %  define os eixos de coordenadas
plot(x,y1,'r',x,y2,'g',r,y1r,'ob', r,0,'or');           % desenha as fun��es 
legend('g(x)=exp(-x)', 'h(x)=sin(7*x)', 'ponto intersec��o', 'menor raiz positiva');
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
hold off;              % fim desenho do gr�fico

% 3�. Construi o gr�fico da fun�ao f(x)=exp(-x)-sin(7x)=0 para localizar
% graficamente a raiz mais proxima de 1

disp('Prima uma tecla para mostrar o gr�fico da fun�ao f(x)=exp(-x)-sin(7x)=0');
disp(['no intervalo (', num2str(a),', ', num2str(b),')']);
pause;

r1=fzero('f1',[0.9, 1]); % determina a raiz mais proxima de 1

y=feval('f1',x);
figure(2);		  % visualiza a janela de gr�ficos que corresponde � figura 2
clf;		      % limpa a figura 1	
hold on;	      % todos os comandos gr�ficos a continua��o s�o executados num mesmo gr�fico
whitebg('w');
title(['Grafico da fun�ao f(x)=exp(-x)-sin(7*x) no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('y');
grid;
c=min(y);
d=max(y);
axis([a b c d]);	                         % define os eixos de coordenadas
plot(r,0,'ob',r1,0,'db');           % desenha a fun�ao 
legend('menor raiz positiva de f(x)=0', 'raiz mais pr�xima de 1');
plot(x,y,'r');           % desenha a fun�ao 
plot([a b],[0 0],'b',[0 0],[c d],'b' );      % desenha os eixos de coordenadas
hold off;            % fim desenho do gr�fico

%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------

