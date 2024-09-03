% comida(Comida, Precio).
comida(hamburguesa, 2000).
comida(panchitoConPapas, 1500).
comida(lomitoCompleto, 2500).
comida(caramelos, 0).

atraccion(autitosChocadores, tranquila(niniosYAdultos)).
atraccion(casaEmbrujada, tranquila(niniosYAdultos)).
atraccion(laberinto, tranquila(niniosYAdultos)).
atraccion(tobogan, tranquila(niniosYAdultos)).
atraccion(calesita, tranquila(niniosYAdultos)).

atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

% montaniaRusa(Nombre, Giros, Duracion).
atraccion(abismoMortalRecargada, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

atraccion(acuatica(torpedoSalpicon)).
atraccion(acuatica(esperoQueHayasTraidoUnaMudaDeRopa)).

% visitante(Nombre, estadisticas(Hambre, Aburrimiento), GrupoFamiliar).
% edad(Visitante, Edad).
% dinero(Visitante, Dinero).
visitante(eusebio, estadisticas(50, 0)).
visitante(carmela, estadisticas(0, 25)).
visitante(jose, estadisticas(0, 0)).
visitante(sofia, estadisticas(25, 50)).
persona(Visitante) :-
    visitante(Visitante, _).

grupoFamiliar(eusebio, viejitos).
grupoFamiliar(carmela, viejitos).

edad(eusebio, 80).
edad(carmela, 80).
edad(sofia, 27).
edad(jose, 20).

dinero(eusebio, 30000).
dinero(jose, 10000).
dinero(carmela, 0).
dinero(sofia, 25000).

%2)
intervaloDeBienestar(Visitante, Maximo, Minimo) :-
    visitante(Visitante, estadisticas(Hambre, Aburrimiento)),
    Suma is Hambre + Aburrimiento,
    between(Minimo, Maximo, Suma).
    

estado(Visitante, felicidadPlena) :-
    vieneAcompaniado(Visitante),
    sumaEstadisticas(Visitante, 0).

estado(Visitante, podriaEstarMejor) :-
    vieneSolo(Visitante),
    sumaEstadisticas(Visitante, 0).

estado(Visitante, podriaEstarMejor) :-
    intervaloDeBienestar(Visitante, 1, 50).


estado(Visitante, necesitaEntretenerse) :-
    intervaloDeBienestar(Visitante, 51, 99).

estado(Visitante, seQuiereIrACasa) :-
    sumaEstadisticas(Visitante, Suma),
    Suma >= 100. 

sumaEstadisticas(Visitante, Suma) :-
    visitante(Visitante, estadisticas(Hambre, Aburrimiento)),
    Suma is Hambre + Aburrimiento.

vieneAcompaniado(Visitante) :-
    persona(Visitante),
    grupoFamiliar(Visitante, _).
vieneSolo(Visitante) :-
    persona(Visitante),
    not(vieneAcompaniado(Visitante)).

%3)
satisface(hamburguesa, Visitante) :-
    visitante(Visitante, estadisticas(Hambre, _)),
    Hambre < 50.
satisface(panchitoConPapas, Visitante) :-
    esChico(Visitante).
satisface(lomitoCompleto, _).
satisface(caramelos, Visitante) :-
    dinero(Visitante, Dinero),
    forall(comida(_, Precio), Precio >= Dinero).

esChico(Visitante) :-
    edad(Visitante, Edad),
    Edad < 13.

puedeSatisfacer(Grupo, Comida) :-
    comida(Comida, _),
    grupoFamiliar(_, Grupo),
    puedeComprar(Grupo, Comida),
    satisfaceSuHambre(Grupo, Comida).
puedeComprar(Grupo, Comida) :-
    comida(Comida, _),
    forall(grupoFamiliar(Visitante, Grupo), leAlcanza(Comida, Visitante)).

satisfaceSuHambre(Grupo, Comida) :-
    comida(Comida, _),
    forall(grupoFamiliar(Visitante, Grupo), satisface(Comida, Visitante)).

leAlcanza(Comida, Visitante) :-
    comida(Comida, Precio),
    dinero(Visitante, Dinero),
    Precio =< Dinero.

%4)
lluviaDeHamburguesas(Visitante, Atraccion) :-
    leAlcanza(hamburguesa, Visitante),
    atraccion(Atraccion, TipoDeAtraccion),
    tipoAtraccionComplicada(Visitante, TipoDeAtraccion).

tipoAtraccionComplicada(_, atraccion(_, intensa(CoeficienteLanzamiento))):-
    CoeficienteLanzamiento > 10.
tipoAtraccionComplicada(Visitante, MontaniaRusa) :-
    esPeligrosa(Visitante, MontaniaRusa).

tipoAtraccionComplicada(_, atraccion(tobogan, _)).

esPeligrosa(Visitante, montaniaRusa(Giros, _)) :-
    not(estado(Visitante, necesitaEntretenerse)),
    not(esChico(Visitante)),
    tieneMayorCantidadDeGiros(Giros).

esPeligrosa(Visitante, montaniaRusa(_, Duracion)) :-
    esChico(Visitante),
    Duracion > 60.

tieneMayorCantidadDeGiros(Giros) :-
    forall(atraccion(_, montaniaRusa(OtrosGiros, _)), Giros >= OtrosGiros).

%5)
opcionesDeEntretenimiento(Mes, Visitante, Opcion) :-
    persona(Visitante),
    alternativaDeEntretenimiento(Mes, Visitante, Opcion).

alternativaDeEntretenimiento(_, Visitante, Comida) :-
    leAlcanza(Comida, Visitante).
alternativaDeEntretenimiento(_, Visitante, Atraccion) :-
    atraccion(Atraccion, TipoAtraccionTranquila),
    puedeSubir(Visitante, TipoAtraccionTranquila).
alternativaDeEntretenimiento(_, Visitante, Atraccion) :- 
    atraccion(Atraccion, TipoAtraccionIntensa),
    not(esPeligrosa(Visitante, TipoAtraccionIntensa)).
alternativaDeEntretenimiento(Mes, _, Atraccion) :-
    atraccion(acuatica(Atraccion)),
    member(Mes, [septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]).
    

puedeSubir(_, tranquila(niniosYAdultos)).
puedeSubir(Visitante, tranquila(ninios)) :-
    grupoFamiliar(Grupo, Visitante),
    hayUnChico(Grupo),
    not(esChico(Visitante)).

hayUnChico(Grupo) :-
    grupoFamiliar(Grupo, Miembro),
    esChico(Miembro).
