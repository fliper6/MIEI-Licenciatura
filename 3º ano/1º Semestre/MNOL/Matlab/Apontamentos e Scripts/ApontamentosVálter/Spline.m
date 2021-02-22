% Considere a tabela para construir a spline cúbica que interpola
% todos pontos. Estime o valor em x = 4
x=[0 2 3 5 8 12];
y=[0 15 13 25 28 42];

% definir o valor a estimar num x0
x0=4;
pp=spline(x,y);
pp.coefs; % este comando dá os coeficientes dos segmentos, em linha!
% ans =
% 2.0488 -13.4105 26.1260 0           s1(x) =  2.0488*(x-0)^3 + -13.4105*(x-0)^2 + 26.1260*(x-0) + 0
% 2.0488 -1.1179 -2.9309 15.0000      s2(x) = 2.0488*(x-2)^3 + -1.1179*(x-2)^2 + -2.9309*(x-2) + 15.0000
% -1.2591 5.0284 0.9797 13.0000       s3(x) = -1.2591*(x-3)^3 + 5.0284*(x-3)^2 + 0.9797*(x-3) + 13.0000
% 0.2883 -2.5263 5.9839 25.0000       s4(x) = 0.2883*(x-5)^3 + -2.5263 *(x-5)^2 + 5.9839*(x-5) + 25.0000
% 0.2883 0.0688 -1.3887 28.0000       s5(x) = 0.2883*(x-8)^3 + 0.0688*(x-8)^2 + -1.3887*(x-8) + 28.0000

% Ou seja, de forma geral escolhe-se a parte mais baixa do intervalo para
% cada spline!

% estimar s_i(x0)
xx=spline(x,y,x0)



