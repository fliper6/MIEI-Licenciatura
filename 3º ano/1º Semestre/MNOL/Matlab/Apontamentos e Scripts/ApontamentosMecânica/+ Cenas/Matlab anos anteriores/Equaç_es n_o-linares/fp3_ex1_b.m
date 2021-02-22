function fp3_ex1_b
% ---------------------------------------------------------------------------
% Exercicio 1 b) Folha Pratica n� 3
%--------------------------------------------------------------------------
% Esta fun�ao dada a equa��o exp(-x)-sin(7*x)=0 e um intervalo [a,b]
% determina a aproxima�ao da raiz mais proxima de 1 
% com erro absoluto inferior a 0.5*10^(-6)  usando o m�todo da bissec��o
%  Para executar chamar:
%    fp3_ex1_b
% Par�metros de entrada
%   a,b  - intervalo [a,b]

echo off;
a=0.9
b=1
eps= 0.5*10^(-6);
numit=10^4;   % um n�mero grande

disp('Prima uma tecla para aproximar a raiz mais pr�xima de 1 da equa��o exp(-x)-sin(7*x)=0');
disp(['pelo m�todo da bissec��o com intervalo inicial I0 = [0.9,1]']);
disp(['e com erro absoluto inferior a ', num2str(eps)]);
pause;

[rc ,yc,erromax]=bissec('f1', a, b, eps, numit); % determina uma raiz de f(x) pelo m�todo da bissec��o

r = fzero('f1',[a,b]);           % determina um zero de f(x)=exp(-x)-sin(7*x) no intervalo [a,b]
raprox = rc(length(rc));           % a solu�ao aproximada � a ultima componente do vector c(n)
erro= erromax(length(erromax));

disp(['A raiz mais pr�xima de 1 de f(x)=0 (usando fzero)..........   r = ',num2str(r,14)]);
disp(['Uma aproxima��o desta raiz  usando o m�todo da bissec��o....x18 = ',num2str(raprox,14)]);
disp(['O erro absoluto: |e18|=|r-x18|= ', num2str(abs(r-raprox),6) ' <= ' , num2str(erro,6), ' <= ' ,num2str(eps,6) ]);
disp(' ');
disp('-----------------------------------------------------------------------------------------------')
disp('Prima uma tecla para mostrar o gr�fico de f(x) e as 4 primeiras aproxima�oes da raiz de f(x)=0')
disp(['mais proxima de 1 obtidas pelo metodo da  bissec��o no intervalo (', num2str(a),', ', num2str(b),')']);
pause;

% 1�. Determina os pontos (x,y1), (x,y2) para construir as fun��es
% y1=exp(-x) e y2=sin(7x)em I0=[0.9, 1]

x=a:0.001:b;   % 
y= f1(x); % avalia a fun��o

% 2�. Construi o gr�fico da fun��o

figure(1);		  % visualiza a janela de gr�ficos que corresponde � figura 1
clf;		      % limpa a figura 1	
hold on;	      % todos os comandos gr�ficos a continua��o s�o executados num mesmo gr�fico
whitebg('w');
title(['Grafico da fun��o f(x)=exp(-x)-sin(7*x) no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('y');
grid;
c=min(y);
d=max(y);
axis([a b c d]);	            %  define os eixos de coordenadas
plot(r,0,'ok',rc(1),0,'or',rc(2), 0,'sg', rc(3), 0, 'vm', rc(4), 0, 'db');   % desenha as 4 primeiras aproxima��es fun��es 
legend(['raiz=' num2str(r, 8)], ['x1=' num2str(rc(1),8)], ['x2=' num2str(rc(2),8)], ['x3=' num2str(rc(3),8)],['x4=' num2str(rc(4),8)]);
plot(x,y,'r');  % desenha a fun�ao
for i=1:4      
  plot(rc(i), f1(rc(i)),'.k');
  plot([rc(i),rc(i)], [0, f1(rc(i))] ,'k:');
end  
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
hold off;                % fim desenho do gr�fico

%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------
