% Calcular o zero da fun��o 7(2 ? 0.9x) ? 10 = 0 perto de 6.

% Usa-se quando se tem apenas uma equa��o.

% x = zero da fun��o; 
% y = valor da fun��o nesse zero; 
% exitflag = Encontrou? Ent�o � 1, sen�o � 0; 
% output = Informa��o do algoritmo.

x0 = 6; 
[x,y,exitflag,output] = fzero('N_Linear', x0);