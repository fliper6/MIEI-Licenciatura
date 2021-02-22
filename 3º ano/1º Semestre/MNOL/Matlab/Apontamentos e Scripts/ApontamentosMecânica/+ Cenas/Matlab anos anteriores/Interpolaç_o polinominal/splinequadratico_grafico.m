% Exemplo de Spline Quadrático
% Considere a seguinte tabela:
%                                                     
%   xi 	 1	3	5
%   yi	-2	4	0
% Determine o spline quadrático S(x) que aproxima os pontos tabelados e satisfaz S’(1) =0

% O spline quadrático está formado por 
%         S0(x)= -2 + 3/2 (x-1)^2       ,1 <=x <= 3 
%         S1(x)=  4 + 6 (x-3)- 4(x-3)^2 ,3 <=x <= 5

% Construir o gráfico do spline S(x)
 figure(1);
 clf;
 hold on;
 axis([1, 5, -4, 8]);
 plot([1 5],[0 0],'k',[0 0],[-4 8],'k' );      % desenha os eixos de coordenadas

% Gráfico de S0(x) em [1,3]
 x = linspace(1, 3);
 y = polyval([3/2 0 -2],(x-1));
 plot(x,y, 'b');
 
% Gráfico de S1(x) em [3,5]
 x = linspace(3, 5);
 y = polyval([-4 6 4],(x-3));
 plot(x,y, 'm');
 
% Adicionar suporte
 plot([1 3 5],[-2 4	0],'or');
 
 xlabel('x');
 ylabel('y');
 title('Spline quadrático usando 3 pontos de suporte');
 grid on;
 hold off;