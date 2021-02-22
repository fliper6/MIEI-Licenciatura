%x=[1.5 2.0 3.0 4.0];
%f=[4.9 3.3 2.0 1.5];
%[p1,r] = polyfit(x,f,1); %por ordem do maior n para o menor n
%S=r.normr^2;

function [ M ] = MQ( c,x )
M=c(1)./x+c(2)*x;
%M=c(1)./x+c(2)*x+c(3)*x.^2;
end
%[c,s]=lsqcurvefit('MQ', [1 1],x,f) %matriz de 1's com a dimensao do n requerido /O S ja e dado aqui
%mq1(c,2.5)