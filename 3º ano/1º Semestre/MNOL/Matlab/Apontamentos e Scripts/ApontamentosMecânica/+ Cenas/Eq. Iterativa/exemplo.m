function [f,deriv] = exemplo(x)
f = [80+90*cos(x*(pi/3))];
if nargout>1
    deriv=-30*pi*sin(x*(pi/3));
end
%Command Window
op = optimset('tolx', E1, 'tolfun', E2, 'display', 'iter');
[x,f,exitflag,output] = fsolve('nome da função','valor inicial onde se inicia aiteração', op);
%'valor inicial onde se inicia a iteração' = número (1 equação) ou vetor linha(várias equações). / exitflag: diz se o processo decorreu de forma correta: 1 (correto) ou 0(incorreto)