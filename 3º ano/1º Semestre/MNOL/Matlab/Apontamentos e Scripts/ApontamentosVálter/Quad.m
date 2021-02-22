% Este script também funciona para quadl

%Intervalo [i1,i2]
i1 = 1;
i2 = 2;
tol = 1.e-20;
% sem tolerancia de erro: 
% quad('QuadFunction',i1,i2);

% com tolerancia de erro:
% quad('QuadFunction',i1,i2,tol);

% com tolerancia de erro e também a mostrar o nº total de cálculos:
[z,nf]=quad('QuadFunction',i1,i2,tol)

% quadl('QuadFunction',i1,i2) , se quisermos quadl.
