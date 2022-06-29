%Autómatas de ejemplo. Si agregan otros,  mejor.

ejemplo(1, a(s1, [sf], [(s1, a, sf)])).
ejemplo(2, a(si, [si], [(si, a, si)])).
ejemplo(3, a(si, [si], [])).
ejemplo(4, a(s1, [s2, s3], [(s1, a, s1), (s1, a, s2), (s1, b, s3)])).
ejemplo(5, a(s1, [s2, s3], [(s1, a, s1), (s1, b, s2), (s1, c, s3), (s2, c, s3)])).
ejemplo(6, a(s1, [s3], [(s1, b, s2), (s3, n, s2), (s2, a, s3)])).
ejemplo(7, a(s1, [s2], [(s1, a, s3), (s3, a, s3), (s3, b, s2), (s2, b, s2)])).
ejemplo(8, a(s1, [sf], [(s1, a, s2), (s2, a, s3), (s2, b, s3), (s3, a, s1), (s3, b, s2), (s3, b, s4), (s4, f, sf)])). % No deterministico :)
ejemplo(9, a(s1, [s1], [(s1, a, s2), (s2, b, s1)])).
ejemplo(10, a(s1, [s10, s11], 
        [(s2, a, s3), (s4, a, s5), (s9, a, s10), (s5, d, s6), (s7, g, s8), (s15, g, s11), (s6, i, s7), (s13, l, s14), (s8, m, s9), (s12, o, s13), (s14, o, s15), (s1, p, s2), (s3, r, s4), (s2, r, s12), (s10, s, s11)])).

ejemploMalo(1, a(s1, [s2], [(s1, a, s1), (s1, b, s2), (s2, b, s2), (s2, a, s3)])). %s3 es un estado sin salida.
ejemploMalo(2, a(s1, [sf], [(s1, a, s1), (sf, b, sf)])). %sf no es alcanzable.
ejemploMalo(3, a(s1, [s2, s3], [(s1, a, s3), (s1, b, s3)])). %s2 no es alcanzable.
ejemploMalo(4, a(s1, [s3], [(s1, a, s3), (s2, b, s3)])). %s2 no es alcanzable.
ejemploMalo(5, a(s1, [s3, s2, s3], [(s1, a, s2), (s2, b, s3)])). %Tiene un estado final repetido.
ejemploMalo(6, a(s1, [s3], [(s1, a, s2), (s2, b, s3), (s1, a, s2)])). %Tiene una transición repetida.
ejemploMalo(7, a(s1, [], [(s1, a, s2), (s2, b, s3)])). %No tiene estados finales.

%%Proyectores
inicialDe(a(I, _, _), I).

finalesDe(a(_, F, _), F).

transicionesDe(a(_, _, T), T).

%Auxiliar dada en clase
%desde(+X, -Y).
desde(X, X).
desde(X, Y):-desde(X, Z),  Y is Z + 1.

entre(X, Y, X) :- X =< Y.
entre(X, Y, Z) :- X < Y, N is X+1, entre(N,Y,Z).


%cantidadDeApariciones(+X, +L, ?N)
cantidadDeApariciones(_, [], 0).
cantidadDeApariciones(X,[X|XS], N) :- cantidadDeApariciones(X,XS,M), N is M+1.
cantidadDeApariciones(Y,[X|XS], N) :- Y\=X, cantidadDeApariciones(Y,XS,N).

%estadosDeTransiciones(+TS, -LS)
estadosDeTransiciones([],[]).
estadosDeTransiciones([(P,_,D)|TS],[P,D|LS]) :- estadosDeTransiciones(TS,LS).

%%Predicados pedidos.

% 1) %esDeterministico(+Automata)
esDeterministico(a(_,_,[])).
esDeterministico(a(_,_,[(P,E,_)|XS])) :- cantidadDeApariciones((P,E,_),XS,0), esDeterministico(a(_,_,XS)).


% 2) estados(+Automata, ?Estados)
estados(a(SI, LF, T), L) :- estadosDeTransiciones(T, ST), append([SI|ST],LF, FL), sort(FL, L).


% 3)esCamino(+Automata, ?EstadoInicial, ?EstadoFinal, +Camino)
esCamino(a(SI,_,_), SI, SI, [SI]).
esCamino(a(_,_,T), S1, S2, [S1,S2]) :- member((S1,_,S2),T).
esCamino(a(_,_,T), S1, SF, [S1,S2|LS]) :- member((S1,_,S2),T), esCamino(a(_,_,T), _, SF, [S2|LS]). 

