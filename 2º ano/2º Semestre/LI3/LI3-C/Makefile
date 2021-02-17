FICHEIROS = Vendas.c AVLTrees.c CatClis.c CatProds.c Facturacao.c Filial.c Navegador.c Queries.c main.c

CFlags = -O2 -Wall -Wextra -pedantic -g

EXEC = SGV

compilation: $(FICHEIROS)
		gcc $(CFLAGS) -o $(EXEC) $(FICHEIROS)

run: compilation
	./$(EXEC)

zip:
	zip -r $(EXEC).zip ./ -x *.txt

clean :
	rm -rf *.zip $(EXEC)