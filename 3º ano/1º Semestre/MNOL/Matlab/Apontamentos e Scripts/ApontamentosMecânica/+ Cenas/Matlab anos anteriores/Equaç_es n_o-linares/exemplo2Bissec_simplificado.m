% Exemplo 2
% Estudo comparativo com métodos da Bissecção, Secante e Newton Raphson
% Considere a função f(x) = x3 - 2 e-x
% Neste programa apenas está implementado o método da bissecção

format long;

%Verificar se existe um único zero de f(x)=x^3 - 2*exp(-x) no intervalo
%[0.5,1]é equivalente a verificar se existe um único ponto de intersecção 
%entre g(x)=x^3 e h(x)= 2*exp(-x)

figure(1);    % abre uma nova janela gráfica	
x=linspace(0.5, 1);
g= x.^3;
h= 2* exp(-x);
clf;   %apaga tudo	
hold on;
grid;  
plot(x,g,'m', x,h, 'b');

disp('Valor do zero obtido pela função fzero do MatLab:');
r =fzero('f2',0.9)   % zero de f em [0.5,1]
plot(r, 0, 'or');    % desenha raíz no grafico da figure(1)

disp('Aproximar zero pelo método da bissecção');
disp('Critério de paragem: |x_k-x_k-1| < 0.5 x 10^-3'); 
[c,yc,erromax]=bissec('f2', 0.5,1, 0.5*10^-3, 200);
r_aprox= c(length(c))













%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------
