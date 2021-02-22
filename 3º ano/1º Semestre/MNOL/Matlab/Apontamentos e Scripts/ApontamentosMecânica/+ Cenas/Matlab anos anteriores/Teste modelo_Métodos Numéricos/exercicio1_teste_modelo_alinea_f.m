clear all
x=[1.5 2.0 2.2 3.0 3.8 4.0];
f=[4.9 3.3 3.0 2.0 1.75 1.5];
[X,RESNORM,RESIDUAL,EXITFLAG,OUTPUT]=lsqcurvefit('exercicio1_teste_modelo_alinea_f_function',[1; 1; 1],x,f)