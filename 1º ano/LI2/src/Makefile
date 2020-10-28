FICHS = cgi.h estado.h exemplo.c lista.c lista.h stack.c stack.h valida.c valida.h ajudas.c ajudas.h resolve.c resolve.h Makefile
vn CFLAGS=-std=c11 -Wall -Wextra -pedantic -g -O2
FICHEIROS=$(FICHS)
EXECUTAVEL=GandaGalo

#Comando de compilação da 3º fase - gcc -std=c11 -Wall -Wextra -pedantic -O2 exemplo.c lista.c stack.c valida.c ajudas.c resolve.c

install: $(EXECUTAVEL)
	sudo cp $(EXECUTAVEL) /usr/lib/cgi-bin
	touch install

OBJS = exemplo.o lista.o stack.o valida.o ajudas.o resolve.o
$(EXECUTAVEL): $(OBJS)
	cc -o $(EXECUTAVEL) $(OBJS)

imagens:
	sudo mkdir -p /var/www/html/images
	sudo cp -R Imagens/*.png /var/www/html/images
	
diretorias:
	sudo mkdir -p /usr/local/games/GandaGalo
	sudo mkdir -p /usr/local/games/GandaGalo/Estados
	sudo cp -R Puzzles /usr/local/games/GandaGalo/Puzzles
	sudo chmod -R a+rwx /usr/local/games/GandaGalo/
	sudo chmod -R a+rwx /usr/local/games/GandaGalo/Estados/
	sudo chmod -R a+rwx /usr/local/games/GandaGalo/Puzzles/

GandaGalo.zip: $(FICHEIROS)
	zip -9 GandaGalo.zip $(FICHEIROS)

doc:
	doxygen exemplo.c

clean:
	rm -rf *.o $(EXECUTAVEL) Doxyfile latex html install
	sudo rm -rf /usr/local/games/GandaGalo
	sudo rm -rf /var/www/html/images

valida.o: valida.c valida.h estado.h
ajudas.o: ajudas.c ajudas.h lista.h estado.h
resolve.o: resolve.c resolve.h lista.h ajudas.h estado.h
lista.o: lista.c lista.h estado.h
stack.o: stack.c stack.h estado.h
exemplo.o: exemplo.c exemplo.h cgi.h estado.h lista.h valida.h ajudas.h stack.h resolve.h
