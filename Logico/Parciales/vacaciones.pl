viaja(dodain, pehuenia).
viaja(dodain, sanMartinDeLosAndes).
viaja(dodain, esquel).
viaja(dodain, sarmiento).
viaja(dodain, camarones).
viaja(dodain, playasDoradas).

viaja(alf, bariloche).
viaja(alf, sanMartinDeLosAndes).
viaja(alf, elBolson).

viaja(nico, marDelPlata).

viaja(vale, calafate).
viaja(vale, elBolson).

viaja(martu, Donde) :-
    viaja(nico, Donde).
viaja(martu, Donde) :-
    viaja(alf, Donde).

persona(Persona) :-
    viaja(Persona, _).

%2)
% atraccion(parqueNacional(Nombre)).
% cerro(Nombre, Altura).
% cuerpoAgua(Nombre, PuedePescar, Temperatura).
% playa(Promedio).
% excursion(Nombre).

atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).

atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoAgua(moquehue, puedePescar, 14)).
atraccion(pehuenia, cuerpoAgua(alumine, puedePescar, 19)).

vacacionCopada(Persona, Lugar) :-
    viaja(Persona, Lugar),
    atraccion(Lugar, Atraccion),
    tipoAtraccionCopada(Atraccion).

tipoAtraccionCopada(cerro(_, Altura)) :-
    Altura > 2000.
tipoAtraccionCopada(cuerpoAgua(_, puedePescar, _)).
tipoAtraccionCopada(cuerpoAgua(_, _, Temperatura)) :-
    Temperatura > 20.
tipoAtraccionCopada(playa(DiferenciaMareas)) :-
    DiferenciaMareas < 5.
tipoAtraccionCopada(excursion(Nombre)) :-
    atom_length(Nombre, Longitud),
    Longitud > 7.
tipoAtraccionCopada(parqueNacional(_)).

%3)
noSeCruzaron(Persona1, Persona2) :-
    persona(Persona1),
    persona(Persona2),
    not(seCruzaron(Persona1, Persona2)),
    Persona1 \= Persona2.

seCruzaron(Persona1, Persona2) :-
    viaja(Persona1, Lugar),
    viaja(Persona2, Lugar),
    Persona1 \= Persona2.

%4)
% costoDeVida/2(Destino, Costo).
costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartinDeLosAndes, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(elCalafate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

vacacionesGasoleras(Persona) :-
    viaja(Persona, _),
    forall(viaja(Persona, Lugar), destinoGasolero(Lugar)).
destinoGasolero(Lugar) :-
    costoDeVida(Lugar, Costo),
    Costo < 160.

%5)
itinerario(Persona, LugaresSinVisitar) :-
    persona(Persona),
    findall(Lugar, viaja(Persona, Lugar), LugaresSinVisitar).

% Combinatoria no se ve ni se toma mas, no voy a seguir este enunciado.