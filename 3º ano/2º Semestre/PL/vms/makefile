
CC=cc
CFLAGS=-Wall -std=gnu99 -Wall #-O2 #-Wextra 
STRUCTS=structs
GTK_LIBS=`pkg-config --cflags --libs gtk+-3.0`
GTK_FLAGS=`pkg-config --cflags gtk+-3.0`
GLIB_LIBS=`pkg-config --cflags --libs glib-2.0`
GLIB_FLAGS=`pkg-config --cflags glib-2.0`
MANPATH=`manpath | cut -d: -f1`

all: vms vmsGTKAux

install: all 
	cp vmsGTKAux /usr/local/bin/vmsGTKAux
	cp vms /usr/local/bin/vms
	mkdir -p $(MANPATH)/man1
	cp -f vmsMan.1 $(MANPATH)/man1/vms.1
	#gzip -f $(MANPATH)/man1/vms.1

vms: vms.c semantic.o types.o array.o code.o opStack.o callStack.o heap.o y.tab.o lex.yy.o
	$(CC) $(CFLAGS) vms.c semantic.o types.o array.o code.o opStack.o callStack.o heap.o y.tab.o lex.yy.o $(GLIB_LIBS) -lm -o vms -L/usr/local/lib -I/usr/local/include -lreadline

vmsGTKAux: interface.c
	$(CC) $(CFLAGS) interface.c $(GTK_LIBS) -o vmsGTKAux

####################################################################################################

semantic.o: semantic.c
	$(CC) $(CFLAGS) $(GLIB_FLAGS) -c semantic.c

####################################################################################################

array.o: $(STRUCTS)/array.c
	$(CC) $(CFLAGS) -c $(STRUCTS)/array.c

####################################################################################################

types.o: $(STRUCTS)/types.c
	$(CC) $(CFLAGS) $(GLIB_FLAGS) -c $(STRUCTS)/types.c

code.o: $(STRUCTS)/code.c
	$(CC) $(CFLAGS) $(GLIB_FLAGS) -c $(STRUCTS)/code.c

opStack.o: $(STRUCTS)/opStack.c
	$(CC) $(CFLAGS) $(GLIB_FLAGS) -c $(STRUCTS)/opStack.c

heap.o: $(STRUCTS)/heap.c
	$(CC) $(CFLAGS) $(GLIB_FLAGS) -c $(STRUCTS)/heap.c

callStack.o: $(STRUCTS)/callStack.c
	$(CC) $(CFLAGS) $(GLIB_FLAGS) -c $(STRUCTS)/callStack.c

####################################################################################################

y.tab.o: y.tab.c
	$(CC) $(CFLAGS) $(GLIB_FLAGS) -c y.tab.c

y.tab.c: syntax.y
	yacc -d syntax.y

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) $(GLIB_FLAGS) -c lex.yy.c

lex.yy.c: lex.l
	flex lex.l

####################################################################################################
clean:
	rm -f *.o y.tab.h y.tab.c lex.yy.c vms vmsGTKAux

test:
	./check.sh

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #

#TARGET := interface

#CFLAGS := -g #-std=c99 -Wall -Wextra -pedantic-errors -O2 -g
#CFLAGS += -L/usr/local/lib -I/usr/local/include -lreadline
#CFLAGS += $(shell pkg-config --cflags --libs glib-2.0 gtk+-3.0) -lm

#SRCS   := $(shell find . -name '*.c' ! -name 'y.tab.c' ! -name 'lex.yy.c')

#.PHONY: $(TARGET)
#$(TARGET): y.tab.c lex.yy.c
#	$(CC) $(SRCS) $^ $(CFLAGS) -o $@

#.PHONY: y.tab.c
#y.tab.c: syntax.y
#	yacc -d $<

#.PHONY: lex.yy.c
#lex.yy.c: lex.l
#	flex $<

#.PHONY: clean
#clean:
#	rm -f $(TARGET) y.tab.c lex.yy.c
