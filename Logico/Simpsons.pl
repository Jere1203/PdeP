padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).
madreDe(selma, ling).

tieneHijo(Simpson) :-
    madreDe(Simpson,_).
tieneHijo(Simpson) :-
    padreDe(Simpson,_).

hermanos(Simpson,OtroSimpson) :-
    compartenMadre(Simpson,OtroSimpson),
    compartenPadre(Simpson,OtroSimpson).

compartenMadre(Simpson,OtroSimpson) :-
    madreDe(Madre,Simpson),
    madreDe(Madre,OtroSimpson),
    Simpson \= OtroSimpson.

compartenPadre(Simpson,OtroSimpson) :-
    padreDe(Padre,Simpson),
    padreDe(Padre,OtroSimpson),
    Simpson \= OtroSimpson.
 
medioHermanos(Simpson,OtroSimpson) :-
    compartenMadre(Simpson,OtroSimpson),
    not(compartenPadre(Simpson,OtroSimpson)).
medioHermanos(Simpson,OtroSimpson) :-
    compartenPadre(Simpson,OtroSimpson),
    not(compartenMadre(Simpson,OtroSimpson)).

% tioDe(Simpson,OtroSimpson) :-    


progenitor(Padre,Hijo) :-
    padreDe(Padre,Hijo).
progenitor(Madre,Hijo) :-
    madreDe(Madre,Hijo).

descendiente(Descendiente,Ancestro) :-
    progenitor(Ancestro,Descendiente).

descendiente(Descendiente,AncestroMaximo) :-
    progenitor(AncestroMaximo,Ancestro),
    descendiente(Descendiente,Ancestro).