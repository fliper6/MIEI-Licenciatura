%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vii. O cálculo do máximo divisor comum (m.d.c.) pode ser obtido pelos seguintes passos:

mdc(X,Y,R) :- X > Y,
  			    X1 is X-Y,
                mdc( X1,Y,R ).
mdc(X,Y,R) :- Y > X,
    			Y1 is Y-X,
    			mdc( X,Y1,R ).
mdc(X,X,X).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

