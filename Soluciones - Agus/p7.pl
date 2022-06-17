%% Ejercicio 1
padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

%% I)
%% abuelo(X, manuel).
%% X = juan.

%% II)
hijo(X, Y) :- padre(Y, X).
hermano(X, Y) :- padre(Z, X), padre(Z, Y), X \= Y.
descendiente(X, Y) :- abuelo(Y, X).
descendiente(X, Y) :- padre(Y, X).

%% III) Próximamente en la tablet.

%% IV) 
%% abuelo(juan, X).

%% V)
%% hermano(pablo, X).

%% VI)
ancestro(X, X).
ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

%% VII) Próximamente en la tablet.
%% VIII) Próximamente.



%% Ejercicio 3

natural(0).
natural(suc(X)) :- natural(X).
%%menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
%%menorOIgual(X,X) :- natural(X).

%% I) Se muere.

%% II) Próximamente.

%% III) 
menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).

%% Ejercicio 4
%%concatenar(?Lista1, ?Lista2, ?Lista3)

