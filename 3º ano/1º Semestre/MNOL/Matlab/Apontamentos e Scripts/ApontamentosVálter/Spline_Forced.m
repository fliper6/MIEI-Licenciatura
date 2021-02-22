% Semelhante à completa, mas não se removem pontos, apenas se adicionam as
% derivadas nas pontas: 
x=[0 2 3 5 8 12];
y=[0 15 13 25 28 42];
% forçar a curvatura nula nos extremos "[0 y 0]"
pp=spline(x,[0 y 0]);
pp.coefs
% ans =
% -3.2593 10.2685 0 0
% 5.3240 -9.2870 1.9630 15.0000
% -1.6828 6.6850 -0.6390 13.0000
% 0.5919 -3.4116 5.9079 25.0000
% -0.3488 1.9154 1.4192 28.0000

%construção dos 5 segmentos
% S1(x) = -3.2593*(x-0)^3 + 10.2685*(x-0)^2
% S2(x) = 5.3240*(x-2)^3 -9.2870*(x-2)^2 + 1.9630*(x-2) + 15.0000
% S3(x) = -1.6828*(x-3)^3 + 6.6850*(x-3)^2 -0.6390*(x-3) + 13.0000
% S4(x) = 0.5919*(x-5)^3 -3.4116*(x-5)^2 + 5.9079*(x-5) + 25.0000
% S5(x) = -0.3488*(x-8)^3 + 1.9154*(x-8)^2 + 1.4192*(x-8) + 28.0000

% estimação do valor em x=4
xx=spline(x,[0 y 0],4)

% tambem podemos fazer:  
%  xx=spline(x,[0 y 0], [0 1 2 3 4 5 6 7 8 12]) para ter interpolaçoes nos
%  pares de pontos da tabela.