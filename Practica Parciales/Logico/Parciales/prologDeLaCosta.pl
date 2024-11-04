%%%%%%%%%
%Punto 1%
%%%%%%%%%

%puestoDeComida(Comida, Precio).
puestoDeComida(hamburguesa, 2000).
puestoDeComida(panchitoConPapas, 1500).
puestoDeComida(lomitoCompleto, 2500).
puestoDeComida(caramelos, 0).

%atraccion(nombre, tranquila(alcance)).
atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(casaEmbrujada, tranquila(chicosYAdultos)).
atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

%atraccion(nombre, intensa(coeficienteDeLanzamiento)).
atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).
 
%atraccion(nombre, montaniaRusa(giros, duracionEnSegundos)).
atraccion(abismoMortal, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

%atraccion(nombre, acuatica).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica).
atraccion(torpedoSalpicon, acuatica).

%persona(nombre, edad, grupoFamiliar, estadisticas(plata, hambre, aburrimiento)).
persona(eusebio, estadisticas(3000, 50,  0)).
persona(carmela, estadisticas(   0,  0, 25)).
persona(pedro, estadisticas(100, 10, 20)).
persona(jorge, estadisticas(29, 100, 30)).

%grupoFamiliar(Persona, GrupoFamiliar).
grupoFamiliar(eusebio, viejitos).
grupoFamiliar(carmela, viejitos).

%edad(Persona, Edad).
edad(eusebio, 80).
edad(carmela, 80).

visitante(Visitante) :-
    persona(Visitante, _).

%%%%%%%%%
%Punto 2%
%%%%%%%%%

%bienestar(visitante, bienestar).
bienestar(Visitante, felicidadPlena) :-
    sumarSentimientos(Visitante, 0),
    vieneAcompaniado(Visitante).

bienestar(Visitante, podriaEstarMejor) :-
    sumarSentimientos(Visitante, 0),
    vieneSolo(Visitante).

bienestar(Visitante, podriaEstarMejor) :-
    sumarHambreYAburrimientoEntre(Visitante, 1, 50).

bienestar(Visitante, necesitaEntretenerse) :-
    sumarHambreYAburrimientoEntre(Visitante,51, 99).

bienestar(Visitante, seQuiereIrACasa) :-
    sumarSentimientos(Visitante, Sumatoria),
    Sumatoria >= 100.

sumarHambreYAburrimientoEntre(Visitante, Piso, Techo) :-
    sumarSentimientos(Visitante, Sumatoria),
    between(Piso, Techo, Sumatoria).

sumarSentimientos(Visitante, Sumatoria) :-
    persona(Visitante, estadisticas(_, Hambre, Aburrimiento)),
    Sumatoria is Hambre + Aburrimiento.

vieneSolo(Visitante) :-
    visitante(Visitante),
    not(vieneAcompaniado(Visitante)).
vieneAcompaniado(Visitante) :-
    visitante(Visitante),
    grupoFamiliar(Visitante, _).

%%%%%%%%%
%Punto 3%
%%%%%%%%%
puedeSatisfaser(Grupo, Comida) :-
    comida(Comida),
    grupo(Grupo),
    todosPuedenComprar(Grupo, Comida),
    leQuitaElHambreATodos(Comida, Grupo).

comida(Comida) :-
    puestoDeComida(Comida, _).

grupo(Grupo) :-
    grupoFamiliar(_, Grupo).

todosPuedenComprar(Grupo, Comida) :-
    forall(grupoFamiliar(Integrante, Grupo), puedeComprar(Integrante, Comida)).

puedeComprar(Integrante, Comida) :-
    persona(Integrante, estadisticas(Plata, _, _)),
    puestoDeComida(Comida, Precio),
    Plata >= Precio.

leQuitaElHambreATodos(Comida, Grupo) :-
    forall(grupoFamiliar(Integrante, Grupo), leQuitaElHambre(Comida, Integrante)).

leQuitaElHambre(hamburguesa, Visitante) :-
    hambre(Visitante, Hambre),
    Hambre < 50.
leQuitaElHambre(panchitoConPapas, Visitante) :-
    esChico(Visitante).
leQuitaElHambre(lomitoCompleto, _).
leQuitaElHambre(caramelos, Visitante) :-
    forall(comida(Comida), (not(puedeComprar(Visitante, Comida)), Comida \= caramelos)).

esChico(Visitante) :-
    edad(Visitante, Edad),
    Edad < 13.

hambre(Visitante, Hambre) :-
    persona(Visitante, estadisticas(_, Hambre, _)).

%%%%%%%%%
%Punto 4%
%%%%%%%%%
lluviaDeHamburguesas(Visitante, Atraccion) :-
    puedeComprar(Visitante, hamburguesa),
    atraccionVomitiva(Visitante, Atraccion).

atraccionVomitiva(_,tobogan).

atraccionVomitiva(Visitante, Atraccion) :-
    atraccion(Atraccion,TipoDeAtraccion),
    tipoAtraccionVomitiva(Visitante, TipoDeAtraccion).

tipoAtraccionVomitiva(_, intensa(coeficienteDeLanzamiento)):-
    coeficienteDeLanzamiento > 10.
tipoAtraccionVomitiva(Visitante, MontaniaRusa) :-
    esPeligrosa(Visitante, MontaniaRusa).

esPeligrosa(Visitante, montaniaRusa(Giros, _)) :-
    not(esChico(Visitante)),
    not(bienestar(Visitante, necesitaEntretenerse)),
    mayorCantidadDeGiros(Giros).

esPeligrosa(Visitante, montaniaRusa(_, Duracion)) :-
    esChico(Visitante),
    Duracion > 60.

mayorCantidadDeGiros(Giros) :-
    forall(atraccion(_, montaniaRusa(OtrosGiros,_)), OtrosGiros =< Giros).

%%%%%%%%%
%Punto 5%
%%%%%%%%%

opcionesDeEntretenimiento(Mes, Visitante, Opcion) :-
    visitante(Visitante),
    alternativaDeEntretenimiento(Mes, Visitante, Opcion).

alternativaDeEntretenimiento(_, Visitante, Comida) :-
    puedeComprar(Visitante, Comida).

alternativaDeEntretenimiento(_, Visitante, Atraccion) :-
    atraccion(Atraccion, tranquila(FranjaEtaria)),
    puedeAcceder(Visitante, FranjaEtaria).

alternativaDeEntretenimiento(_, _, Atraccion) :-
    atraccion(Atraccion, intensa(_)).

alternativaDeEntretenimiento(_, Visitante, Atraccion) :-
    atraccion(Atraccion, MontaniaRusa),
    not(esPeligrosa(Visitante, MontaniaRusa)).

alternativaDeEntretenimiento(Mes, _, Atraccion) :-
    atraccion(Atraccion, acuatica),
    member(Mes, [septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]).
    
puedeAcceder(Visitante, chicos) :-
    esChico(Visitante).
puedeAcceder(Visitante, chicos) :-
    grupoFamiliar(Visitante, Grupo),
    not(esChico(Visitante)),
    hayAlgunChico(Grupo).
puedeAcceder(_, chicosYAdultos).

hayAlgunChico(Grupo) :-
    grupoFamiliar(Visitante, Grupo),
    esChico(Visitante).
