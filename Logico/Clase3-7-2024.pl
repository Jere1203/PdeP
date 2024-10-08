% pelicula/2 (pelicula,genero)

pelicula(losVengadores,accion).
pelicula(lalaLand,musical).
pelicula(americanPsycho,thriller).
pelicula(starWarsAmenazaFantasma,ciencaFiccion).
pelicula(mentirasVerdaderas,comedia).
pelicula(elResplandor, thriller).
pelicula(cloverfield, thriller).
pelicula(oppenheimer, drama).
pelicula(toyStory, musical).
pelicula(wallaceYGrommit, ciencaFiccion).

%asesinato/3 (Pelicula, Asesino, Victima)
asesinato(americanPsycho, patrickBateman, paulAllen).
asesinato(elResplandor, jack, elJardinero).

%cancion/2 (Pelicula, Cancion)
cancion(toyStory, yoSoyTuAmigoFiel).
cancion(toyStory, cambiosExtranios).
cancion(toyStory, noNavegareNuncaMas).

%anio/2 (Pelicula, Anio)
anio(starWarsAmenazaFantasma, 3200).
anio(wallaceYGrommit, 1989).

%segmentos/2 (Pelicula, Segmento).
segmentos(Pelicula, casorio).
segmentos(Pelicula, funeral).
segmentos(Pelicula, peleas).
segmentos(Pelicula, mediosHermanos).
segmentos(Pelicula, enganio).


%critica/2 (Pelicula, Estrellas)
critica(losVengadores,3).
critica(lalaLand,5).
critica(americanPsycho,4).
critica(starWarsAmenazaFantasma,1).
critica(mentirasVerdaderas,2).
critica(starWarsAmenazaFantasma,2).

% trabajaEn/2 (pelicula,actor)
trabajaEn(losVengadores,robertDowneyJr).
trabajaEn(losVengadores,chrisEvans).
trabajaEn(lalaLand,emmaStones).
trabajaEn(lalaLand,ryanGhostling).
trabajaEn(americanPsycho,christianBale).
trabajaEn(starWarsAmenazaFantasma,nataliePortman).
trabajaEn(mentirasVerdaderas,arnoldSchwarzenegger).
trabajaEn(mentirasVerdaderas,jamieLeeCurtie).
trabajaEn(mentirasVerdaderas,tomArnold).

%premio/2 (actor/actriz,premio)
premio(emmaStones,mejorActriz).
premio(nataliePortman,mejorActriz).
premio(arnoldSchwarzenegger,mejorMusculo).
premio(christianBale,mejorBatman).


% imperdible: no hay actores que no hayan ganado algun premio

imperdible(Pelicula) :-
    pelicula(Pelicula,_),
    not(actoresQueNoGanaronALgunPremio(Pelicula)).

actoresQueNoGanaronALgunPremio(Pelicula) :-
    trabajaEn(Pelicula,Actor),  %p(x)
    not(premio(Actor,_)).       %~q(x)

% imperdible: todos los actores ganaron algun premio
% forall/2 (antecedente,consecuente)

imperdible2(Pelicula):-
    pelicula(Pelicula, _),
    forall(trabajaEn(Pelicula, Actor), premio(Actor, _)).
%     Unificadas       ^         ^
% (actuan como "uno")--|    Sin unificar
%                        (actuan como "todos")

%actorDramatico/1 si todas las pelis donde trabajó son de drama
actorDramatico(Actor):-
    trabajaEn(_, Actor),
    forall(trabajaEn(Pelicula,Actor), esDeDrama(Pelicula)).

esDeDrama(Pelicula):-
    pelicula(Pelicula,drama).

%aclamada/1: todas las críticas de la peli son 4 o 5
%critica(Pelicula, Estrellas).

aclamada(Pelicula):-
    pelicula(Pelicula, _),
    forall(critica(Pelicula, Estrellas), Estrellas >= 4).

%pochoclera/1: todas las críticas de la peli son 2 o 3
pochoclera(Pelicula):-
    pelicula(Pelicula, _),
    forall(critica(Pelicula,Estrellas),criticaPochoclera(Estrellas)).

criticaPochoclera(2).
criticaPochoclera(3).

%mala/1: todas sus críticas tienen una estrella

mala(Pelicula):-
    pelicula(Pelicula, _),
    forall(critica(Pelicula,Estrellas),criticaMala(Estrellas)).

criticaMala(1). 

%selectivo/1: todas las peliculas en las que actua un actor/actriz son imperdibles

selectivo(Actor) :-
    trabajaEn(_, Actor),
    forall(trabajaEn(Pelicula,Actor), imperdible2(Pelicula)).

%unanime/1: todas las criticas de la pelicula son el mismo puntaje
unanime(Pelicula):-
    critica(Pelicula, Puntaje),
    forall(critica(Pelicula, OtroPuntaje), sonIguales(Puntaje, OtroPuntaje)).

sonIguales(Puntaje, Puntaje).
    
%mejorCritica/2: la crítica más alta para una peli
mejorCritica(Pelicula, MejorCritica):-
    critica(Pelicula,MejorCritica),
    forall(critica(Pelicula,Critica), MejorCritica >= Critica).

culebronMexicano(Pelicula) :-
    segmentos(Pelicula, casorio),
    segmentos(Pelicula, mediosHermanos),
    segmentos(Pelicula, funeral),
    segmentos(Pelicula, peleas).

futurista(Pelicula) :-
    anio(Pelicula, Anio),
    Anio >= 3000.

puroSuspenso(Pelicula) :-
    pelicula(Pelicula, thriller),
    not(asesinato(Pelicula, _, _)).

asesinoSerial(Pelicula, Asesino) :-
    pelicula(Pelicula, thriller),
    asesinato(Pelicula, Asesino, _),
    forall(asesinato(Pelicula, OtroAsesino, _), sonElMismoAsesino(Asesino,OtroAsesino)).

%asesinoSerialBis(Pelicula, Asesino) :-
%    asesinato(Pelicula, Asesino, _),
%    not(asesinato(Pelicula, OtroAsesino, _)),
%    Asesino \= OtroAsesino.

sonElMismoAsesino(Asesino, Asesino).

slasher(Pelicula) :-
    pelicula(Pelicula, thriller),
    asesinatosDe(Pelicula, Cantidad),
    Cantidad >= 5.

asesinatosDe(Pelicula, Cantidad) :-
    pelicula(Pelicula, thriller),
    asesinato(Pelicula, UnAsesino, Victima),
    findall(Victima, asesinato(Pelicula, UnAsesino, Victima), Victimas),
    length(Victimas, Cantidad).