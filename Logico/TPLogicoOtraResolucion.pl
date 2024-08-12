%Punto 1

jugador(ana, romanos, [herreria, forja, emplumado, laminas]).
jugador(beto, incas, [herreria, forja, fundicion]).
jugador(carola, romanos, [herreria]).
jugador(dimitri, romanos, [herreria, fundicion]).

%Punto2

esExpertoEnMetales(Jugador) :-
    sabeHerreriaYForja(Jugador),
    tieneFundicion(Jugador).
esExpertoEnMetales(Jugador) :-
    sabeHerreriaYForja(Jugador),
    jugador(Jugador, Civilizacion,_),
    Civilizacion == romanos.

sabeHerreriaYForja(Jugador) :-
    jugador(Jugador, _, Habilidades),
    member(herreria, Habilidades),
    member(forja, Habilidades).
    
tieneFundicion(Jugador) :-
    jugador(Jugador, _, Habilidades),
    member(fundicion, Habilidades).

%Punto 3

esCivilizacionPopular(Civilizacion) :-
    jugador(Jugador, Civilizacion, _),
    jugador(OtroJugador, Civilizacion, _),
    Jugador \= OtroJugador.

%Punto 4

tieneAlcanceGlobal(Tecnologia) :-
    tieneTecnologia(_,Tecnologia),
    forall(jugador(Jugador,_,_), tieneTecnologia(Jugador, Tecnologia)).

tieneTecnologia(Jugador, Tecnologia) :-
    jugador(Jugador, _, Tecnologias),
    member(Tecnologia, Tecnologias).
    
%Punto 5

esCivilizacionLider(Civilizacion) :-
    jugador(_,Civilizacion,_),
    findall(Tecnologia, alcanzoTecnologia(_,Tecnologia), TecnologiasOtrasCivilizaciones),
    desarrolloTecnologico(Civilizacion,TecnologiasOtrasCivilizaciones).


alcanzoTecnologia(Civilizacion, Tecnologia) :-
    jugador(Jugador, Civilizacion, _),
    tieneTecnologia(Jugador, Tecnologia).

desarrolloTecnologico(Civilizacion, Tecnologias) :-
    forall(member(Tecnologia, Tecnologias),alcanzoTecnologia(Civilizacion, Tecnologia)).

%Parte 2

unidades(ana, tropa(jinete, caballo)).
unidades(ana, tropa(piqueroNivel1)).
unidades(ana, tropa(piqueroNivel2)).

unidades(beto, tropa(campeon, 100)).
unidades(beto, tropa(campeon, 80)).
unidades(beto, tropa(piqueroNivel1, escudo)).
unidades(beto, tropa(jinete, camello)).

unidades(carola, tropa(piqueroNivel3)).
unidades(carola, tropa(piqueroNivel2, escudo)).

%unidadConMasVida(Jugador) :-
%    unidades(Jugador, Tropas),

cantidadDeVida(Tropa, Cantidad).
cantidadDeVida(jineteACaballo, 90).
cantidadDeVida(jineteACamello, 80).