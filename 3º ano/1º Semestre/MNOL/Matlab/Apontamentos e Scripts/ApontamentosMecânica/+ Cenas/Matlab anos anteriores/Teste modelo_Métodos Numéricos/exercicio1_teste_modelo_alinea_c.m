clear all
x=[1.5 2.0 2.2 3.0 3.8 4.0];
f=[4.9 3.3 3.0 2.0 1.75 1.5];
[p1,S2]=polyfit(x,f,2)
vall=polyval(p1,3.5)