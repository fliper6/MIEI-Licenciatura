function [F, JF] = f15(X)
% ------------------------------------------------------------------
% FP 3 - Exercicio 15
%                      x^2 -y - 0.2 = 0
%                      y^2 -x - 0.3 = 0
% Devolve o vector das equações do sistema F e da matriz jacobiana JF
% Parâmetros de entrada
%   X    - o vector com os valores para x e y
% Parâmetros de saída
%   F    - o vector das equações do sistema F
%   JF   - a matriz jacobiana JF
%-------------------------------------------------------------------- 
  x= X(1); y = X(2);
  F = [x.^2-y-0.2; y.^2-x-0.3];    % o vector com as equações do sistema
  JF = [2*x,  -1;  -1, 2*y];       % a matriz jacobiana
    