% 1º. Determinar os pontos (x,y1), (x,y2) para construir
%     o gráfico das funções y1=exp(-x) e y2=sin(7x)

  a=0; b=1;
  x = linspace(a, b);  
 y1 = exp(-x);   % avaliar a função y1=exp(x)
 y2 = sin(7*x);  % avaliar a função y2=sin(7x)

% 2º. Construir os gráficos de g(x)= exp(-x) e h(x)=sin(7x)

figure(1);	 % abre a janela de gráficos nº1
clf;		      % limpa a janela	
hold on;	 % executa todos os comandos gráficos na mesma janela
whitebg('w');
grid on;

plot(x, y1, 'r', x, y2, 'g') % desenha os gráficos
 
 % adicionar no gráfico título, legenda, etc. 
 
title('Raiz mais próxima de 1 da equação f(x)=exp(-x)-sin(7*x)=0 no intervalo [0,1]');
xlabel('x');						
ylabel('y');
legend('g(x)=exp(-x)', 'h(x)=sin(7*x)');
plot([a b],[0 0],'b',[0 0],[min(y2) max(y1)],'b' );  % eixos 

% podemos adicionar a raiz mais próxima de 1 e o ponto de 
% intersecção correspondente se determinamos a raiz com a
% função fzero no intervalo [0.9, 1]

 r  =fzero('exp(-x)-sin(7*x)',[0.9, 1]);
 yr =exp(-r); % para determinar y(r) é suficiente avaliar numa das funções g ou h
 plot(r,yr,'ob', r,0,'or'); % ponto de intersecção e raiz
 
 hold off;              % fim desenho do gráfico
