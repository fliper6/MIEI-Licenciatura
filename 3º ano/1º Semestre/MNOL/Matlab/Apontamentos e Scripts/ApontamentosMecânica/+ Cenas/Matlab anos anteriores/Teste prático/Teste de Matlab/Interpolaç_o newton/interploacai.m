clear all
x=[1940 1950 1960 1970 1980]
y=[132.165 151.326 179.323 203.302 226.542]
p4=polyfit(x,y,4)
estimativa=polyval(p4,1965)