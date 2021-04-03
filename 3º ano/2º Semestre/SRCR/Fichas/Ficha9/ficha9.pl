:- style_check(-singleton).

g(grafo([a, b, c, d, e, f], [aresta(a, b), aresta(c, d), aresta(c, f), aresta(d, f), aresta(f, g)])).



%1
adjacente(X, Y, grafo(N, LA)) :- member(aresta(X, Y), LA).
adjacente(X, Y, grafo(N, LA)) :- member(aresta(Y, X), LA).

%2
caminho(G,A,B,P) :- caminho1(G,A,[B],P).

caminho1(_,A,[A|P1],[A|P1]).
caminho1(G,A,[Y|P1],P) :- 
   adjacente(X,Y,G),
    \+ memberchk(X,[Y|P1]),
    caminho1(G,A,[X,Y|P1],P).

%3
ciclo(G, A, P) :- adjacente(B, A, G), caminho(G, A, B, P1), append(P1, [A], P), length(P, L), L > 3.

