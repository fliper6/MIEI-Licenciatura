% -----------------------------------------------------------------
%   FP4 - Exerc. 8
%--------------------------------------------------------------------

format short;
clc; clear all;

disp('Um automóvel deslocando-se em linha recta ao longo de uma estrada, é cronometrado');
disp('em determinados pontos do percurso. Os dados registados foram os seguintes:');
disp('                             ');
disp('-------------------------------------------------------')

disp('Tempo em segundos: ');
T = [0, 3, 5, 8, 13]

disp('Distância em metros: ');
D = [0, 75, 128, 207, 331]

disp('Velocidade em metros/segundos: ');

V = [25, 25.6, 26.6, 24.6, 24]

disp('-------------------------------------------------------')
disp('                             ');

% a). Determinar um valor aproximado do tempo em segundos que o automóvel 
%     leva a percorrer os primeiros 100 metros usando interpolaçao
%     quadrática.

disp('Prima uma tecla para determinar um valor aproximado do tempo em segundos');
disp('que o automóvel leva a percorrer os primeiros 100 metros');
disp('usando interpolação inversa quadrática (polinómio interpolador de grau 2)')
disp('Para construir P2(d) que aproxima t(d) devemos escolher um suporte com 3 pontos que contenha d=100 m');
pause;

t = newtondifdiv(100, [0 75 128], [0 3 5]);

disp(['O tempo aproximado que o automóvel leva a percorrer os primeiros 100 metros: t(100) = ', num2str(t, 5), ' segundos']);
disp('-------------------------------------------------------')
disp('                             ');

% b). Determinar valores aproximados para a distancia percorrida ao fim de 10 segundos, 
%     usando interpolação cúbica.

disp('Prima uma tecla para determinar valores aproximados para a distancia percorrida');
disp('ao fim de 10 segundos usando interpolação cúbica (polinómio interpolador de grau 3).')
disp('Para construir P3(t) que aproxima d(t) devemos escolher um suporte com 4 pontos que contenha t=10.');
pause;

d = newtondifdiv(10, [3 5 8 13],[75 128 207 331]); 

disp(['A distancia aproximada percorrida ao fim de 10 segundos: d(10) = ', num2str(d, 5), ' m']);
disp('-------------------------------------------------------')
disp('                             ');


% c). Determinar valores aproximados para a velocidade do veículo ao fim de
% 10 segundos usando interpolação quadrática

disp('Prima uma tecla para determinar valores aproximados para a velocidade do veiculo');
disp('ao fim de 10 segundos usando interpolação quadrática.')
disp('Para construir P2(t) que aproxima v(t) devemos escolher um suporte com 3 pontos que contenha t=10.');
pause;

v = newtondifdiv(10, [5 8 13],[26.6 24.6 24]); 

disp(['A velocidade aproximada percorrida ao fim de 10 segundos: v(10) = ', num2str(v, 5), ' m/s']);
disp('-------------------------------------------------------')
disp('                             ');

% d). Determinar, se possível, estimativas do erro cometido no cálculo das aproximações anteriores.
% Comente e justifique devidamente.

disp('Prima uma tecla para determinar uma estimativa do erro de interpolação');
disp('cometido no cálculo da aproximação p2(100) de t(100)  obtida na alinha a).');
disp('Devemos calcular um majorante do erro absoluto usando a fórmula');
disp('|e2(d)| <= M3/3! (d-75)(d-128)(d-207), onde M3=max |t^{3}(d)| em [75 207]');
disp('Podemos aproximar M3 usando a tabela das diferenças divididas com todos os pontos');
disp('e tomar como estimativa de M3 o maximo em valor absoluto da diferença dividida de 3-er ordem'),
disp('M3~=max t[., ., ., .] e logo calcular e2= M3 * w2');
disp('Note que |t^(3)(psi)| ~ 3! * |t[d0, d1, d2, d3]|');
pause;

difdiv= tabdifdiv(D,T); % a função taddifdiv foi adaptada de divdifcoef.m
n=size(difdiv);
M3= max(abs(difdiv(1:n,3)))
w2= abs((100-0)*(100-75)*(100-128)) 
e2= M3 * w2

disp('-------------------------------------------------------')
disp('                             ');

disp('Prima uma tecla para determinar uma estimativa do erro de interpolação');
disp('cometido no cálculo da aproximação p3(10) de d(10) obtida na alinha b).');
disp('Devemos calcular um majorante do erro absoluto usando a fórmula');
disp('|e3(t)| <= M4/4! x w3(t), w3(t)=(t-3)(t-5)(t-8)(t-13), M4=max |d^4(t)| em [3 13]');
disp('Podemos aproximar M4 usando a tabela das diferenças divididas com todos os pontos');
disp('e tomar como estimativa de M4 o maximo em valor absoluto da diferença dividida de 4-to ordem'),
disp('M4 ~=max d[., ., ., ., .] e logo calcular e3= M4 * w3');
disp('Note que |d^(4)(psi)| ~ 4! * |d[t0, t1, t2, t3, t4]|');
pause;

difdiv= tabdifdiv(T,D);
n=size(difdiv);
M4= max(abs(difdiv(1:n,4)))
w3= abs((10-3)*(10-5)*(10-8)*(10-13)) 
e3= M4 * w3

disp('-------------------------------------------------------')
disp('                             ');

disp('Prima uma tecla para determinar uma estimativa do erro de interpolação');
disp('cometido no cálculo da aproximação p2(10) de v(10) obtida na alinha c).');
disp('Devemos calcular um majorante do erro absoluto usando a fórmula');
disp('|e2(t)| <= M3/3! x w2(t), w2(t)=(t-5)(t-8)(t-13), M3=max |v^3(t)| em [5 13]');
disp('Podemos aproximar M3 usando a tabela das diferenças divididas com todos os pontos');
disp('e tomar como estimativa de M3 o maximo em valor absoluto da diferença dividida de 3-er ordem'),
disp('M3 ~= max v[., ., ., .]. Logo podemos calcular e2= M3 * w2');
disp('Note que |v^(3)(psi)| ~ 3! * |v[t0, t1, t2, t3]|');
pause;

difdiv= tabdifdiv(T,V);
n=size(difdiv);
M3= max(abs(difdiv(1:n,3)))
w2= abs((10-5)*(10-8)*(10-13)) 
e2= M3 * w2





   


% ----------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------

