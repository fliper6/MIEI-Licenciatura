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
    
 x = -2:0.001:2;	     % defino os valores de x para desenhar o grafico de pn(x)
 y = newtondifdiv(x,X,Y);
 
 figure(1); clf;
 hold on;
 title('Polinomio interpolador de grau 4');
 plot(x, y,'-b', X,Y,'or');
 grid on;
  
 disp('2º. Determinar o polinomio interpolador de Newton para n=6: ');
 
 disp('7 nós de interpolação: ');
 X = [-2   -1  -0.5    0   0.5   1   2]
 
 disp('Valores nodais: ');
 
 Y = [0    0   0.87   1   0.87   0    0]

 y = newtondifdiv(x,X,Y);
  
 figure(2); clf;
 hold on;
 title('Polinomio interpolador de grau 6');
 grid on;
 plot(x, y,'-b', X,Y,'or');
 
 disp('3º. Determinar o polinomio interpolador de Newton para n=8: ');
 
 disp('9 nós de interpolação: ');
 X = [-2   -1.5  -1  -0.5    0   0.5   1   1.5   2]
   
 disp('Valores nodais: ');
 
 Y = [ 0     0    0   0.87   1   0.87  0   0     0 ]
   
 y = newtondifdiv(x,X,Y);
 
 figure(3); clf;
 hold on;
 grid on;
 title('Polinomio interpolador de grau 8');
 plot(x, y,'-b', X,Y,'or');
 
 
 disp('3º. Determinar o spline cubico natural usando todos os nós de interpolação');
 
% Determinar a matriz dos coeficientes do spline cubico natural
%   Sk(x) = dk(x-xk)^3 + ck(x-xk)^2 + bk(x-xk) + yk, So"(xo)=So"(x4)=0
% usando a funçao CSAPE do Matlab');

 disp('A matriz dos coeficientes do spline cubico natural:');
 coefs= splinecub(X,Y,2); % retorna a matriz dos coeficientes 
  
% 2º. Construir o gráfico do spline S(x)
  figure(4); clf;
  hold on;
  grid on;
  title('Spline cubico interpolador natural');
  for (i=1:length(X)-1)
   x=linspace(X(i),X(i+1)); 
   y= polyval(coefs(i,:),(x-X(i)));
   plot(x,y, 'b');
 end
 plot(X,Y,'or');


disp('-----------------------------------------------------------------------------------');
disp('Os polinomios interpoladores de Newton apresentam mais oscilaçoes, o que origina um erro');
disp('de interpolaçao mais elevado. Por outro lado, o spline cubico natural tem uma representaçao');
disp('grafica suave, o que sugere que aproxima melhor a funçao');
disp('-----------------------------------------------------------------------------------');







%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------
