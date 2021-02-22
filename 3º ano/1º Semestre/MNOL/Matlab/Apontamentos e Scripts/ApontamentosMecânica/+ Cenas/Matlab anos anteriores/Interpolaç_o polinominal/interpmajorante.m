function IM = interpmajorante(fun, X, xm)
% --------------------------------------------------------
% Esta função determina um majorante do erro de interpolação
% |e(xm)| = | fun(xm) - pn(xm)| =  | wn |/(n+1) * M;
% onde o grau do polinómio  n = length(X)-1;
%      M = max |df^(n+1)(x)| em [a, b] ((n+1)-essima derivada de fun)
%      wn = (xm -X(1))* (xm -X(2)) * ... * (xm -X(n+1))
% Entrada:
%    fun - a função como string (ex: fun = '4/(4*x+1)')
%      X - o vector com os nós de interpolação
%      xm - o valor de x onde vamos avaliar o majorante
% Saida:
%      IM - o valor do majorante do erro de interpolação
%
%  Gladys Castillo, U.A, 2006
%------------------------------------------------------------------

% 1. Determinar o grau do polinómio

n =length(X)-1;

% 2. Determinar a (n+1) derivada de fun
syms x;
f= sym(fun);  % converte fun a uma variavel simbólica
for i=1:(n+1)
  df = diff(f);
  f= df;
end;

% 3. Determinar M= max |df^(n+1)(x)| em [a, b] 

df= abs(df);
a = min(X);
b = max(X);

% inline converte de simbólico a uma função que pode ser avaliada
% multiplico por -1 pois vamos minimizar em vez de maximizar


% converter de simbólico a string para poder utilizar fminbnd
% multiplico por -1 pois vamos minimizar em vez de maximizar

  absdf = ['abs(', char(df), ')'];  % a funçao da derivada deve ser expressa como string
  x = fminbnd(['-1 *',absdf], a, b);
  M = eval(absdf, x)
  
% 4. Determinar wn = (xm -X(1))* (xm -X(2)) * ... * (xm -X(n+1))

wn=1;
for i=1:length(X)
   wn = wn * (xm -X(i)); 
end;   


% 5. Determinar majorante 

 IM = (M/factorial(n+1)) * abs(wn);
 
 disp(['e(', num2str(xm, 4), ') <= ', num2str(IM, 8)]);