function [f,deriv] = exemplo(x)
f = [80+90*cos(x*(pi/3))];
if nargout>1
    deriv=-30*pi*sin(x*(pi/3));
end
%Command Window
op = optimset('tolx', E1, 'tolfun', E2, 'display', 'iter');
[x,f,exitflag,output] = fsolve('nome da fun��o','valor inicial onde se inicia aitera��o', op);
%'valor inicial onde se inicia a itera��o' = n�mero (1 equa��o) ou vetor linha(v�rias equa��es). / exitflag: diz se o processo decorreu de forma correta: 1 (correto) ou 0(incorreto)