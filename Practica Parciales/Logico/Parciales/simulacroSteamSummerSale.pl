% Acá va el código

%1)
% accion(nombre).
% rol(jugadoresActivos).
% puzzle(cantidadNiveles, dificultad).
% precio(Juego, Precio). (Precio en AR$)
% oferta(Juego, PorcentajeOferta).

%juego(callOfDuty).
%juego(metalSlug).
%juego(juegoPuzzle).
%juego(fallout).
%juego(minecraft).
%juego(counterStrike).

%juego(accion(Nombre)).
%juego(rol(Nombre, UsuariosActivos)).
%juego(puzzle(Nombre, CantidadNiveles, Dificultad)).

%juego(accion(callOfDuty)).
%juego(rol(fallout, 20000000)).
%juego(puzzle(metalSlug, 30, dificil)).
%juego(puzzle(juegoPuzzle, 15, facil)).
%
%genero(callOfDuty, accion(callOfDuty)).
%genero(fallout, rol(2000000)).
%genero(metalSlug, puzzle(30, dificil)).
%genero(juegoPuzzle, puzzle(15, facil)).

juego(callOfDuty, caracteristicas(accion)).
juego(fallout, caracteristicas(rol, 2000000)).
juego(metalSlug, caracteristicas(puzzle, 30, dificil)).
juego(juegoPuzzle, caracteristicas(puzzle, 15, facil)).

genero(Juego, Genero) :-
    juego(Juego, caracteristicas(Genero)).
genero(Juego, Genero) :-
    juego(Juego, caracteristicas(Genero,_)).
genero(Juego, Genero) :-
    juego(Juego, caracteristicas(Genero, _, _)). 

precio(callOfDuty, 100000).
precio(metalSlug, 10000).
precio(juegoPuzzle, 50000).
precio(minecraft, 25000).
precio(counterStrike, 50000).

oferta(callOfDuty, 50).
oferta(metalSlug, 15).

% wishlist(Usuario, paraSi(Juego).
% wishlist(Usuario, paraRegalar(Juego)).
% usuario(Usuario).

usuario(jorgitoPro).
usuario(santi29).
usuario(maniGames).
usuario(provoleta).

tieneJuego(jorgitoPro, callOfDuty).
tieneJuego(jorgitoPro, minecraft).
tieneJuego(jorgitoPro, counterStrike).
tieneJuego(santi29, minecraft).
tieneJuego(santi29, counterStrike).
tieneJuego(maniGames, metalSlug).
tieneJuego(maniGames, juegoPuzzle).
tieneJuego(provoleta, callOfDuty).

wishlist(jorgitoPro, paraRegalar(fallout)).
wishlist(jorgitoPro, paraRegalar(callOfDuty)).
wishlist(jorgitoPro, paraRegalar(metalSlug)).
wishlist(jorgitoPro, paraSi(juegoPuzzle)).
wishlist(santi29, paraRegalar(minecraft)).



%2)

cuantoSale(Juego, Cuanto) :-
    oferta(Juego, PorcentajeDescuento),
    precio(Juego, Precio),
    precioFinal(Precio, PorcentajeDescuento, Cuanto).
cuantoSale(Juego, Cuanto) :-
    precio(Juego, Cuanto),
    not(oferta(Juego, _)).

precioFinal(Precio, PorcentajeDescuento, Cuanto) :-
    Cuanto is (Precio * PorcentajeDescuento) / 100.

tieneBuenDescuento(Juego) :-
    oferta(Juego, PorcentajeDescuento),
    PorcentajeDescuento >= 50.

juegoPopular(minecraft).
juegoPopular(counterStrike).
juegoPopular(Juego) :-
    juego(Juego, Caracteristicas),
    tipoDeJuegoPopular(Juego, Caracteristicas).
tipoDeJuegoPopular(_, accion(_)).
tipoDeJuegoPopular(_, caracteristicas(rol, UsuariosActivos)) :-
    UsuariosActivos > 1000000.
tipoDeJuegoPopular(_, caracteristicas(puzzle, 25, _)).
tipoDeJuegoPopular(_, caracteristicas(puzzle, _, facil)).


adictoALosDescuentos(Usuario) :-
    wishlist(Usuario, Juego),
    tieneBuenDescuento(Juego),
    not(tieneOtroJuegoConBuenDescuento(Usuario, Juego)).

tieneOtroJuegoConBuenDescuento(Usuario, Juego) :-
    wishlist(Usuario, OtroJuego),
    tieneBuenDescuento(OtroJuego),
    Juego \= OtroJuego.

fanatico(Usuario, Genero) :-
    tieneJuego(Usuario, Juego),
    tieneJuego(Usuario, OtroJuego),
    genero(Juego, Genero),
    genero(OtroJuego, Genero),
    Juego \= OtroJuego.

monotematico(Usuario, Genero) :-
    tieneJuego(Usuario, Juego),
    genero(Juego, Genero),
    forall(tieneJuego(Usuario, OtroJuego), tieneMismoGenero(Juego, OtroJuego)).

tieneMismoGenero(Genero, Genero).

buenosAmigos(Usuario1, Usuario2) :-
    quiereRegalarJuegosPopulares(Usuario1),
    quiereRegalarJuegosPopulares(Usuario2),
    Usuario1 \= Usuario2.

quiereRegalarJuegosPopulares(Usuario) :-
    wishlist(Usuario, paraRegalar(Juego)),
    not(tieneUnJuegoNoPopularParaRegalar(Usuario, Juego)).

tieneUnJuegoNoPopularParaRegalar(Usuario, Juego) :-
    wishlist(Usuario, paraRegalar(OtroJuego)),
    not(juegoPopular(OtroJuego)),
    OtroJuego \= Juego.

gasta(Usuario, Cuanto) :-
    precioWishlist(Usuario, _),
    findall(Precio, precioWishlist(Usuario, Precio), ListaPrecios),
    sum_list(ListaPrecios, Cuanto).
    

precioWishlist(Usuario, Precio) :-
    wishlist(Usuario, paraRegalar(Juego)),
    cuantoSale(Juego, Precio).
precioWishlist(Usuario, Precio) :-
    wishlist(Usuario, paraSi(Juego)),
    cuantoSale(Juego, Precio).
