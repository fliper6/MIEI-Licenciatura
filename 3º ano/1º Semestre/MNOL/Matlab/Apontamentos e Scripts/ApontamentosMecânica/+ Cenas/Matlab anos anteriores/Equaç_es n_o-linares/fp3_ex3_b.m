% FP3_3b)
% Considerando x0=2.10, execute 10 iterações do método do ponto fixo usando
% a iteradora xk = g(xk-1), com g(x)=(5*x-1).^(1/3)para aproximar a única
% raiz da equação x3 = 5x^2 - 1 em [2, 2.25]

g=inline('(5*x-1).^(1/3)');
x=2.1;
for k=1:10
  x=g(x);
  display(['x(', num2str(k),')= ', num2str(x, 8)]);
end
display('Após 10 iterações a aproximação encontrada é');
x
  