% 4) ¿el predicado anterior es o no reversible con respecto a Camino y por qué?
% No, porque 'member' siempre devuelve la primera transición que encuentra,  de modo que para casos con ciclos, si una solucion entra en un ciclo.

% 5) caminoDeLongitud(+Automata, +N, -Camino, -Etiquetas, ?S1, ?S2)
caminoDeLongitud(A, 1, [X], [], X, X) :- estados(A, ListaDeEstados),
					   member(X, ListaDeEstados).
caminoDeLongitud(A, N, [S1, SX|XS], [E|ES], S1, S2) :- N>1,
							 transicionesDe(A, LT), 
							 member((S1,E,SX), LT), 
							 M is N-1, 
							 caminoDeLongitud(A, M, [SX|XS], ES, SX, S2).

% 6) alcanzable(+Automata, +Estado)
alcanzable(a(SI, LF, T), S) :-  estados(a(SI, LF, T), LT), length(LT, N), M is N+1, entre(2, M, X), caminoDeLongitud(a(SI, LF, T), X, _,_,SI, S).

% 7) automataValido(+Automata)

borrarDeLista(L1,[],L1).
borrarDeLista(L1,[X|XS], L) :- delete(L1,X,L2), borrarDeLista(L2,XS,L).

proposicionA(a(SI,LF,T)) :- estados(a(SI,LF,T), LE), borrarDeLista(LE,LF,LNF), forall(member(Q,LNF), member((Q,_,_), T)). 

proposicionB(a(SI,LF,T)) :- estados(a(SI,LF,T), LE), delete(LE, SI, L), forall(member(E, L), alcanzable(a(SI,LF,T), E)).

automataValido(_).


%--- NOTA: De acá en adelante se asume que los autómatas son válidos.


% 8) hayCiclo(+Automata)
hayCiclo(_).

% 9) reconoce(+Automata, ?Palabra)
reconoce(_, _).

% 10) PalabraMásCorta(+Automata, ?Palabra)
palabraMasCorta(_, _).

%-----------------
%----- Tests -----
%-----------------

% Algunos tests de ejemplo. Deben agregar los suyos.

test(1) :- forall(ejemplo(_, A),  automataValido(A)).
test(2) :- not((ejemploMalo(_, A),  automataValido(A))).
test(3) :- ejemplo(10, A), reconoce(A, [p, X, r, X, d, i, _, m, X, s]).
test(4) :- ejemplo(9, A), reconoce(A, [a,  b,  a,  b,  a,  b,  a,  b]).
test(5) :- ejemplo(7, A), reconoce(A, [a,  a,  a,  b,  b]).
test(6) :- ejemplo(7, A), not(reconoce(A, [b])).
test(7) :- ejemplo(2, A),  findall(P, palabraMasCorta(A, P), [[]]).
test(8) :- ejemplo(4, A),  findall(P, palabraMasCorta(A, P), Lista), length(Lista, 2), sort(Lista, [[a], [b]]).
test(9) :- ejemplo(5, A),  findall(P, palabraMasCorta(A, P), Lista), length(Lista, 2), sort(Lista, [[b], [c]]).
test(10) :- ejemplo(6, A),  findall(P, palabraMasCorta(A, P), [[b, a]]).
test(11) :- ejemplo(7, A),  findall(P, palabraMasCorta(A, P), [[a, b]]).
test(12) :- ejemplo(8, A),  findall(P, palabraMasCorta(A, P), Lista), length(Lista, 2), sort(Lista, [[a,  a,  b,  f], [a,  b,  b,  f]]).
test(13) :- ejemplo(10, A),  findall(P, palabraMasCorta(A, P), [[p, r, o, l, o, g]]).
test(14) :- forall(member(X, [2, 4, 5, 6, 7, 8, 9]), (ejemplo(X, A), hayCiclo(A))).
test(15) :- not((member(X, [1, 3, 10]), ejemplo(X, A), hayCiclo(A))).
tests :- forall(between(1, 15, N), test(N)). %IMPORTANTE: Actualizar la cantidad total de tests para contemplar los que agreguen ustedes.
