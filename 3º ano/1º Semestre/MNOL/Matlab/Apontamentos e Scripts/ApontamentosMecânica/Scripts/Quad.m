Aproximação à solução do integral com uma precisão de 10^-10.
	integral(0.1 a 1) ln(x)/(1+x) dx

function[f] = teste(x)
f = log(x)./(1+x);
end

>> [r,ncalc] = quad('teste', 0.1, 1, 1.e-10)