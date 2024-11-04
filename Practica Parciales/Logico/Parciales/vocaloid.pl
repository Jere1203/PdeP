%a)
%cancion(Nombre, Duracion (en minutos)).
cancion(nigthFever, 4).
cancion(nigthFever, 5).
cancion(foreverYoung, 5).
cancion(tellYourWorld, 4).
cancion(tellYourWorld, 5).
cancion(novemberRain, 6).

%cantante(Cantante).
cantante(kaito).
cantante(Cantante) :-
    canta(Cantante, _).

%canta(Cantante, Cancion).
canta(megurineLuka, cancion(nigthFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).

canta(hatsuneMiku, cancion(tellYourWorld, 4)).

canta(gumi, cancion(novemberRain, 6)).
canta(gumi, cancion(tellYourWorld, 5)).

canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nigthFever, 5)).

%1)
esNovedoso(Cantante) :-
    canta(Cantante, UnaCancion),
    canta(Cantante, OtraCancion),
    UnaCancion \= OtraCancion,
    duracionTotal(Cantante, Duracion),
    Duracion < 15.

duracionTotal(Cantante, Duracion) :-
    findall(Duracion, canta(Cantante, cancion(_, Duracion)), Duraciones),
    sum_list(Duraciones, Duracion).
    
%2)
esAcelerado(Cantante) :-
    canta(Cantante, cancion(Cancion, Duracion)),
    Duracion =< 4,
    not(tieneCancionLarga(Cantante, Cancion)).
tieneCancionLarga(Cantante, Cancion) :-
    canta(Cantante, cancion(OtraCancion, Duracion)),
    Duracion > 4,
    Cancion \= OtraCancion.

%3)
%concierto(Nombre, Pais, Fama, Tipo)
%gigante(CantCanciones, DuracionMinima)
%mediano(DuracionMaxima).
%pequenio(Duracion).

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

%4)
puedeParticipar(miku,Concierto) :-
    concierto(Concierto, _, _, _).
puedeParticipar(Cantante, Concierto) :-
    cantante(Cantante),
    concierto(Concierto, _, _, Requisitos),
    cumpleRequisito(Cantante, Requisitos).
cumpleRequisito(Cantante, gigante(MinimoCanciones, DuracionMinima)) :-
    duracionTotal(Cantante, DuracionTotal),
    DuracionTotal > DuracionMinima,
    cantidadCanciones(Cantante, Cantidad),
    Cantidad >= MinimoCanciones.
cumpleRequisito(Cantante, mediano(DuracionMaxima)) :-
    duracionTotal(Cantante, Duracion),
    Duracion < DuracionMaxima.
cumpleRequisito(Cantante, pequenio(DuracionMinima)) :-
    canta(Cantante, cancion(_, Duracion)),
    Duracion > DuracionMinima.

cantidadCanciones(Cantante, Cantidad) :-
    findall(Cancion, canta(Cantante, Cancion), Canciones),
    length(Canciones, Cantidad).

%3)
masFamoso(Cantante) :-
    cantidadFama(Cantante, Cantidad),
    forall(cantidadFama(_, OtraCantidad), Cantidad >= OtraCantidad).

cantidadFama(Cantante, Cantidad) :-
    famaTotal(Cantante, FamaTotal),
    cantidadCanciones(Cantante, Canciones),
    Cantidad is FamaTotal * Canciones.

famaTotal(Cantante, Cuanta) :-
    puedeParticipar(Cantante, Concierto),
    findall(Fama, famaConcierto(Concierto, Fama), ListaFamas),
    sum_list(ListaFamas, Cuanta).

famaConcierto(Concierto, Fama) :-
    concierto(Concierto, _, Fama, _).

%4)
conoceA(megurineLuka, hatsuneMiku).
conoceA(megurineLuka, gumi).

conoceA(gumi, seeU).
conoceA(seeU, kaito).

esElUnicoParticipante(Cantante, Concierto) :-
    conciertoEnQueParticipa(Cantante, Concierto),
    not(hayOtroCantanteQueConozca(Cantante, Concierto)).

conciertoEnQueParticipa(Cantante, Concierto) :-
    cantante(Cantante),
    puedeParticipar(Cantante, Concierto).

hayOtroCantanteQueConozca(Cantante, Concierto) :-
    conoceA(Cantante, OtroCantante),
    conciertoEnQueParticipa(OtroCantante, Concierto),
    Cantante \= OtroCantante.

%5)
% Si hay un nuevo tipo de concierto se debería añadir un nuevo functor para el predicado concierto/4 y añadir una cláusula para cumpleRequisito/2.
% Esta implementacion se ve facilitada por el concepto de polimorfismo, que nos permite hacer los cambios necesarios sin necesidad de realizar mayores cambios en
% la estructura del código