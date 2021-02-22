Func: 10 = (10*b*sin(b/2))/2
xi = 5
TolX = 10^-12, TolFun = 10^-12.


function[f] = teste(b)
f = (10*b*sin(b/2))/2 - 10;
end

>> op = optimset('TolX',1.e-12,'TolFun',1.e-12);
>> [b,fval,exitflag,output] = fsolve('teste',5,op)

b = 5.545209
iterations: 5
funcCount: 12
exitflag = 1, logo convergiu
