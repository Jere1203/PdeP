personaje(pumkin, ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent, mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).

pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

%1)
esPeligroso(Personaje) :-
    realizaActividadPeligrosa(Personaje).
esPeligroso(Personaje) :-
    trabajaPara(Personaje, Empleado),
    realizaActividadPeligrosa(Empleado).

realizaActividadPeligrosa(Personaje) :-
    personaje(Personaje, ladron(TipoDeRobo)),
    member(licorerias, TipoDeRobo).
realizaActividadPeligrosa(Personaje) :-
    personaje(Personaje, mafioso(maton)).
    
%2)
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(Personaje1, Personaje2) :-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2),
    sonParejaOAmigos(Personaje1, Personaje2),
    Personaje1 \= Personaje2.

sonParejaOAmigos(Personaje1, Personaje2) :-
    pareja(Personaje1, Personaje2).
sonParejaOAmigos(Personaje1, Personaje2) :-
    amigo(Personaje1, Personaje2).

%3)
estaEnProblemas(Personaje) :-
    trabajaPara(Empleador, Personaje),
    esPeligroso(Empleador),
    pareja(Empleador, Pareja),
    encargo(Empleador, Personaje, cuidar(Pareja)).
estaEnProblemas(Personaje) :-
    encargo(_, Personaje, buscar(Quien, _)),
    personaje(Quien, boxeador).

estaEnProblemas(butch).

%encargo(Solicitante, Encargado, Tarea).
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent, cuidar(mia)).
encargo(vincent, elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

%4)
sanCayetano(Personaje) :-
    tieneCerca(Personaje, _),
    forall(tieneCerca(Personaje, OtroPersonaje), encargo(Personaje, OtroPersonaje, _)),
    Personaje \= OtroPersonaje.

tieneCerca(Personaje, OtroPersonaje) :-
    amigo(Personaje, OtroPersonaje).
tieneCerca(Personaje, OtroPersonaje) :-
    trabajaPara(Personaje, OtroPersonaje).

%5)
masAtareado(Personaje) :-
    encargos(Personaje, Cuantos),
    forall(encargos(_, OtrosCuantos), Cuantos >= OtrosCuantos).

encargos(Personaje, Cuantos) :-
    personaje(Personaje, _),
    findall(Encargo, encargo(_, Personaje, Encargo), ListaEncargos),
    length(ListaEncargos, Cuantos).
    
%6)
personajesRespetables(ListaRespetables) :-
    findall(Personaje, personajeRespetable(Personaje), ListaRespetables).

personajeRespetable(Personaje) :-
    personaje(Personaje, Actividad),
    nivelRespeto(Actividad, Cuanto),
    Cuanto > 9.

nivelRespeto(actriz(Peliculas), Cuanto) :-
    length(Peliculas, CantidadPeliculas),
    Cuanto is CantidadPeliculas / 10.
nivelRespeto(mafioso(resuelveProblemas), 10).
nivelRespeto(mafioso(maton), 1).
nivelRespeto(mafioso(capo), 20).

%7)
hartoDe(Personaje, OtroPersonaje) :-
    personaje(Personaje, _),
    encargo(_, OtroPersonaje, _),
    forall(encargo(Personaje, OtroPersonaje, Encargo), esEncargoHartante(Personaje, Encargo)),
    Personaje \= OtroPersonaje.

esEncargoHartante(Personaje, Encargo) :-
    tipoEncargoHartante(Personaje, Encargo).
esEncargoHartante(Personaje, Encargo) :-
    amigo(Personaje, Amigo),
    tipoEncargoHartante(Amigo, Encargo).

% tipoEncargoHartante(Solicitante, AQuien).
tipoEncargoHartante(Personaje, ayudar(Personaje)).
tipoEncargoHartante(Personaje, cuidar(Personaje)).
tipoEncargoHartante(Personaje, buscar(Personaje, _)). 

%8)
caracteristicas(vincent, [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules, [tieneCabeza, muchoPelo]).
caracteristicas(marvin, [negro]).

duoDiferenciable(Personaje1, Personaje2) :-
    caracteristicas(Personaje1, Caracteristicas),
    caracteristicas(Personaje2, _),
    amigosOPareja(Personaje1, Personaje2),
    forall(caracteristicas(Personaje2, OtrasCaracteristicas), not(sonIguales(Caracteristicas, OtrasCaracteristicas))).

sonIguales(Caracteristicas, Caracteristicas).

amigosOPareja(Personaje1, Personaje2) :-
    amigo(Personaje1, Personaje2).
amigosOPareja(Personaje1, Personaje2) :-
    pareja(Personaje1, Personaje2).