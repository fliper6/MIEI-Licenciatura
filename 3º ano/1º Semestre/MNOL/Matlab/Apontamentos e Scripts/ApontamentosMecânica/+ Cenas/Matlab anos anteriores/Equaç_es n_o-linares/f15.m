function [F, JF] = f15(X)
% ------------------------------------------------------------------
% FP 3 - Exercicio 15
%                      x^2 -y - 0.2 = 0
%                      y^2 -x - 0.3 = 0
% Devolve o vector das equa��es do sistema F e da matriz jacobiana JF
% Par�metros de entrada
%   X    - o vector com os valores para x e y
% Par�metros de sa�da
%   F    - o vector das equa��es do sistema F
%   JF   - a matriz jacobiana JF
%-------------------------------------------------------------------- 
  x= X(1); y = X(2);
  F = [x.^2-y-0.2; y.^2-x-0.3];    % o vector com as equa��es do sistema
  JF = [2*x,  -1;  -1, 2*y];       % a matriz jacobiana
    