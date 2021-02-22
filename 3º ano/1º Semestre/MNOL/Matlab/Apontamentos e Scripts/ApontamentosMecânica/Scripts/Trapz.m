Considere a tabela com as velocidades instantâneas dum carro de Fórmula 1
durante uma volta completa à pista:
	t(s)	0 10 15 25 30 48 60 70 90
	v (m/s) 0 10 30 25 10 28 40 42 30
Calcule o comprimento da pista de Fórmula 1.


x = [0 10 15 25 30 48 60 70 90];
f = [0 10 30 25 10 28 40 42 30];

%Fórmula do trapézio: utilizar apenas quando temos um conjunto de pontos da função
>> comp = trapz(x,f)
comp = 2392.5 -> comprimento da pista
