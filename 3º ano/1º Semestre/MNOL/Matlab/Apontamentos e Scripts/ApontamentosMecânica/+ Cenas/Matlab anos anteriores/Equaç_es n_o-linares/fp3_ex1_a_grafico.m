% 1�. Determinar os pontos (x,y1), (x,y2) para construir
%     o gr�fico das fun��es y1=exp(-x) e y2=sin(7x)

  a=0; b=1;
  x = linspace(a, b);  
 y1 = exp(-x);   % avaliar a fun��o y1=exp(x)
 y2 = sin(7*x);  % avaliar a fun��o y2=sin(7x)

% 2�. Construir os gr�ficos de g(x)= exp(-x) e h(x)=sin(7x)

figure(1);	 % abre a janela de gr�ficos n�1
clf;		      % limpa a janela	
hold on;	 % executa todos os comandos gr�ficos na mesma janela
whitebg('w');
grid on;

plot(x, y1, 'r', x, y2, 'g') % desenha os gr�ficos
 
 % adicionar no gr�fico t�tulo, legenda, etc. 
 
title('Raiz mais pr�xima de 1 da equa��o f(x)=exp(-x)-sin(7*x)=0 no intervalo [0,1]');
xlabel('x');						
ylabel('y');
legend('g(x)=exp(-x)', 'h(x)=sin(7*x)');
plot([a b],[0 0],'b',[0 0],[min(y2) max(y1)],'b' );  % eixos 

% podemos adicionar a raiz mais pr�xima de 1 e o ponto de 
% intersec��o correspondente se determinamos a raiz com a
% fun��o fzero no intervalo [0.9, 1]

 r  =fzero('exp(-x)-sin(7*x)',[0.9, 1]);
 yr =exp(-r); % para determinar y(r) � suficiente avaliar numa das fun��es g ou h
 plot(r,yr,'ob', r,0,'or'); % ponto de intersec��o e raiz
 
 hold off;              % fim desenho do gr�fico
