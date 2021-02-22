clear all
x=[1.5 2.0  2.2 3 3.8];
y=[4.9 3.3 3.0 2.0 1.75];
pp=spline(x,[0 y 0]);
pp.coefs

xx=spline(x,[0 y 0],1.75)