
function Ig=quadgauss(f,a,b,n)

%=================================================
%Integração Numérica
%Quadratura de Gauss (até 5 pontos):
%Ig=c1*f(x1)+c2*f(x2)+c3*f(x3)+c4*f(x4)+c5*f(x5)
%
%-------------------------------------------------
%
%Entradas   - f função integranda entra como uma
%                      string 'f'
%           - a é o limite inferior de integração
%           - b é o limite superior de integração
%           - n é o número de pontos (n=2,3,4,5)
%Saída      - Ig é o valor aproximado do integral 
%                calculado com a regra de Gauss  
%                com n pontos
%=================================================

% t é a matriz com os nós de Gauss (1ªcoluna->n=2
%                                   2ªcoluna->n=3
%                                             ...)
t = [-0.5773502692  -0.7745966692  -0.8611363116  -0.9061798459;
      0.5773502692   0.0           -0.3399810436  -0.5384693101;
      0.0            0.7745966692   0.3399810436   0.0;
      0.0            0.0            0.8611363116   0.5384693101;
      0.0            0.0            0.0            0.9061798459];  
% c é a matriz com os pesos de Gauss(1ªcoluna->n=2
%                                    2ªcoluna->n=3
%                                              ...)
c = [1.0             0.5555555556   0.3478548451   0.2369268850;
     1.0             0.8888888889   0.6521451549   0.4786286705;
     0.0             0.5555555556   0.6521451549   0.5688888889;
     0.0             0.0            0.3478548451   0.4786286705;
     0.0             0.0            0.0            0.2369268850];
  
x(1:n) = 0.5*((b-a).*t(1:n,n-1)+ b + a);
y = feval(f,x);
cc(1 : n) = c(1 : n, n-1);
cd = cc';
Ig = y*cd*(b-a)/2;
 

%-----------------------------------------------------------------------------
% AJNeves (DMUA) - Novembro/2005 
%-----------------------------------------------------------------------------
