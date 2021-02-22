% -----------------------------------------------------------------
%   FP4 - Exerc. 15
% Pretende-se aproximar em [-1,1] a fun��o de Runge
%             f(x)= 1/ 1 + 25 x^2
% a) Encontre polin�mios interpoladores de Newton usando 5 e 9 pontos tabelados
% b) Determine o spline c�bico natural usando 5 e 9 pontos e compare
% graficamente

%  ------------------------------------------------------------------
format short;
a=-1;
b=1; 

% 1�. Determinar os polinomios de Newton

 disp('1�. Determinar o polinomio interpolador de Newton usando 5 n�s equidistantes');
   
 disp('suporte com 5 pontos');
 n = 4; 
 h = (b-a)/n;
 X = a:h:b
 Y = 1./(1 + 25*X.^2) 
   
 x = linspace(-1,1);      % defino os valores de x para desenhar o grafico de pn(x)
 y = newtondifdiv(x,X,Y);
 
 subplot(2,2,1);
 hold on;
 whitebg('w');
 axis([-1, 1, -1, 1]);
 plot(x, y,'-b', X,Y,'or');
 plot([-1 1],[0 0],'k',[0 0],[-1 1],'k' );      % desenha os eixos de coordenadas
 xlabel('x');
 ylabel('y');
 title('Polinomio interpolador usando 5 pontos');
 grid on;
 hold off;
 
 disp('2�. Determinar o polinomio interpolador de Newton usando 9 n�s equidistantes');
 
 disp('suporte com 9 puntos');
 n =8; 
 h = (b-a)/n;
 X = a:h:b
 Y = 1./(1 + 25*X.^2)
 y = newtondifdiv(x,X,Y); % os valores x j� foram gerados
  
 subplot(2,2,2);
 hold on;
 whitebg('w');
 axis([-1, 1, -1, 1]);
 plot(x, y,'-b', X,Y,'or');
 plot([-1 1],[0 0],'k',[0 0], [-1, 1],'k' );      % desenha os eixos de coordenadas
 xlabel('x');
 ylabel('y');
 title('Polinomio interpolador usando 9 pontos');
 grid on;
 hold off;
 
 disp('3�. Determinar o spline cubico natural usando 5 n�s equidistantes');
 
 disp('suporte com 5 pontos');
 n = 4; 
 h = (b-a)/n;
 X = a:h:b
 Y = 1./(1 + 25*X.^2) 
   
 % Determinar a matriz dos coeficientes do spline cubico natural
 %   Sk(x) = dk(x-xk)^3 + ck(x-xk)^2 + bk(x-xk) + yk, So"(xo)=So"(x4)=0

 disp('A matriz dos coeficientes do spline cubico natural:');

 coefs = splinecub(X,Y,2) % retorna a matriz dos coeficientes 

 % 3�. Construir o gr�fico do spline S(x)
 subplot(2,2,3);
 hold on;
 whitebg('w');
 axis([-1, 1, -1, 1]);
 plot([-1 1],[0 0],'k',[0 0],[-1 1],'k' );      % desenha os eixos de coordenadas

 for (i=1:length(X)-1)
   x=linspace(X(i),X(i+1)); 
   y= polyval(coefs(i,:),(x-X(i)));
   plot(x,y, 'b');
 end

 plot(X,Y,'or');
 xlabel('x');
 ylabel('y');
 title('Spline cubico interpolador natural usando 5 pontos');
 grid on;
 hold off;
 
 
 disp('4�. Determinar o spline cubico natural usando 9 n�s equidistantes');
 
 disp('suporte com 9 pontos');
 n = 8; 
 h = (b-a)/n;
 X = a:h:b
 Y = 1./(1 + 25*X.^2) 
 
 % Determinar a matriz dos coeficientes do spline cubico natural
 %   Sk(x) = dk(x-xk)^3 + ck(x-xk)^2 + bk(x-xk) + yk, So"(xo)=So"(x4)=0

 disp('A matriz dos coeficientes do spline cubico natural:');
 coefs= splinecub(X,Y,2) % retorna a matriz dos coeficientes 


 % 4�. Construir o gr�fico do spline S(x)
 subplot(2,2,4);
 hold on;
 whitebg('w');
 axis([-1, 1, -1, 1]);
 plot([-1 1],[0 0],'k',[0 0],[-1 1],'k' );      % desenha os eixos de coordenadas

 for (i=1:length(X)-1)
   x=linspace(X(i),X(i+1)); 
   y= polyval(coefs(i,:),(x-X(i)));
   plot(x,y, 'b');
 end

 plot(X,Y,'or');
 xlabel('x');
 ylabel('y');
 title('Spline cubico interpolador natural usando 9 pontos');
 grid on;
 hold off;
 

disp('-----------------------------------------------------------------------------------');
disp('Os polinomios interpoladores de Newton apresentam mais oscila�oes, o que origina um erro');
disp('de interpola�ao mais elevado (conhecido como fen�mero de Runge).');
disp('Por outro lado, o spline cubico natural tem uma representa�ao');
disp('grafica suave, o que sugere que aproxima melhor a fun�ao');
disp('-----------------------------------------------------------------------------------');





%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------
