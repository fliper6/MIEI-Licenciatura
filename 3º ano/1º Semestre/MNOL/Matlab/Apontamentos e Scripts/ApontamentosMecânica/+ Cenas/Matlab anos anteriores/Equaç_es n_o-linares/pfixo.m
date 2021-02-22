function x = pfixo(f, g, x0, tol, kmax)

x=x0;
for k=1:kmax
  x=g(x);
  display(['x(', num2str(k),')= ', num2str(x,8)]);
  if (abs(f(x))< tol)
     break; % foi satisfeito o critério de paragem
   end
end
if (k==kmax & f(x)>=tol)
   disp('O ponto fixo não foi encontrado com a tolerância desejada.')
  else
   display('A aproximação encontrada é');
   x 
end
