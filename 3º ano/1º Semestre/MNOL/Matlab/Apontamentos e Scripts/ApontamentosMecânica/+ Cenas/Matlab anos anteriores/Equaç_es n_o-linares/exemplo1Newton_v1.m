% Exemplo 1 Newton-Raphson 

% Partindo de x0=0.1, calcule duas aproximações do menor zero positivo da 
% função f(x) = x^3- 5x + 1  em [0, 0.5] pelo método de Newton-Raphson

format long;

x0=0.1
[y, dy]=f3(x0);

x1=x0-y/dy

[y, dy]=f3(x1);
x2=x1-y/dy
