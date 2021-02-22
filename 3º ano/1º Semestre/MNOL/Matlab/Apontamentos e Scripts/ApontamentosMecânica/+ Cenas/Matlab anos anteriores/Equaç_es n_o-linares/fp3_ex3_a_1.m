function fp3_ex3_a_1(a, b)
% ---------------------------------------------------------------------------
% Exercicio 3 Folha Pratica nº 3
% a) Encontrar para cada raiz uma função de iteração g(x) que torne o metodo do
%    ponto fixo convergente
% --------------------------------------------------
%  Para executar chamar:
%   fp3_ex1_a_1(a,b)
% Parâmetros de entrada
%   a,b  - intervalo [a,b]
%  Esta função utiliza a função de iteração g(x)=(5*x-1)^(1/3) e a sua primeira
%  derivada definidas no ficheiro f3_it_1.m
%--------------------------------------------------------------------------


syms x; 
g = (5*x-1)^(1/3);
disp('Prima uma tecla para mostrar os gráficos da função de iteração g(x)')
pretty(g);
disp('e da primeira derivada de g(x):');
g1 = diff(g);
pretty(g1);
disp(['no intervalo I=[', num2str(a),', ', num2str(b),']']);


%1º. Obter os pontos (x,y) para g(x) e (x,y1) para g'(x)

x=a:0.01:b;
[y, y1] = f3_it_1(x);

%2º. Obter o ponto fixo para x=g(x)
r = fzero(inline('x^3-5*x+1'),[a,b]);
yr= f3_it_1(r);  

%2º. Construi os graficos

figure(3);		  % visualiza a janela de gráficos que corresponde à figura 1
clf;		      % limpa a figura 
subplot(1,2,1), plot(x,y,'r',r,0,'ob');                     % desenha g(x) 
hold on
title(['Função iteradora g(x) no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('g(x)');
grid;
c=min(y);
d=max(y);
axis([a b c d]);	                              % define os eixos de coordenadas
%legend('g(x) = (5*x-1)^(1/3)', ['ponto fixo: x= ', num2str(r,5)], 2);
plot([a r],[r r],'--b',[r r],[r min(y)],'--b' );  % desenha as linhas para assinalar o ponto fixo
plot([a b],[0 0],'b',[0 0],[c d],'b' );           % desenha os eixos de coordenadas
hold off

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
                               % desenha a funçao e a primeira derivada
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
hold off;                % fim desenho do gráfico

%----- Gladys Castillo, U.Aveiro,  2009 %----------------------------
