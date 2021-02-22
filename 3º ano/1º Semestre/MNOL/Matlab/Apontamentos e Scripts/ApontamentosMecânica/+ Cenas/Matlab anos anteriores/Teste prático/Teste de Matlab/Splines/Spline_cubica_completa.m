clear all
x=[1 2 3 4 5 6];
y=[1.0 1.25 1.75 2.25 3.0 3.15];
sol=spline(x,y,1.5)
res=spline(x,y)
res.coefs