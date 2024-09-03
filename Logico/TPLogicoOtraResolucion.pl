%Punto 1

jugador(ana, romanos, [herreria, forja, emplumado, laminas, fundicion]).
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

unidades(ana, jineteACaballo).
unidades(ana, piquero(conEscudo, 1)).
unidades(ana, piquero(sinEscudo, 2)).
unidades(beto, campeon(100)).
unidades(beto, campeon(80)).
unidades(beto, piquero(conEscudo, 1)).
unidades(beto, jineteACamello).
unidades(carola, piquero(sinEscudo, 3)).
unidades(carola, piquero(conEscudo, 2)).

%No se modela a Dimitri ya que no posee unidades.

unidadConMasVida(Jugador, Unidad) :-
    unidades(Jugador, Unidad),
    vidaUnidad(Unidad, Vida),
    forall(vidaUnidades(Jugador, OtraVida), Vida >= OtraVida).

vidaUnidades(Jugador, Vida) :-
    unidades(Jugador, Unidad),
    vidaUnidad(Unidad, Vida).

vidaUnidad(jineteACamello, 80).
vidaUnidad(jineteACaballo, 90).
vidaUnidad(campeon(Vida), Vida).
vidaUnidad(piquero(sinEscudo, 1), 50).
vidaUnidad(piquero(sinEscudo, 2), 65).
vidaUnidad(piquero(sinEscudo, 3), 70).
vidaUnidad(piquero(conEscudo, Nivel), Vida) :-
    vidaUnidad(piquero(sinEscudo, Nivel), Cuanta),
    Vida is (Cuanta * 1.10).

%3)
tieneVentaja(jineteACaballo, campeon(_)).
tieneVentaja(jineteACamello, campeon(_)).
tieneVentaja(campeon(_), piquero(_, _)).
tieneVentaja(piquero(_, _), jineteACaballo).
tieneVentaja(piquero(_, _), jineteACamello).
tieneVentaja(jineteACamello, jineteACaballo).

gana(Unidad, OtraUnidad) :-
    not(tieneVentaja(OtraUnidad, Unidad)),
    tieneMasVida(Unidad, OtraUnidad).

tieneMasVida(Unidad, OtraUnidad) :-
    vidaUnidad(Unidad, Cantidad),
    vidaUnidad(OtraUnidad, OtraCantidad),
    Cantidad > OtraCantidad,
    Unidad \= OtraUnidad.

%4)
sobreviveAAsedio(Jugador) :-
    cantidadTropa(Jugador, piquero(conEscudo, _), Cantidad),
    cantidadTropa(Jugador, piquero(sinEscudo, _), OtraCantidad),
    Cantidad > OtraCantidad.

cantidadTropa(Jugador, Tropa, Cantidad) :-
    unidades(Jugador, _),
    findall(Tropa, unidades(Jugador, Tropa), ListaTropas),
    length(ListaTropas, Cantidad).
    
%5)
% dependencia(tecnologia, dependencia).
dependencia(herreria).
dependencia(molino).
dependencia(emplumado, herreria).
dependencia(forja, herreria).
dependencia(laminas, herreria).
dependencia(punzon, emplumado).
dependencia(fundicion, forja).
dependencia(malla, laminas).
dependencia(horno, fundicion).
dependencia(placas, malla).
dependencia(collera, molino).
dependencia(arado, collera).

puedeDesarrollar(Jugador, Tecnologia) :-
    dependencia(Tecnologia),
    not(tieneTecnologia(Jugador, Tecnologia)).
puedeDesarrollar(Jugador, Tecnologia) :-
    dependencia(Tecnologia, Dependencia),
    tieneTecnologia(Jugador, Dependencia),
    not(tieneTecnologia(Jugador, Tecnologia)).
