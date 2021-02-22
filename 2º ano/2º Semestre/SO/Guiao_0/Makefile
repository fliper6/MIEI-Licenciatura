CC = gcc
CFLAGS = -Wall

main: person
	$(CC) $(CFLAGS) main.c -o main person.o

person:
	$(CC) $(CFLAGS) -c person.c

clean:
	rm main person.o