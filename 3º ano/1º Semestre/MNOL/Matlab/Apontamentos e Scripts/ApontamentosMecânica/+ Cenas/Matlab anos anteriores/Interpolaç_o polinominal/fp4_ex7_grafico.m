% Exemplo 7
% Localiza��o da ra�z da equa��o f(x)=exp(-x)-x em [0,1]


a=0
b=1
f=inline('exp(-x)-x');
x=linspace(a,b);
y =f(x);
r=fzero(f,[0.4, 0.6])


figure(1);	% visualiza a janela de gr�ficos que corresponde � figura 1
clf;		% limpa a figura 1	
hold on;	% todos os comandos gr�ficos s�o executados num mesmo gr�fico
% desenha os eixos de coordenadas
axis([a b min(y) max(y)])  % define os eixos de coordenadas
title('Gr�fico de f(x)=exp(-x)-x em [0,1]');
xlabel('x');						
ylabel('y');
grid;
plot(r,0, 'or')
legend(['zero= ', num2str(r, 6)], 'location', 'NorthEast')
plot(x,y,'m')
plot([a b],[0 0],'b',[0 0],[min(y), max(y)],'-b');  
grid on;


%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2010
%--------------------------------------------------------------------------

