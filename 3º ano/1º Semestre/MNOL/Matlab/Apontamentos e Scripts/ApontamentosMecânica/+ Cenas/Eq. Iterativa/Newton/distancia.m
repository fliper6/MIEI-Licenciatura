function[f] = distancia(x)
f = 2552-30*x^2 + x^3
end
%op = optimset('tolx', 0.001, 'tolfun', 0.001, 'display', 'iter', 'Maxiter', 3, 'Maxfunevals', 5000);
%[x,f,exitflag,output] = fsolve('distancia', 10, op);