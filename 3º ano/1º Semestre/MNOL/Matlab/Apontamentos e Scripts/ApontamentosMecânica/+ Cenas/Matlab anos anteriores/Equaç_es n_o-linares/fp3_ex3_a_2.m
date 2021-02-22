function fp3_ex3_a_2(a, b)
% ---------------------------------------------------------------------------
% Exercicio 3 Folha Pratica nº 3
% a) Encontrar para cada raiz uma função de iteração g(x) que torne o metodo do
%    ponto fixo convergente
% --------------------------------------------------
%  Para executar chamar:
%   fp4_ex1_a_2(a,b)
%  exemplo: fp3_ex4_a_2(0, 0.5)
% Parâmetros de entrada
%   a,b  - intervalo [a,b]
%  Esta função utiliza a função de iteração g(x)= (x^3 + 1) /5 e a sua primeira
%  derivada definidas no ficheiro f3_it_2.m
%--------------------------------------------------------------------------

syms x; 
g = (x^3 + 1) /5;
disp('Prima uma tecla para mostrar os gráficos da função de iteração g(x)')
pretty(g);
disp('e da primeira derivada de g(x):');
g1 = diff(g);
pretty(g1);
disp(['no intervalo I=[', num2str(a),', ', num2str(b),']']);

%1º. Obter os pontos (x,y) para g(x) e (x,y1) para g'(x)

x=a:0.01:b;
[y, y1] = f3_it_2(x);

%3º. Obter o ponto fixo para x=g(x)
r = fzero(inline('x^3-5*x+1'),[a,b]);
yr= f3_it_2(r);  

%2º. Construi os graficos

figure(3);		
clf;		    
subplot(1,2,1), plot(x,y,'r',r,0,'ob'); % desenha g(x) 
hold on

title(['Função iteradora g(x) no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('g(x)');
grid;
c=min(y);
d=max(y);
axis([a b c d]);	                    % define os eixos de coordenadas
%legend('g(x) = (x^3 + 1) /5', 2);
plot([a r],[r r],'--b',[r r],[r min(y)],'--b' );  % desenha as linhas para assinalar o ponto fixo
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
hold off;                % fim desenho do gráfico

% desenho o grafico com a derivada de g(x)
subplot(1,2,2), plot(x,y1,'g');                     % desenha g(x) 
hold on
title(['Primeira derivada de g(x) no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('g`(x)');
grid;
c=min(y1);
d=max(y1);
axis([a b c d]);	           % define os eixos de coordenadas
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
hold off;                % fim desenho do gráfico

%----- Gladys Castillo, U.Aveiro,  2006 %----------------------------