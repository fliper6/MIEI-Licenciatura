function IM = integmajorante(fun, a, b, n, regra)
% --------------------------------------------------------
% Esta fun��o determina um majorante do erro de truncatura,
% en valor absoluto, ao aproximar o valor da integral da fun��o
% dada usando uma regra de aproxima��o indicada 
% Entrada:
%    fun - a fun��o integranda como string (ex: fun = inline('4/(4*x+1)'))
%    [a, b] - o intervalo dado
%    n - # de subintervalos
%    m�todo - indica o m�todo de aproxima��o:
%      TS - trap�zio simples
%      TC - trap�zio composto
%      SS - Simpson simples
%      SC - Simpson composto
%    Saida:
%      IM - o valor do majorante do erro
% exemplo:
%  M=integmajorante(inline('exp(-x.^2)'), 0, 1, 20, 'tc')
%------------------------------------------------------------------

% 1. Determinar M= max |df^(n+1)(x)| em [a, b] 

switch lower(regra)
  case {'ts', 'tc'}
     [M, x] = maxderivada(fun, 2, a, b);
  case {'ss', 'sc', '3/8_C'}
     [M, x] = maxderivada(fun, 4, a, b);
  otherwise
      disp('Metodo desconhecido')
end 
  
% 2. Aplicar a f�rmula segundo o metodo escolhido

switch lower(regra)
   case 'ts'
     IM = ((b-a)^3 / 12)* M;
   case 'tc'
     IM = ((b-a)^3 / (12 * n^2) )* M; 
   case 'ss'
     IM = ((b-a)^5 / (90 * n^5) )* M;      
   case 'sc'
     IM = ((b-a)^5 / (180 * n^4) )* M; 
   case '3/8'
     IM = ( 3*(b-a)^5 / (80 * n^5) )* M;    
 otherwise
      disp('Metodo desconhecido')
end

  disp(['| e(IT) |  <= ', num2str(IM, 8)]);
  
%------------------------------------------------------------------
%  Gladys Castillo, U.A, 2009
%------------------------------------------------------------------