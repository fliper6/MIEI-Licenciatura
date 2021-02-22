[x,y]=ode45('eq_dif_ci',[0 0.05 0.1],[0 4]);
[x,y] = ode45('nome da equação diferencial', valores em estudo, condicao inicial y(0));
%Nota: se colocar 2 valores em "valores em estudo", vai aparecer todos os valores
%compreendidos entre esses 2 que o programa faz
%Se colocar 3 valores, ja so aparecem os 3 que pedi