% Exemplo 2
% Estudo comparativo com m�todos da Bissec��o, Secante e Newton Raphson
% Considere a fun��o f(x) = x3 - 2 e-x
% Neste programa apenas est� implementado o m�todo da bissec��o

format long;

%Verificar se existe um �nico zero de f(x)=x^3 - 2*exp(-x) no intervalo
%[0.5,1]� equivalente a verificar se existe um �nico ponto de intersec��o 
%entre g(x)=x^3 e h(x)= 2*exp(-x)

figure(1);    % abre uma nova janela gr�fica	
x=linspace(0.5, 1);
g= x.^3;
h= 2* exp(-x);
clf;   %apaga tudo	
hold on;
grid;  
plot(x,g,'m', x,h, 'b');

disp('Valor do zero obtido pela fun��o fzero do MatLab:');
r =fzero('f2',0.9)   % zero de f em [0.5,1]
plot(r, 0, 'or');    % desenha ra�z no grafico da figure(1)

disp('Aproximar zero pelo m�todo da bissec��o');
disp('Crit�rio de paragem: |x_k-x_k-1| < 0.5 x 10^-3'); 
[c,yc,erromax]=bissec('f2', 0.5,1, 0.5*10^-3, 200);
r_aprox= c(length(c))













%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------
