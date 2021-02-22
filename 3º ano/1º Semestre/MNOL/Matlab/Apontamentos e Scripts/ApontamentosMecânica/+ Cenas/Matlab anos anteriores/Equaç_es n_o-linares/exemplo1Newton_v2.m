% Exemplo 1 Newton-Raphson 

% Partindo de x0=0.1, calcule uma aproximação do menor zero positivo da 
% função f(x) = x^3- 5x + 1  em [0, 0.5] utilizando o método de Newton-Raphson
% com uma iteradora convergente e como critério de paragem |f(xk) | < 10-5.

% dados de entrada
f=inline('x.^3-5*x+1');
g=inline('(x.^3+1)/5');
x=0.1
tol=1e-5

% processo iterativo
for k=1:10
  x=g(x);
  display(['x(', num2str(k),')= ', num2str(x,8)]);
  if (abs(f(x))< tol)
     break; % foi satisfeito o critério de paragem
   end
end
display('A aproximação encontrada é');
x 

