function fp3_ex3(a,b)
% ---------------------------------------------------------------------------
% Exercicio 3 Folha Pratica nº 3
% Verificar que as raizes de f(x)=x^3-5*x+1=0 estão perto de -2.35, 0.20 
%    e  2.10
% ------------------------------------------------------------------
% Parâmetros de entrada
%   a,b    - um intervalo para os valores de x
% exemplo: fp3_ex3 (-2.5, 2.5)
% --------------------------------------------------------------------

echo off;
format long;

disp('Determinar as raízes de f(x)=x^3-5*x+1=0 é equivalente a determinar');  
disp('os pontos que intersectam y1=x^3 e y2=5*x-1')
disp('Prima uma tecla para mostrar o gráfico das funções e os seus pontos de intersecção') 
disp(['no intervalo (', num2str(a),', ', num2str(b),')']);
pause;

% determina os pontos (x,y1), (x,y2) para construir as funções y1=x^3 e y2=5*x-1

x=a:0.01:b;      % 
y1 = x.^3;       % avalia a função y1=x^3
y2 = 5*x-1;       % avalia a função y2=5*x-1

% construi o gráfico das funções f1=x^3 e f2=5*x-1 e os seus pontos de interesecção 

figure(1);		  % visualiza a janela de gráficos que corresponde à figura 1
clf;		      % limpa a figura 1	
hold on;	      % todos os comandos gráficos a continuação são executados num mesmo gráfico
whitebg('w');
title(['Raizes da equação x^3-5*x+1=0 no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('y');
grid;
c=min(y2);
d=max(y1);
axis([a b c d]);	              % define os eixos de coordenadas
plot(x,y1,'r',x,y2,'g');           % desenha as funções 
legend('y1=x^3', 'y2=5*x-1');
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
% desenha as raizes no grafico
r1 = fzero(inline('x^3-5*x+1'),[-2.5,-2.0]); % determina a 1ª raiz de f(x) perto de -2.35
r2 = fzero(inline('x^3-5*x+1'),[0,0.5]);     % determina a 2ª raiz de f(x) perto de 0.20
r3 = fzero(inline('x^3-5*x+1'),[2,2.5]);     % determina a 3ª raiz de f(x) perto de 2.10
r = [ r1 r2 r3 ];
fr= 5*r -1 ;              % avalia numa das funçoes 
plot(r,fr,'ob');         
hold off;                % fim desenho do gráfico


% determina os pontos (x,y) para construir o grafico da funçao f(x)==x^3-5*x+1
x = a:0.01:b;     % 
y = x.^3-5*x+1;   % avalia a função f(x)=x^3-5*x+1=0 

disp('Prima uma tecla para mostrar o gráfico da função f(x)==x^3-5*x+1');
disp(['no intervalo (', num2str(a),', ', num2str(b),')']);
pause;

figure(2);		  % visualiza a janela de gráficos que corresponde à figura 2
clf;		      % limpa a figura 	
hold on;	      % todos os comandos gráficos a continuação são executados num mesmo gráfico
whitebg('w');
title(['Grafico da função f(x)=x^3-5*x+1 no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('y');
grid;
c=min(y);
d=max(y);
axis([a b c d]);	     % define os eixos de coordenadas
plot([a b],[0 0],'b',[0 0],[c d],'b' );  % desenha os eixos de coordenadas
plot(x,y,'r');           % desenha a funçao 

fr = zeros(3,1);
plot(r,fr,'ob');         % desenha as raizes
hold off;                % fim desenho do gráfico

disp('       ');
disp('Prima uma tecla para aproximar as raíz perto de -2.35 usando o método da bissecção:');
pause;
disp('Para r1 in I1=[-2.5, -2] (a primeira derivada de f(x) é sempre > 0):');

y1 = f3(-2.5);
y2 = f3(-2);
if (y1 * y2 < 0)
  disp('Como f(a).f(b) < 0 podemos aplicar o método da bissecção');
  [c,yc,erromax] = bissec('f3', -2.5,-2,10^-5,20);
  r1_aprox = c(length(c));
  e1 = erromax(length(c));
  disp(['r1_aprox= ', num2str(r1_aprox, 14), ' com | e(k) | =  ', num2str(e1, 14)]);
end  

disp('        ');
disp('Prima uma tecla para aproximar as raíz perto de 0.20 usando o metodo da bissecção:');
pause;
disp('Para r2 in I2=[0, 0.5] (a primeira derivada de f(x) é sempre < 0):');
y1 = f3(0);
y2 = f3(0.5);
if (y1 * y2 < 0)
  disp('Como f(a).f(b) < 0 podemos aplicar o método da bissecção');
  [c,yc,erromax] = bissec('f3', 0, 0.5,10^-5,20);
  r2_aprox = c(length(c));
  e2 = erromax(length(c));
  disp(['r2_aprox= ', num2str(r2_aprox, 14), ' com | e(k) | =  ', num2str(e2, 14)]);
end   

disp('           ');
disp('Prima uma tecla para aproximar as raíz perto de 2.10 usando o metodo da bissecção:');
pause;
disp('Para r3 in I3=[2, 2.2] (a primeira derivada de f(x) é sempre > 0):');
y1 = f3(2);
y2 = f3(2.5);
if (y1 * y2 < 0)
  disp('Como f(a).f(b) < 0 podemos aplicar o método da bissecção');
  [c, yc, erromax] = bissec('f3', 2,2.2,10^-5,20)
  r3_aprox = c(length(c));
  e3 = erromax(length(c));
  disp(['r3_aprox = ', num2str(r3_aprox, 14), ' com | e(k) | = ', num2str(e2, 14)]);
end 

disp('------------------------------------------------------------------------------');
disp(['As três raízes da equação x^3-5*x+1=0 no intervalo [', num2str(a), ', ', num2str(b), '] são:']);
disp(['r1 =', num2str(r(1),14), ' r2 =', num2str(r(2),14), ' r3 =', num2str(r(3),14)]);
disp(['As três raízes aproximadas pelo método da bissecção são:']);
disp(['r1_aprox =', num2str(r1_aprox,14), ' r2_aprox =', num2str(r2_aprox,14), ' r3_aprox =', num2str(r3_aprox,14)]);


%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------









