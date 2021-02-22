A resistência de um certo fio de metal, f (x), varia com o diâmetro desse fio, x. Foram medidas as
resistências de 6 fios de diversos diâmetros:
	xi    1.5 2.0 2.2 3.0 3.8  4.0
	f(xi) 4.9 3.3 3.0 2.0 1.75 1.5

Estime f(2.5) usando uma spline cúbica forçando um declive −2 e 3 nos extremos inferior e
superior, respetivamente.


>> x = [1.5 2.0 2.2 3.0 3.8 4.0];
>> f = [4.9 3.3 3.0 2.0 1.75 1.5];

%forçar a curvatura nos pontos extremos e calcular aproximação para 2.5
>> xx = spline(x,[-2 f 3], 2.5)
>> xx =  2.5471 -> estimativa de f(2.5)