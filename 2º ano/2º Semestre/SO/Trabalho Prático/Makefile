AUXFILES = cod_partilhado.c writes.c

CFLAGS = -O2 -Wall -Wextra -pedantic -g

ag: ag.c $(AUXFILES)
	gcc $(CFLAGS) -o ag ag.c $(AUXFILES)

cv: cv.c $(AUXFILES)
	gcc $(CFLAGS) -o cv cv.c $(AUXFILES)

ma: ma.c $(AUXFILES)
	gcc $(CFLAGS) -o ma ma.c $(AUXFILES)

sv: sv.c $(AUXFILES)
	gcc $(CFLAGS) -o sv sv.c $(AUXFILES)

run_ag: ag
	./ag

run_cv: cv
	./cv < comandos_cv

run_ma: ma
	./ma < comandos_ma

run_sv: sv
	./sv

rm: 
	rm -rf Dados_Vendas Pipes Dados_Agregados
	
clean:
	rm -rf ag cv ma sv Pipes

delete:
	rm -rf ag cv ma sv Pipes Ficheiros Dados_Agregados