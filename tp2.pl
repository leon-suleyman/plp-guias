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

%auxiliares propios
	%cantidadDeApariciones(+X, +L, ?N) no usa G&T
	cantidadDeApariciones(_, [], 0).
	cantidadDeApariciones(X,[X|XS], N) :- cantidadDeApariciones(X,XS,M), N is M+1.
	cantidadDeApariciones(Y,[X|XS], N) :- Y\=X, cantidadDeApariciones(Y,XS,N).

	%estadosDeTransiciones(+TS, -LS) no usa G&T. Toma TS una lista de transiciones y encuentra LS que contenga 
	%las etiquetas de los estados que aparecen en ellas, puede contener etiquetas repetidas.
	estadosDeTransiciones([],[]).
	estadosDeTransiciones([(P,_,D)|TS],[P,D|LS]) :- estadosDeTransiciones(TS,LS).
	
	%borrarDeLista(+L1, +ElementosABorrar, -L1SinElementosABorrar) no usa G&T. Borra de la lista L1 los elementos de la lista ElementosABorrar.
	borrarDeLista(L1,[],L1).
	borrarDeLista(L1,[X|XS], L) :- delete(L1,X,L2), borrarDeLista(L2,XS,L).
	
	%alcanzableDesde(+A, +EstadoPartida, +EstadoLlegada), si usa G&T. Es válida si existe un camino en A entre el EstadoPartida y el EstadoLlegada.
	% El N se usa para acotar la longitud maxima de un camino (cantidad de estados de A) y evitar ciclos infinitos. 
	alcanzableDesde(A, SD, SH) :- estados(A, LT), length(LT, N), M is N+1, entre(2, M, X), caminoDeLongitud(A, X, _,_,SD, SH).
	
	%reconoceDesde(+Automata, +EstadoActual, ?Palabra) no usa G&T. Es válida si Palabra es reconocible en A desde EstadoActual.
	% Cabe mencionar que primero se busca ES y despues si existe una transición de EA a ES mediante D, de este modo nos aseguramos
	% de mostrar todos los caminos, ya que si lo hiciesemos al revés podrían aparecer solo soluciones incrementales sobre un mismo ciclo.
	reconoceDesde(a(_,SF,_), EA, []) :- member(EA, SF).
	reconoceDesde(a(_,SF,Ts), EA, [D|Ds]) :-  reconoceDesde(a(_,SF,Ts), ES, Ds), member((EA,D,ES), Ts).

%Proposiciones de validez de automatas:
	%proposicionX(+A) A y B usan G&T
	%Borramos los estados finales porque realmente no importan y vemos que el resto de los estados tienen una transicion de salida
	proposicionA(a(SI,LF,T)) :- estados(a(SI,LF,T), LE), borrarDeLista(LE,LF,LNF), forall(member(Q,LNF), member((Q,_,_), T)). 

	%Borramos el estado iniciale porque realmente no importa y vemos que el resto de los estados sean alcanzables 
	proposicionB(a(SI,LF,T)) :- estados(a(SI,LF,T), LE), delete(LE, SI, L), forall(member(E, L), alcanzable(a(SI,LF,T), E)).

	%La unica manera de que unifique con este predicado es que la lista de estados finales tenga al menos un elemento,
	%sino no podría coincidir con la estructura [_|_] porque no tendría cabeza y cola.
	proposicionC(a(_,[_|_],_)). 

	%chequeamos que cada estado final sea unico, es decir, que no este repetido en la lista de estados finales
	proposicionD(a(_,LF,_)) :- forall(member(E, LF), cantidadDeApariciones(E, LF, 1)).

	%chequeamos que cada estado transicion sea unica, es decir, que no este repetido en la lista de transiciones
	proposicionE(a(_,_,Ts)) :- forall(member(T, Ts), cantidadDeApariciones(T, Ts,1)).

%%Predicados pedidos.

% 1) %esDeterministico(+Automata), no es G&T(Generate And Test). Idea: Si hay mas de una transición que parte de un estado P con etiqueta E 
% pero con distinto destino, entonces no es deterministico.
esDeterministico(a(_,_,[])).
esDeterministico(a(_,_,[(P,E,_)|XS])) :- cantidadDeApariciones((P,E,_),XS,0), esDeterministico(a(_,_,XS)).


% 2) estados(+Automata, ?Estados) no es G&T. Toma el estado inicial, los estados finales y los estados que aparecen en transiciones,
% forma una lista con todos ellos y la ordena (sort también remueve los repetidos).
estados(a(SI, LF, T), L) :- estadosDeTransiciones(T, ST), append([SI|ST],LF, FL), sort(FL, L).


% 3)esCamino(+Automata, ?EstadoInicial, ?EstadoFinal, +Camino) no es G&T.
% Idea: busca una transicion para cada par de estados contigüos que conforman el camino, si el camino tiene un solo estado, busca una transicion del estado a si mismo.
esCamino(a(_,_,T), S, S, [S]) :- member((S,_,S),T).
esCamino(a(_,_,T), S1, S2, [S1,S2]) :- member((S1,_,S2),T).
esCamino(a(_,_,T), S1, SF, [S1,S2|LS]) :- member((S1,_,S2),T), esCamino(a(_,_,T), _, SF, [S2|LS]). 

