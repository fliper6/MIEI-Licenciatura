function fp3_ex15
% ---------------------------------------------------------------------------
% Folha Pratica nº 3, Exercicio 16 (Metodo de Newton Generalizado) 
%--------------------------------------------------------------------------
% a) Localiza graficamente as duas soluções  do sistema de equações  nao lineares
%                      x^2 -y - 0.2 = 0
%                      y^2 -x - 0.3 = 0
% b) Resolver pelo método de Newton generalizado
%  Para executar chamar:
%   fp3_ex16
%--------------------------------------------------------------------------
disp('Determinar as soluções do sistema de equações  não lineares'); 
disp('                   x^2 -y - 0.2 = 0                        ');
disp('                   y^2 -x - 0.3 = 0                        '); 
disp('é equivalente a determinar os pontos que intersectam as dois parábolas');  
disp('Prima uma tecla para mostrar o gráfico das funções e os seus pontos de intersecção') 
disp(['no intervalo [-2*pi,2*pi]']);
pause;

% 1º. Construi o gráfico das parábolas

figure(1);		      
clf;		      	
hold on;	     
whitebg('w');
axis([-4 4 -3 7]);          
ezplot('x^2-y-0.2');         %  desenha a primeira parâbola no plano
ezplot('y^2-x-0.3');         %  desenha a segunda parâbola no plano
grid on
%plot([-4 4],[0 0],'r',[0 0],[-3 7],'r' );  % os eixos de coordenadas
title(['Graficos de y = x^2 - 0.2', ' e  x= y^2 - 0.3']);
hold off;                     % fim desenho do gráfico

% 2. Determina o Jacobiana J(x,y) utilizando computação simbólica

syms x;
syms y;
disp('A matriz Jacobiana de este sistema de equações e:')
jacobian([x^2-y-0.2; y^2-x-0.3], [x,y])

% 3. Resolver pelo método de Newton generalizado

disp('Existem dois pontos de intersecçao das parábolas');
disp('                ');
disp('Prima uma tecla para determinar uma aproximação para o primeiro zero');
disp('usando o método de Newton Generalizado com aproximação inicial:');
Xa=[ 0, 0]'
pause;
[X,iter,erroX,erroF] = newton2gen('f15',Xa, 1e-10, 0, 50);

disp(['A solução x= ', num2str(X(1),14), ' y= ', num2str(X(2),14), '  foi encontrada apos']);
disp([num2str(iter,0), ' iterações com ||F(X^(k))||_inf = ', num2str(erroF)]); 

disp('                ');
disp('Prima uma tecla para determinar uma aproximação para o segundo zero');
disp('usando o metodo de Newton Generalizado com aproximação inicial:');
Xb=[ 1.5, 1.5]'
pause;
[X,iter,erroX,erroF] = newton2gen('f15',Xb, 1e-10, 0, 50);

disp(['A solução x= ', num2str(X(1),14), ' y= ', num2str(X(2),14), ' foi encontrada apos']);
disp([num2str(iter,0), ' iterações com ||F(X^(k))||_inf = ', num2str(erroF)]); 

% 4. Aproximando a partir de X0=[ 0.5, 0.5]
disp('                ');
disp('Prima uma tecla para determinar agora uma aproximação para o segundo zero');
disp('usando o metodo de Newton Generalizado com aproximação inicial:');
Xb=[ 0.5, 0.5]'
pause;
[F, JF]=f15(Xb)
d = det(JF);
disp(['O determinante da Jacobiana =', num2str(d, 0)]);
disp('Isto significa que a Jacobiana nao e invertível e o método de Newton generalizado');
disp('não pode ser usado. Ao executar o método da erro');

[X,iter,erroX,erroF] = newton2gen('f15',Xb, 1e-10, 0, 50);

%-----------------------------------------------------------------------
%    Gladys Castillo, U.Aveiro,  2009 
%--------------------------------------------------------------------------

