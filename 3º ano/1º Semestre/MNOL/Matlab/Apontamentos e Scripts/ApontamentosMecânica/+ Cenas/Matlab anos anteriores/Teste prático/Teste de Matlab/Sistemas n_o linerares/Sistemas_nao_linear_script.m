clear all
x1=[0.3;0.3];
options=optimset('jacobian','on','maxiter',1);
[xsol,fsol,exitflag,output]=fsolve('sistemasnlinear',x1,options)