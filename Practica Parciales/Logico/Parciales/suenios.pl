cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).

cree(juan, conejoDePascua).

cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

suenio(gabriel, ganarLoteria([5, 9])).
suenio(gabriel, serFutbolista(arsenal)).

suenio(juan, serCantante(100000)).

suenio(macarena, serCantante(10000)).

% Se utilizaron functores para relacionar el sueño que tiene cada persona

%2)
esAmbicioso(Persona) :-
    suenio(Persona, _),
    sumaDificultades(Persona, Suma),
    Suma > 20.

sumaDificultades(Persona, Suma) :-
    suenio(Persona, _),
    findall(CantidadDificultad, dificultadPorSuenio(Persona, CantidadDificultad), ListaDificultades),
    sum_list(ListaDificultades, Suma).

dificultadPorSuenio(Persona, Cuanta) :-
    suenio(Persona, Suenio),
    tipoDeSuenio(Suenio, Cuanta).

tipoDeSuenio(serCantante(CuantosDiscos), 6) :-
    CuantosDiscos > 500000.
tipoDeSuenio(serCantante(CuantosDiscos), 4) :-
    CuantosDiscos =< 500000.
tipoDeSuenio(ganarLoteria(Numeros), Cuanta) :-
    length(Numeros, CantidadNumeros),
    Cuanta is 10 * CantidadNumeros.
tipoDeSuenio(serFutbolista(Equipo), 3) :-
    equipoChico(Equipo).
tipoDeSuenio(serFutbolista(Equipo), 16) :-
    not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

%3)
tienenQuimica(Persona, campanita) :-
    cree(Persona, campanita),
    dificultadPorSuenio(Persona, Dificultad),
    Dificultad < 5.
tienenQuimica(Persona, Personaje) :-
    cree(Persona, Personaje),
    not(esAmbicioso(Persona)),
    suenio(Persona, Suenio),
    esSuenioPuro(Suenio),
    not(tieneSuenioImpuro(Persona, Suenio)).

tieneSuenioImpuro(Persona, Suenio) :-
    suenio(Persona, OtroSuenio),
    not(esSuenioPuro(OtroSuenio)),
    Suenio \= OtroSuenio.

esSuenioPuro(Suenio) :-
    tipoSuenioPuro(Suenio).

tipoSuenioPuro(serFutbolista(_)).
tipoSuenioPuro(serCantante(CantidadDeDiscos)) :-
    CantidadDeDiscos < 200000.

%4)
amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).

amigo(conejoDePascua, cavenaghi).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).

puedeAlegrar(Personaje, Persona) :-
    suenio(Persona, _),
    tienenQuimica(Persona, Personaje),
    hayAlguienDisponible(Personaje).

hayAlguienDisponible(Personaje) :-
    not(enfermo(Personaje)).
hayAlguienDisponible(Personaje) :-
    enfermo(Personaje),
    amigo(Personaje, Amigo),
    hayAlguienDisponible(Amigo).