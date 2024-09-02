%tarea(agente, tarea, ubicacion)
%tareas:
% ingerir(descripcion, tamaño, cantidad)
% apresar(malviviente, recompensa)
% asuntosInternos(agenteInvestigado)
% vigilar(listaDeNegocios)
tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles).
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

%jefe(jefe, subordinado)
jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).

%1)
frecuenta(_, buenosAires).
frecuenta(Agente, Ubicacion) :-
    tarea(Agente, _, Ubicacion).
frecuenta(vega, quilmes).
frecuenta(Agente, marDelPlata) :-
    tarea(Agente, vigilar(Negocios), _),
    member(negocioAlfajores, Negocios).

%2)
inaccesible(Ubicacion) :-
    ubicacion(Ubicacion),
    not(frecuenta(_, Ubicacion)).

%3)
afincado(Agente) :-
    tarea(Agente, _, Ubicacion),
%    not(hayOtraUbicacion(Agente, Ubicacion)).
    forall(tarea(Agente, _, OtraUbicacion), sonIguales(Ubicacion, OtraUbicacion)).

sonIguales(Ubicacion, Ubicacion).

%4) XD

%5)
agentePremiado(Agente) :-
    puntos(Agente, Cuantos),
    forall(puntos(_, OtrosCuantos), Cuantos >= OtrosCuantos).

puntos(Agente, Cuantos) :-
    tarea(Agente, Tarea, _),
    findall(Puntos, puntosPorTarea(Tarea, Puntos), ListaPuntos),
    sum_list(ListaPuntos, Cuantos).

puntosPorTarea(vigilar(Negocios), Puntos) :-
    length(Negocios, CuantosNegocios),
    Puntos is 5 * CuantosNegocios.
puntosPorTarea(ingerir(_, Tamanio, Cantidad), Puntos) :-
    Puntos is (Tamanio * Cantidad) * (-10).
puntosPorTarea(apresar(_, Recompensa), Puntos) :-
    Puntos is Recompensa / 2.
puntosPorTarea(asuntosInternos(AgenteInvestigado), Puntos) :-
    puntos(AgenteInvestigado, Cuantos),
    Puntos is Cuantos * 2.

%6)
% El polimorfismo se utiliza para poder realizar modificaciones a nuestro programa aprovechando la logica de los predicados ya realizados.
% El orden superior se utiliza para 