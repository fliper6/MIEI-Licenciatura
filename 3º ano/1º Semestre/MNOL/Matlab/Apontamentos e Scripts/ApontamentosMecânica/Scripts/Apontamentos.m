%{
Nome de ficheiro = Nome da função
format short: default, poucas casas decimais
format long:  mais casas decimais

funcCount = número de cálculos da função
exitflag = 1 -> método converge
ln(x) -> log(x)
e^x   -> exp(x)
10^-10 -> 1.e-10

roots(C) -> calcula zeros de um polinómio
	 -> C é um vetor com os coeficientes do maior para o menor grau

----- Equações não lineares ------------------------------------------------------------

-> Criar função 'func' que faz o mesmo que f(x).
>> x = fsolve('func', aproximaçao inicial)

Se quiser mudar a tolerância:
>> op = optimset('TolX',E1,'TolFun', E2)
>> [x,fval,exitflag,output] = fsolve('func', aproximaçao inicial, op)



----- Sistemas de equações não lineares ------------------------------------------------

function[F] = func(x)
   F[1] = -5*x(1) + 3*sin(x(1)) + cos(x(2));
   F[2] = 4*cos(x(1)) +2*sin(x(2))-5*x(2);

   % fornecendo as primeiras derivadas de F passa a ser [F,d]
   % if nargout>1
   % d = [4*x(1)^3+0.06823 -4*x(2)^3-0.05848; 4*x(1)^3+0.05848 -8*x(2)^3-0.11696];
end

>> [x,fval,exitflag,output] = fsolve('func', [0 0.1](aproximação inicial))

Se quiser mudar a tolerância:
>> op = optimset('TolX', E1, 'TolFun', E2)



----- Polinomio Interpolador de Newton ---------------------------------------------------

-> Ver o grau do polinómio(n) e escolher os n+1 pontos mais próximos, pelo menos um de cada lado.
	
>> [p,s] = polyfit (x,y,n) 
	-> x/y: vetores com n+1 pontos
	-> n: grau do polinomio
	-> p: coeficientes do polinómio
	-> s: erro de newton

>> pn = polyval(p,x) -> pn fica com f(x)



----- Splines ----------------------------------------------------------------------------

>> x=[...]
>> y=[...]

Spline cúbica:
>> s = spline(x,y)    -> guarda a spline em s (aqui nao falam em declives e/ou derivadas)
>> z = spline(x,y,20) -> calcula o valor da spline em x=20

>> s.coefs -> permite obter os segmentos da spline

Segmento da spline: -> os coeficientes estão por ordem decrescente de grau (g3 g2 g1 g0)
		    -> para cada coeficiente c: c(x-li)^g
					-> li = limite inferior do segmento
					-> g = grau

Spline completa/derivadas:

-> se temos as derivadas então usamos todos os pontos da tabela.
	>> s = spline(x, [d0 y dn]) -> forçar as curvaturas nos extremos

-> também podemos fazer:  
	s = spline(x,[d0 y dn], [0 1 2 ... n-1 n]) para ter interpolaçoes nos pares de pontos da tabela.

-> se temos a função, calcular as derivadas d0 e dn, usamos todos os pontos da tabela.

-> se não temos as derivadas nem a função, calcular d0 e dn e tirar o 2º e penúltimo elementos da tabela
(isto pode alterar em que segmento fica o ponto).
	>> d0 = ...
	>> dn = ...
	>> s = spline(x sem 2º e penúltimo elementos, [d0 (y análogo) dn], ponto)
 



----- Integração Numérica ---------------------------------------------------------------

! Usar sempre operações vetoriais: .* ./ .^ !

Tabela de valores   -> trapz
Expressão da função -> quad/quadl

function[F] = teste(x)
   F = exp(x)./x;
end

>> quad(’teste’,a,b,tol) -> estipula a tolerância do erro absoluto = tol, no intervalo [a,b]
>> [z,nf] = quad('teste',a,b,tol) -> mostra o nº total de cálculos em nf
>> quadl('teste',a,b)

Se nos der uma função e disser para calcular o integral usando n pontos, temos de usar os pontos espaçados
por (b-a)/(n-1) porque n-1 é o numero de intervalos, e usar o trapz.
%}