% 4) ¿el predicado anterior es o no reversible con respecto a Camino y por qué?
% No, porque 'member' siempre devuelve la primera transición que encuentra,  de modo que para casos con ciclos, 
% si una solucion entra en un ciclo va a tomar las mismas transiciones indefinidamente.

% 5) caminoDeLongitud(+Automata, +N, -Camino, -Etiquetas, ?S1, ?S2) no usa G&T
% La idea de este es generar todas las soluciones validas posibles
% para eso generamos los caminos de longitud n-1 y le vamos agregando las transiciones validas para generar un camino valido de longitud n
caminoDeLongitud(A, 1, [X], [], X, X) :- estados(A, ListaDeEstados), 
					   					 member(X, ListaDeEstados).
caminoDeLongitud(A, N, [S1, SX|XS], [E|ES], S1, S2) :- N>1,
							 transicionesDe(A, LT), 
							 member((S1,E,SX), LT), 
							 M is N-1, 
							 caminoDeLongitud(A, M, [SX|XS], ES, SX, S2).

% 6) alcanzable(+Automata, +Estado) si usa G&T
alcanzable(a(SI, LF, T), S) :-  alcanzableDesde(a(SI, LF, T), SI, S).

% 7) automataValido(+Automata) no usa G&T por si mismo, las proposiciones A y B si usan. Basicamente chequea que cumpla las codinciones de un automata valido
automataValido(A) :- proposicionA(A), proposicionB(A), proposicionC(A), proposicionD(A), proposicionE(A).


%--- NOTA: De acá en adelante se asume que los autómatas son válidos.


% 8) hayCiclo(+Automata) usa G&T. Idea: buscar un estado alcanzable desde si mismo, despues cortar, porque basta con encontrar uno.
hayCiclo(A) :- estados(A, LE), member(E, LE), alcanzableDesde(A, E, E), !.

% 9) reconoce(+Automata, ?Palabra) no usa G&T. Vemos si reconoce la palabra desde el principio :p
reconoce(a(SI,SF,Ts), Palabra) :- reconoceDesde(a(SI,SF,Ts), SI, Palabra).

% 10) PalabraMásCorta(+Automata, ?Palabra) usa G&T. 
%Idea: Si la palabra no viene instanciada, buscamos el camino de menor longitud probando con longitudes cada vez mas largas, una vez encontramos uno, tomamos esa longitud y dejamos de buscar,
%luego buscamos todos los caminos que se puedan formar de esa longitud y devolvemos la lista de etiquetas (la palabra)
palabraMasCorta(a(SI, LF, T), P) :- var(P), estados(a(SI, LF, T), LT), length(LT, N), M is N+1, entre(1, M, X), member(EF, LF), caminoDeLongitud(a(SI, LF, T), X, _, _, SI, EF), !, member(EF2, LF), caminoDeLongitud(a(SI, LF, T), X, _, P, SI, EF2).
%Si la palabra viene instanciada, buscamos la longitud del camino mas corto como en el caso anterior, le restamos 1 (porque el camino es de estados y la palabra de etiquetas) comparamos con la longitud de la palabra y 
%si coincide, comprobamos que la palabra es reconocida por el automata.
palabraMasCorta(a(SI, LF, T), P) :- nonvar(P), estados(a(SI, LF, T), LT), length(LT, N), M is N+1, entre(1, M, X), member(EF, LF), caminoDeLongitud(a(SI, LF, T), X, _, _, SI, EF), !, Y is X-1, length(P, Y), reconoce(a(SI, LF, T), P).

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

% Tests propios

test(16) :- cantidadDeApariciones(a, [a,b,a,d,a], 3).
test(17) :- cantidadDeApariciones(c, [a,b,a,d,a], 0).
test(18) :- ejemplo(4, a(_,_, T)), estadosDeTransiciones(T, [s1, s1, s1, s2, s1, s3]).
test(19) :- borrarDeLista([a,b,a,d,a], [a], [b,d]).
test(20) :- borrarDeLista([a,b,a,d,a], [c], [a, b, a, d, a]).
test(21) :- ejemplo(8, A), alcanzableDesde(A, s2, s4).
test(22) :- ejemplo(8, A), not(alcanzableDesde(A, s4, s2)).
test(23) :- ejemplo(9, A), reconoceDesde(A, s2, [b,a,b,a,b]).
test(24) :- ejemploMalo(1, A), not(proposicionA(A)).
test(25) :- ejemploMalo(3, A), not(proposicionB(A)).
test(26) :- ejemploMalo(7, A), not(proposicionC(A)).
test(27) :- ejemploMalo(5, A), not(proposicionD(A)).
test(28) :- ejemploMalo(6, A), not(proposicionE(A)).
test(29) :- ejemplo(8, A), not(esDeterministico(A)).
test(30) :- ejemplo(8, A), estados(A, [s1,s2,s3,s4,sf]).
test(31) :- ejemplo(7, A), esCamino(A, s1, s2, [s1,s3,s2]).
test(32) :- ejemplo(8, A), caminoDeLongitud(A, 6, _, _, s1, s3).
test(33) :- ejemploMalo(2, A), not(alcanzable(A,sf)).
test(34) :- ejemplo(6, A), alcanzable(A,s2).
test(35) :- ejemplo(8, A), hayCiclo(A).

tests :- forall(between(1, 35, N), test(N)). %IMPORTANTE: Actualizar la cantidad total de tests para contemplar los que agreguen ustedes.