% Calcular o zero da função 7(2 ? 0.9x) ? 10 = 0 perto de 6.

% Usa-se quando se tem apenas uma equação.

% x = zero da função; 
% y = valor da função nesse zero; 
% exitflag = Encontrou? Então é 1, senão é 0; 
% output = Informação do algoritmo.

x0 = 6; 
[x,y,exitflag,output] = fzero('N_Linear', x0);