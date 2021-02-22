% -----------------------------------------------------------------
%   FP4 - Exerc. 14
% Dado os seguintes valores:
%             x | -2   -1.5  -1  -0.5    0   0.5   1   1.5   2
%             y |  0     0    0   0.87   1   0.87  0   0     0
%  Ajuste os pontos tabelados usando polinomios interpoladores de Newton
%  de grau 4, 6 e 8, e em seguida determine um spline cubico natural
%  Comparar graficamente os polinomios obtidos pelos dois processos.
%  ------------------------------------------------------------------
format short;

% 1º. Determinar os polinomios de Newton

 disp('1º. Determinar o polinomio interpolador de Newton para n=4: ');
   
 disp('5 nós de interpolação: ');
 X = [-2, -1, 0, 1, 2]

 disp('Valores nodais: ');
 Y = [0,  0, 1, 0, 0]   
    
 x = linspace(-2,2)
 y = newtondifdiv(x,X,Y);
 
 figure(1);
 clf;
 subplot(2,2,1);
 hold on;
 whitebg('w');
 axis([-2, 2, -2, 1.5]);
 plot(x, y,'-b', X,Y,'or');
 plot([-2 2],[0 0],'k',[0 0],[-2 1.5],'k' );      % desenha os eixos de coordenadas
 xlabel('x');
 ylabel('y');
 title('Polinomio interpolador de grau 4');
 grid on;
 hold off;
 
 disp('2º. Determinar o polinomio interpolador de Newton para n=6: ');
 
 disp('7 nós de interpolação: ');
 X = [-2   -1  -0.5    0   0.5   1   2]
 
 disp('Valores nodais: ');
 
 Y = [0    0   0.87   1   0.87   0    0]

 y = newtondifdiv(x,X,Y);
  
 subplot(2,2,2);
 hold on;
 whitebg('w');
 axis([-2, 2, -2, 1.5]);
 plot(x, y,'-b', X,Y,'or');
 plot([-2 2],[0 0],'k',[0 0],[-2 1.5],'k' );      % desenha os eixos de coordenadas
 xlabel('x');
 ylabel('y');
 title('Polinomio interpolador de grau 6');
 grid on;
 hold off;
 
 disp('3º. Determinar o polinomio interpolador de Newton para n=8: ');
 
 disp('9 nós de interpolação: ');
 X = [-2   -1.5  -1  -0.5    0   0.5   1   1.5   2]
   
 disp('Valores nodais: ');
 
 Y = [ 0     0    0   0.87   1   0.87  0   0     0 ]
   
 y = newtondifdiv(x,X,Y);
 
 subplot(2,2,3);
 hold on;
 whitebg('w');
 axis([-2, 2, -1, 1.5]);
 plot(x, y,'-b', X,Y,'or');
 plot([-2 2],[0 0],'k',[0 0],[-2 1.5],'k' );      % desenha os eixos de coordenadas
 xlabel('x');
 ylabel('y');
 title('Polinomio interpolador de grau 8');
 grid on;
 hold off;
 

 disp('3º. Determinar o spline cubico natural usando todos os nós de interpolação');
 disp('Prima uma tecla para continuar');
 pause;
 
% Determinar a matriz dos coeficientes do spline cubico natural
%   Sk(x) = dk(x-xk)^3 + ck(x-xk)^2 + bk(x-xk) + yk, So"(xo)=So"(x4)=0
% usando a funçao CSAPE do Matlab');

 disp('A matriz dos coeficientes do spline cubico natural:');

coefs = splinecub(X,Y,2) % retorna a matriz dos coeficientes 
SC=mkpp(X,coefs);
x=linspace(-2,2); % usando mkpp e ppval podemos facilmente construir o gráfico dum spline 
y=ppval(SC,x);  

% 2º. Construir o gráfico do spline S(x)
subplot(2,2,4);
hold on;
whitebg('w');
axis([-2, 2, -1, 1.5]);
plot([-2 2],[0 0],'k',[0 0],[-2 1.5],'k' );      % desenha os eixos de coordenadas
plot(x,y, 'b', X,Y,'or');
xlabel('x');
ylabel('y');
title('Spline cubico interpolador natural');
grid;
hold off;

disp('-----------------------------------------------------------------------------------');
disp('Os polinomios interpoladores de Newton apresentam mais oscilaçoes, o que origina um erro');
disp('de interpolaçao mais elevado. Por outro lado, o spline cubico natural tem uma representaçao');
disp('grafica suave, o que sugere que aproxima melhor a funçao');
disp('-----------------------------------------------------------------------------------');







%------------------------------------------------------------------
%  Gladys Castillo, Antonio Pereira,  U.A, 2009
%------------------------------------------------------------------
