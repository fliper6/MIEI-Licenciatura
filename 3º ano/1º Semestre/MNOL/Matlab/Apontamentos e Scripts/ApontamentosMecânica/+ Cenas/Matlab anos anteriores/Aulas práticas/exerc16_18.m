%Exercício 16

clear all
ano=[1940 1950 1960 1970 1980]
pop=[132.165 151.326 179.323 203.302 226.542]
p4=polyfit(ano,pop,4)
estimativa=polyval(p4,1965)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercício 18

clear all
t=[4 7 8]
h=[1.8 1.5 1.4]
p2=polyfit(t,h,2)
altura=polyval(p2,5)
