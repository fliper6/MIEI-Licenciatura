:- style_check(-singleton).

:- dynamic g/1.
:- dynamic caminho/3.
:- dynamic caminho/4.

:- discontiguous g/1.



g(grafo([a, b, c, d, e, f], [aresta(a, b), aresta(c, d), aresta(c, f), aresta(d, f), aresta(f, g)])).



adjacente(X, Y, grafo(N, LA)) :- member(aresta(X, Y, _, _), LA).
adjacente(X, Y, grafo(N, LA)) :- member(aresta(Y, X, _, _), LA).

info(X, Y, grafo(N, LA), Es, D) :- member(aresta(X, Y, Es, D), LA).
info(X, Y, grafo(N, LA), Es, D) :- member(aresta(Y, X, Es, D), LA). 

caminho(G,A,B,P) :- caminho1(G,A,[B],P).

caminho1(_,A,[A|P1],[A|P1]).
caminho1(G,A,[Y|P1],P) :- 
   adjacente(X,Y,G),
    \+ memberchk(X,[Y|P1]),
    caminho1(G,A,[X,Y|P1],P).


g( grafo([madrid, cordoba, sevilla, jaen, granada, huelva, cadiz],
  [aresta(huelva, sevilla, a49, 94),
   aresta(sevilla, cadiz,ap4, 125),
   aresta(sevilla, granada, a92, 256),
   aresta(granada, jaen,a44, 97),
   aresta(sevilla, cordoba, a4, 138),
   aresta(jaen,madrid, a4, 335),
   aresta(cordoba, madrid, a4, 400)]
)).


caminho(G, A, B, P, Km, Es) :- caminho1(G, A, [B], P, Km, Es).

caminho1(_,A,[A|P1],[A|P1], 0, []).
caminho1(G,A,[Y|P1],P, Km, Es) :- 
   info(X, Y, G, E, D),
   \+ memberchk(X,[Y|P1]),
   caminho1(G,A,[X,Y|P1], P, Km2, Es2),
   Km is Km2 + D,
   append(Es2, [E], Es).


ciclo(G, A, P, Km, Es) :- info(B, A, G, E, D), caminho(G, A, B, P1, Km2, Es2), append(P1, [A], P), Km is D + Km2, append(Es2, [E], Es), length(P, L), L > 3.