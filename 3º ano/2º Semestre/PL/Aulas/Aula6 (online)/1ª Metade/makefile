##Ver texto introdutório da folha2 (BB), exemplo.txt

#2.2 compilação separada, Linguagem dos parentesis / F2.32

ex1-pl:  ex1-lp.fl ex1-lp.y
	flex ex1-lp.fl
	yacc -d ex1-lp.y
	cc y.tab.c lex.yy.c -o ex1-lp

#3 - alguma limpeza ...
clean:
	rm -f testaALex ex1-inc ex1-lp lex.yy.c y.tab.c y.tab.h


