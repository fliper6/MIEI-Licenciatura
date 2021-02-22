%  Exemplo de métodos de integração 


x = linspace(-1,1.5);
y = exp(-1*x.^2);
figure(1);clf;
title('Aproximação do integral da função f(x)=exp(-x^2) no intervalo [0,1] pelo método do trapézio');
hold on;
axis([-1 1.5 0 1.1])
plot(x,y,'b');
plot([0 1],[1 exp(-1)],'ob');

disp('Prima uma tecla para desenhar o polinomio de grau 1 que interpola os dois pontos assinalados');
disp('e que aproxima a função dada em [0,1]');
pause;
plot([0,1], [1,exp(-1)], 'r'); 

disp('Prima uma tecla para desenhar a área do trapezio que aproxima o'); 
disp('integral de f(x)=exp(-x^2)no intervalo [0,1]');
pause;

plot([0 0],[1 0],'r', [1 1],[exp(-1) 0],'r',[0,1], [1,exp(-1)], 'r', [0, 1],[0 0],'r'); 

% sombrar area do trapezio
x1 = linspace(0,1,100);
y1=interp1([0 1],[1 exp(-1)], x1, 'linear');
for i=1:100
  plot([x1(i) x1(i)], [0 y1(i)], ':r');  
end   

hold off;

% Figura para o metodo de Simpson
figure(2);clf;
title('Aproximação do integral da função f(x)=exp(-x^2) no intervalo [0,1] pelo método de Simpson');
hold on;
axis([-1 1.5 0 1.1]);
plot(x,y,'b');

X=[0 0.5 1];  % nos
Y=exp(-1*X.^2); % valores nodais
plot(X, Y, 'ob'); %gráfico com os tres nos

disp('Prima uma tecla para desenhar o polinomio de grau 2 que interpola os tres pontos assinalados');
disp('e que aproxima a função f(x)=exp(-x^2) em [0,1]');
pause;
p=newton(X, Y);
x1=linspace(0,1);
y1=polyval(p,x1);
plot(x1,y1,'r');

disp('Prima uma tecla para desenhar a área do trapezio que aproxima o'); 
disp('integral de f(x)=exp(-x^2)no intervalo [0,1]');
pause;

plot([0 0],[1 0],'r', [1 1],[exp(-1) 0],'r', [0, 1],[0 0],'r'); 

% sombrar area 
for i=1:100
  plot([x1(i) x1(i)], [0 y1(i)], ':r');  
end   

hold off;

