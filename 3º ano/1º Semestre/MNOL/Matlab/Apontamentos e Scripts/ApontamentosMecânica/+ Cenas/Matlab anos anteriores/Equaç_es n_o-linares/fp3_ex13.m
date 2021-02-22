
% ---------------------------------------------------------------------------
% Folha Pratica n� 3, Exercicio 13 (Metodo de Newton) 
%--------------------------------------------------------------------------
% Dada a equa��o f(x)=cos(x)-x/2 e um intervalo [a,b]
% separa graficamente as ra�zes e logo aproxima a �nica ra�z encontrada
% usando o metodo de Newton-Raphson a partir de x0=1 con # m�ximo de 
% itera��es igual a 6
%  Gladys Castillo, U.A., 2009
%--------------------------------------------------------------------------
echo off all;
format long;

disp('Determinar as raizes de f(x)=cos(x)-x/2=0 � equivalente a determinar');  
disp('as abcissas do pontos que intersectam y1=cos(x) e y2=x/2')
disp('Prima uma tecla para mostrar o gr�fico das fun��es no intervalo (-2pi, 2pi)');
disp('Espere... est� a ser processado...')
pause;

a= -2* pi;
b= 2* pi;

% 1�. Determina os pontos (x,y1), (x,y2) para construir as fun��es y1=cos(x) e y2=x/2

x=a:0.01:b;  % 
y1= cos(x);  % avalia a fun��o y1=cos(x)
y2 = x/2;    % avalia a fun��o y2=x/2

% 2�. Determina uma raiz em [a,b] para localiz�-la no grafico

% Aqui n�o � poss�vel utilizar a fun�ao fzero porque f(a)xf(b)>0. 
% Aproximar a raiz utilizando uma aproxima�ao do metodo de Newton
 
x1=newton1('f13',1, 1e-10, 1e-10, 20);                                           
r=double(x1(length(x1)));
y1r=cos(r); % avalia numa das fun�oes (cos(x)) para poder desenhar ponto
            % de intersec��o

% 3�. Construi o gr�fico das fun��es f1=cos(x) e f2=x/2 e os seus pontos 
%     de interesec��o 

figure(1);		  
clf;		      	
hold on;	      
whitebg('w');
title('Raizes da equa��o f(x)=cos(x)-x/2=0 no intervalo [-2pi, 2pi]');
xlabel('x');						
ylabel('y');
grid;
c=min(y2);
d=max(y2);
axis([a b c d]);    %  define os eixos de coordenadas
plot(x,y1,'r',x,y2,'g',r,y1r,'ob', r, 0, 'or'); % desenha as fun��es e a raiz 
legend('g(x)=cos(x)', 'h(x)=x/2', 'ponto intersec��o','raiz', 4);
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
hold off;              % fim desenho do gr�fico

% 4�. Construir o gr�fico da fun�ao F(x)=(cos(x)-x/2)^2  para localizar
%      graficamente as raizes de F(x)=0
disp('Prima uma tecla para mostrar o gr�fico da fun��o F(x)=(cos(x)-x/2)^2');
disp('no intervalo (-2pi, 2pi)'); 
pause;


a=-pi/2;
b=pi/2;
x=a:0.01:b;
y=feval('f13',x);
figure(2);		  % visualiza a janela de gr�ficos que corresponde � figura 2
clf;		          % limpa a figura 2	
hold on;	     
whitebg('w');
title('Grafico da fun��o F(x)=(cos(x)-x/2)^2 no intervalo [-pi/2, pi/2]');
xlabel('x');						
ylabel('y');
grid;
c=min(y);
d=max(y);
axis([a b c d]);	      % define os eixos de coordenadas
plot(r,0,'ob');           % desenha o zero
legend(['�nica raiz de F(x)=0']);
plot(x,y,'r');           % desenha a fun��o 
plot([a b],[0 0],'b',[0 0],[c d],'b' );      % desenha os eixos de coordenadas
hold off;            % fim desenho do gr�fico

% b). Executar o m�todo de Newton para aproximar a raiz de F(x)=0 com xo=pi/2 e 6 itera��es

disp('Prima uma tecla para executar o m�todo de Newton para aproximar o zero de');
disp('F(x)=(cos(x)-x/2)^2 a partir da solu��o inicial x0=pi/2 com 6 itera��es:');
pause;

x= newton1('f13', pi/2, 0, 0, 6);
r = x(length(x));

disp(['A aproxima��o da raiz encontrada pelo m�todo de Newton �: ', num2str(r,14)]);

% c). Executar o metodo de Newton para aproximar a raiz de f(x)=0 com xo=pi/2 e 6 itera��es
disp('                                                 ');
disp('Prima uma tecla para executar o m�todo de Newton para aproximar o zero de');
disp('f(x)=(cos(x)-x/2) a partir da solu��o inicial x0=pi/2 com 6 itera�oes:');
pause;

x= newton1('f13_c', pi/2, 0, 0, 6); 
r = x(length(x));

disp(['A aproxima��o da raiz encontrada pelo m�todo de Newton c �: ', num2str(r,14)]);

%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------





