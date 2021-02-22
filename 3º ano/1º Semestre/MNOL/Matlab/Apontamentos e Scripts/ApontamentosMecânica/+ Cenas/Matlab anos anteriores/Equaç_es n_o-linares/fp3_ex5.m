function fp3_ex5
% ---------------------------------------------------------------------------
% Folha Pratica n� 3, Exercicio 5 (Metodo de Newton) 
%--------------------------------------------------------------------------
% Esta fun�ao desenha o grafico da fun��o f(x)=cos(x^3) - log(x) 
% e localiza o seu menor zero positivo, que esta no intervalo [1, 1.2]
% Logo aproxima este zero usando o metodo de Newton-Raphson a partir de x0=1
% de tal forma que |f(x(k)| < 10e-13
%  Para executar chamar: fp3_ex5
%--------------------------------------------------------------------------
echo off;
format long;

% 1�. Construir o gr�fico da fun�ao f(x)=cos(x^3) - log(x) para localizar
% graficamente o menor zero positivo
a=0.1;
b=2;
disp('Prima uma tecla para mostrar o gr�fico da fun��o f(x)=cos(x^3) - log(x)');
disp(['no intervalo (', num2str(a),', ', num2str(b),')']);
pause;
x=a:0.01:b;
y=f5(x);

r=fzero('f5',[1, 1.2]); % determina o menor zero positivo

figure(1);		
clf;		      % limpa a figura 1	
hold on;	      % todos os comandos gr�ficos a continua��o s�o executados num mesmo gr�fico
whitebg('w');
title(['Grafico da fun��o f(x)=cos(x^3) - log(x) no intervalo [', num2str(a), ', ', num2str(b), ']']);
xlabel('x');						
ylabel('y');
grid;
c=min(y);
d=max(y);
axis([a b c d]);	      % define os eixos de coordenadas
plot(r,0,'ob');               % desenha o zero
legend(['r=',num2str(r,5), ' - menor zero positivo de f(x)']);
plot(x,y,'r');                % desenha a fun�ao 
plot([a b],[0 0],'b',[0 0],[c d],'b' );      % desenha os eixos de coordenadas
hold off;            % fim desenho do gr�fico

% 2�. Executar o metodo de Newton

disp('Prima uma tecla para executar o metodo de Newton a partir da')
disp('solu��o inicial x0=1 de tal forma que |f(x(k)|<10e-13');

newton1('f5', 1, 0, 1e-13, 20) 


%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------





