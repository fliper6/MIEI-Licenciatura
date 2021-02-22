% o fsolve pode tamb�m ser usado para equa��es n�o lineares singulares, nao
% precisam de estar em sistema, mas aconselha-se usar o fzero.

%[X,FVAL,EXITFLAG,OUTPUT] = FSOLVE(FUN,X0,OPTIONS)

% FUN : file de fun��o(�es)
% X0 : X inicial dado
% OPTIONS : optimset (muda o algoritmo consoante a nossa necessidade)
% X : X �timo
% FVAL : F(X)
% EXITFLAG : 1 converge, 0 n�o converge
% OUTPUT : informa��es do algoritmo


% funciona para x's de 1 dimens�o
x0=[0.30 0.30];

% para que a rotina use as primeiras derivadas fornecidas no file da func.
%options=optimset('Jacobian','on');
options=optimset('TolX',1.e-20,'TolFun',1.e-20);
[xsol,fsol,exitflag,output]=fsolve('Sistema_N_Linear_Equals_0',x0,options)
