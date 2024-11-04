%pokemon(Nombre,   tipo(Tipos)).
pokemon(rayquaza,  tipo(volador)).
pokemon(rayquaza,  tipo(dragon)).
pokemon(pikachu,   tipo(electrico)).
pokemon(charizard, tipo(fuego)).
pokemon(venusaur,  tipo(planta)).
pokemon(blastoise, tipo(agua)).
pokemon(totodile,  tipo(agua)).
pokemon(snorlax,   tipo(normal)).
pokemon(arceus,    tipo()).

%entrenador(nombre, pokemones).
entrenador(ash,     pikachu).
entrenador(ash,     charizard).
entrenador(brock,   snorlax).
entrenador(misty,   blastoise).
entrenador(misty,   venusaur).
entrenador(misty,   arceus).


%1)
esDeTipoMultiple(Pokemon) :-
    pokemon(Pokemon, Tipo1),
    pokemon(Pokemon, Tipo2),
    Tipo1 \= Tipo2.

%2)
esPokemonLegendario(Pokemon) :-
    esDeTipoMultiple(Pokemon),
    forall(esDeTipoMultiple(Pokemon), noTienePokemon(_, Pokemon)).

tienePokemon(Entrenador, Pokemon) :-
    entrenador(Entrenador, Pokemon).

%3)
esPokemonMisterioso(Pokemon) :-
    pokemon(Pokemon,_),
    not(mismoTipo(Pokemon)).
%esPokemonMisterioso(Pokemon) :-
%    pokemon(Pokemon, _),
%    forall(entrenador(Entrenador, Pokemon), noTienePokemon(Entrenador, Pokemon)).

mismoTipo(Pokemon) :-
    pokemon(Pokemon, Tipo),
    pokemon(OtroPokemon, Tipo),
    Pokemon \= OtroPokemon.
noTienePokemon(Entrenador, Pokemon) :-
    not(tienePokemon(Entrenador, Pokemon)).

%%%%%%%%%
%PARTE 2%
%%%%%%%%%


%movimiento(Pokemon, clase(Movimiento, Potencia)).
movimiento(pikachu, fisico(mordedura, 95)).
movimiento(pikachu, especial(impactrueno, 95, electrico)).

movimiento(charizard, especial(garraDragon, 100, dragon)).
movimiento(charizard, fisico(mordedura, 95)).

movimiento(blastoise, defensivo(proteccion, 10)).
movimiento(blastoise, fisico(placaje, 50)).

movimiento(arceus, especial(impactrueno, 95, electrico)).
movimiento(arceus, especial(garraDragon, 100, dragon)).
movimiento(arceus, defensivo(proteccion, 10)).
movimiento(arceus, fisico(placaje, 50)).
movimiento(arceus, defensivo(alivio, 100)).

%1)

danioAtaque(fisico(_, Potencia), Potencia).
danioAtaque(defensivo(_,_), 0).
danioAtaque(especial(_, Potencia, Tipo), Cuanto) :-
    danioMovimientosEspeciales(Potencia, Tipo, Cuanto).

danioMovimientosEspeciales(Potencia, Tipo, Cuanto) :-
    tipoBasico(Tipo),
    Cuanto is Potencia * 1.5.
danioMovimientosEspeciales(Potencia, Tipo, Cuanto) :-
    tipoDragon(Tipo),
    Cuanto is Potencia * 3.
danioMovimientosEspeciales(Potencia, Tipo, Cuanto) :-
    not(tipoBasico(Tipo)),
    not(tipoDragon(Tipo)),
    Cuanto is Potencia^0.


tipoDragon(dragon).
tipoBasico(agua).
tipoBasico(fuego).
tipoBasico(planta).
tipoBasico(normal).

%2)
capacidadOfensiva(Pokemon, Capacidad) :-
    pokemon(Pokemon, _),
    findall(Danio, danioPokemon(Pokemon, Danio), Danios),
    sum_list(Danios, Capacidad).

danioPokemon(Pokemon, Danio) :-
    movimiento(Pokemon, Movimiento),
    danioAtaque(Movimiento, Danio).

%3)
entrenadorPicante(Entrenador) :-
    entrenador(Entrenador, Pokemon),
    forall(entrenador(_, Pokemon), esMisteriosoUOfensivo(Pokemon)).

esMisteriosoUOfensivo(Pokemon) :-
    capacidadOfensiva(Pokemon, Cantidad),
    Cantidad > 200.
esMisteriosoUOfensivo(Pokemon) :-
    esPokemonMisterioso(Pokemon).