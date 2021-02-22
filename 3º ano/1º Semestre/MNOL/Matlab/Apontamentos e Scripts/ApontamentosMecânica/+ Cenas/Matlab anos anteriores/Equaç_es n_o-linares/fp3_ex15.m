function fp3_ex15
% ---------------------------------------------------------------------------
% Folha Pratica n� 3, Exercicio 16 (Metodo de Newton Generalizado) 
%--------------------------------------------------------------------------
% a) Localiza graficamente as duas solu��es  do sistema de equa��es  nao lineares
%                      x^2 -y - 0.2 = 0
%                      y^2 -x - 0.3 = 0
% b) Resolver pelo m�todo de Newton generalizado
%  Para executar chamar:
%   fp3_ex16
%--------------------------------------------------------------------------
disp('Determinar as solu��es do sistema de equa��es  n�o lineares'); 
disp('                   x^2 -y - 0.2 = 0                        ');
disp('                   y^2 -x - 0.3 = 0                        '); 
disp('� equivalente a determinar os pontos que intersectam as dois par�bolas');  
disp('Prima uma tecla para mostrar o gr�fico das fun��es e os seus pontos de intersec��o') 
disp(['no intervalo [-2*pi,2*pi]']);
pause;

% 1�. Construi o gr�fico das par�bolas

figure(1);		      
clf;		      	
hold on;	     
whitebg('w');
axis([-4 4 -3 7]);          
ezplot('x^2-y-0.2');         %  desenha a primeira par�bola no plano
ezplot('y^2-x-0.3');         %  desenha a segunda par�bola no plano
grid on
%plot([-4 4],[0 0],'r',[0 0],[-3 7],'r' );  % os eixos de coordenadas
title(['Graficos de y = x^2 - 0.2', ' e  x= y^2 - 0.3']);
hold off;                     % fim desenho do gr�fico

% 2. Determina o Jacobiana J(x,y) utilizando computa��o simb�lica

syms x;
syms y;
disp('A matriz Jacobiana de este sistema de equa��es e:')
jacobian([x^2-y-0.2; y^2-x-0.3], [x,y])

% 3. Resolver pelo m�todo de Newton generalizado

disp('Existem dois pontos de intersec�ao das par�bolas');
disp('                ');
disp('Prima uma tecla para determinar uma aproxima��o para o primeiro zero');
disp('usando o m�todo de Newton Generalizado com aproxima��o inicial:');
Xa=[ 0, 0]'
pause;
[X,iter,erroX,erroF] = newton2gen('f15',Xa, 1e-10, 0, 50);

disp(['A solu��o x= ', num2str(X(1),14), ' y= ', num2str(X(2),14), '  foi encontrada apos']);
disp([num2str(iter,0), ' itera��es com ||F(X^(k))||_inf = ', num2str(erroF)]); 

disp('                ');
disp('Prima uma tecla para determinar uma aproxima��o para o segundo zero');
disp('usando o metodo de Newton Generalizado com aproxima��o inicial:');
Xb=[ 1.5, 1.5]'
pause;
[X,iter,erroX,erroF] = newton2gen('f15',Xb, 1e-10, 0, 50);

disp(['A solu��o x= ', num2str(X(1),14), ' y= ', num2str(X(2),14), ' foi encontrada apos']);
disp([num2str(iter,0), ' itera��es com ||F(X^(k))||_inf = ', num2str(erroF)]); 

% 4. Aproximando a partir de X0=[ 0.5, 0.5]
disp('                ');
disp('Prima uma tecla para determinar agora uma aproxima��o para o segundo zero');
disp('usando o metodo de Newton Generalizado com aproxima��o inicial:');
Xb=[ 0.5, 0.5]'
pause;
[F, JF]=f15(Xb)
d = det(JF);
disp(['O determinante da Jacobiana =', num2str(d, 0)]);
disp('Isto significa que a Jacobiana nao e invert�vel e o m�todo de Newton generalizado');
disp('n�o pode ser usado. Ao executar o m�todo da erro');

[X,iter,erroX,erroF] = newton2gen('f15',Xb, 1e-10, 0, 50);

%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------

