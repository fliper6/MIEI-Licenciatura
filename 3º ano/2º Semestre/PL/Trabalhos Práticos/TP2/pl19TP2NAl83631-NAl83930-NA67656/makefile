pugtohtml: pugtohtml.l pugtohtml.y
	flex pugtohtml.l
	yacc -d pugtohtml.y
	cc lex.yy.c y.tab.c -lm -o pugtohtml
