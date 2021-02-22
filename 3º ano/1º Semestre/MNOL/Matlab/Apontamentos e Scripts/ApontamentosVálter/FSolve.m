% o fsolve pode também ser usado para equações não lineares singulares, nao
% precisam de estar em sistema, mas aconselha-se usar o fzero.

%[X,FVAL,EXITFLAG,OUTPUT] = FSOLVE(FUN,X0,OPTIONS)

% FUN : file de função(ões)
% X0 : X inicial dado
% OPTIONS : optimset (muda o algoritmo consoante a nossa necessidade)
% X : X ótimo
% FVAL : F(X)
% EXITFLAG : 1 converge, 0 não converge
% OUTPUT : informações do algoritmo


% funciona para x's de 1 dimensão
x0=[0.30 0.30];

% para que a rotina use as primeiras derivadas fornecidas no file da func.
%options=optimset('Jacobian','on');
options=optimset('TolX',1.e-20,'TolFun',1.e-20);
[xsol,fsol,exitflag,output]=fsolve('Sistema_N_Linear_Equals_0',x0,options)
