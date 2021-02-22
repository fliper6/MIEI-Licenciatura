x= linspace(0,5)
y1=1./x
y2=tan(x)
figure(1);
hold on;
axis([0  5 0 5]) 
plot(x,y1,'r', x, y2, 'b')
grid on