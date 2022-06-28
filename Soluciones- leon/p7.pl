%ejercicio1

padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

%I - juan

%II
%hijo(?X, ?Y)
hijo(X,Y) :- padre(Y,X).

%hermano(?X,?Y)
hermano(X,Y) :- hijo(X,Z), hijo(Y,Z).

%descendiente(?X,+Y)
descendiente(X,Y) :- hijo(X,Y).
descendiente(X,Y) :- abuelo(Y,X).

%III en carpeta
%IV abuelo(juan, Alguien)
%V hermano(pablo, Alguien)

%VI
%ancestro(X, X).
%ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

%siempre se entra en el primer caso, y matcea X con juan mismo para este. Al pedirle más, va aentrar a ancestro, donde Z matchea con Y, y luego va a padre(juan, Z), donde matchea con los dos hijos de juan. Luego intenta entrar de nuevo al llamado recursivo, crea nuevos Z2 que les asigna como padre a las Z anteriores y nos devuelve los nietos de Juan. Luego entra de nuevo al llamado recursivo y se queda buscando llamados recursivos asta morir

%VII
ancestro(X,Y) :- padre(X,Y).
ancestro(X,Y) :- padre(X,Z), ancestro(Z,Y).


%Ejercicio 3
natural(0).
natural(suc(X)) :- natural(X).

%menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
%menorOIgual(X,X) :- natural(X).

%I intenta matchear con el primer caso infinitamente, X = suc(Y), con lo que nunca encuentra un valor
%II un programa de Prolog puede terminar cuando tenga almenos un caso base definido antes de cualquier recursivo, y que en tal caso recursivo primero tenga que serciorarse de alguna condición o asignación no recursiva a cumplirse.
%III
menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).


%Ejercicio 4
%concatenar(?Lista1, ?Lista2, ?Lista3)
concatenar([], L, L).
concatenar([X | L1], L2, [X|L]) :- concatenar(L1, L2, L).


%Ejercicio 5
%I
%last(?L, ?U)
last(L, U) :- append(_, [U], L).

%II reverse(+L, -L1)
reverse([], []).
reverse(L, [X|XS]) :- append(L1, [X], L), reverse(L1, XS).

%III prefijo(?P, +L)
prefijo(P,L) :- append(P,_,L).

%IV sufijo(?S, +L)
sufijo(S,L) :- append(_,S,L).

%V sublista(?S,+L)
sublista(S,L) :- prefijo(P,L), sufijo(S,P).

%VI pertenece(?X, +L)
pertenece(X,L) :- sublista([X], L).


%Ejercicio 6
%aplanar(+Xs, -Ys)
aplanar([], []).
aplanar([X|XS], YS) :- aplanar(X,L1), append(L1, L2, YS), aplanar(XS, L2).
aplanar(X, [X]).


%Ejercicio8
%I interseccion(+L1, +L2, -L3)

%listaSin(+L1, +X, -L2)
listaSin([],_,[]).
listaSin([Y|L1], X, [Y|L2]) :- Y \= X, listaSin(L1, X, L2).
listaSin([X|L1], X, L2) :- listaSin(L1, X, L2).

interseccion([],_,[]).
interseccion([X|L1], L2, [X|L3]) :- listaSin(L2, X, L2X), L2 \= L2X, interseccion(L1, L2X, L3).
interseccion([X|L1], L2, L3) :- listaSin(L2, X, L2X), L2=L2X, interseccion(L1, L2, L3).

%partir(N, L, L1, L2)
partir(0, L, _, L2) :- L = L2.
partir(N, [X|L], [X|L1], L2) :- partir(M, L, L1, L2), N is M+1.
%se puede usar como partir(?N, +L, ?L1, ?L2) o partir(?N, -L, +L1, +L2)

%II borrar(+L, +X, -LSX)
borrar(L,X,LSX) :- listaSin(L,X,LSX).

%III sacarDuplicados(+L1, -L2)
sacarDuplicados(L1, L2) :- interseccion(L1, L1, L2).

%IV permutación(+L1, ?L2)
permutación([],[]).
permutación(L1, [X|L2]) :- append(P, [X|S], L1), append(P,S,L1sX), permutación(L1sX, L2).
%si L2 está definida, se podría usar borrar para ir sacando elementos hasta ver si quedan ambas listas en []

%V reparto(+L, +N, -LListas)
reparto(L, 1, [L]).
reparto(L, N, [X|XS]) :- M is N-1, append(X,S,L), X \= [], reparto(S,M,XS).

%VI repartoSinVacias(+L, -LListas)
repartoSinVacias(L,[L]).
repartoSinVacias(L, [X|XS]) :- append(X,S,L), X \= [], S \= [], repartoSinVacias(S,XS).








