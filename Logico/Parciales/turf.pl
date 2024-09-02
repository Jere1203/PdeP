%1)
jockey(valdivieso, caracteristicas(155, 52)).
jockey(leguisamo, caracteristicas(161, 49)).
jockey(lezcano, caracteristicas(149, 50)).
jockey(baratucci, caracteristicas(153, 55)).
jockey(falero, caracteristicas(157, 52)).

% caballo(Nombre).
caballo(Caballo) :-
    puedeMontar(_, Caballo).
caballo(matBoy).

% puedeMontar(Jockey, Caballo).
puedeMontar(baratucci, botafogo).

puedeMontar(Jockey, botafogo) :-
    jockey(Jockey, caracteristicas(_, Peso)),
    Peso < 52.

puedeMontar(Jockey, oldMan) :-
    jockey(Jockey, _),
    atom_length(Jockey, Longitud),
    Longitud > 7.

puedeMontar(Jockey, energica) :-
    jockey(Jockey,_),
    not(puedeMontar(Jockey, botafogo)).

puedeMontar(Jockey, matBoy) :-
    jockey(Jockey, caracteristicas(Altura,_)),
    Altura > 170.

% No se modela a Yatasto ya que por principio de universo cerrado cualquier consulta que se haga sobre el tendra un valor de verdad Falso.

% stud(Jockey, Stud).
stud(valdivieso, elTute).
stud(falero, elTute).

stud(lezcano, lasHormigas).

stud(baratucci, elCharabon).
stud(leguisamo, elCharabon).

% premio(Caballo, Premio).
premio(botafogo, granPremioNacional).
premio(botafogo, granPremioRepublica).

premio(oldMan, granPremioRepublica).
premio(oldMan, campeonatoPalermoDeOro).

premio(matBoy, granPremioCriadores).

%2)
leGustaMasDeUno(Caballo) :-
    puedeMontar(Jockey, Caballo),
    puedeMontar(OtroJockey, Caballo),
    OtroJockey \= Jockey.

%3)
odiaA(Caballo, Stud) :-
    caballo(Caballo),
    stud(_, Stud),
    forall(stud(Jockey, Stud), noPuedeMontar(Jockey, Caballo)).

noPuedeMontar(Jockey, Caballo) :-
    not(puedeMontar(Jockey, Caballo)).

% No contesta por matBoy, no se como arreglarlo

%4)
piolin(Jockey) :-
    puedeMontar(Jockey, _),
    forall(ganoPremioPiola(Caballo), puedeMontar(Jockey, Caballo)).

ganoPremioPiola(Caballo) :-
    premio(Caballo, Premio),
    tipoPremioPiola(Premio).
tipoPremioPiola(granPremioNacional).
tipoPremioPiola(granPremioRepublica).

%5)
% jijeo jibu jijeo

%6)
color(botafogo, negro).
color(oldMan, marron).
color(energica, gris).
color(energica, negro).
color(matBoy, marron).
color(matBoy, blanco).
color(yatasto, blanco).
color(yatasto, marron).

puedeComprar(Gusto, Cuales) :-
    findall(Caballo, color(Caballo, Gusto), Cuales).