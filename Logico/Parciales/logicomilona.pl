% receta(Plato, Duración, Ingredientes)
receta(empanadaDeCarneFrita, 20, [harina, carne, cebolla, picante, aceite]).
receta(empanadaDeCarneAlHorno, 20, [harina, carne, cebolla, picante]).
receta(lomoALaWellington, 125, [lomo, hojaldre, huevo, mostaza]).
receta(pastaTrufada, 40, [spaghetti, crema, trufa]).
receta(souffleDeQueso, 35, [harina, manteca, leche, queso]).
receta(tiramisu, 30, [vainillas, cafe, mascarpone]).
receta(rabas, 20, [calamar, harina, sal]).
receta(parrilladaDelMar, 40, [salmon, langostinos, mejillones]).
receta(sushi, 30, [arroz, salmon, sesamo, algaNori]).
receta(hamburguesa, 15, [carne, pan, cheddar, huevo, panceta, trufa]).
receta(padThai, 40, [fideos, langostinos, vegetales]).

% elabora(Chef, Plato)
elabora(guille, empanadaDeCarneFrita).
elabora(guille, empanadaDeCarneAlHorno).
elabora(vale, rabas).
elabora(vale, tiramisu).
elabora(vale, parrilladaDelMar).
elabora(ale, hamburguesa).
elabora(lu, sushi).
elabora(mar, padThai).

% cocinaEn(Restaurante, Chef)
cocinaEn(pinpun, guille).
cocinaEn(laPececita, vale).
cocinaEn(laParolacha, vale).
cocinaEn(sushiRock, lu).
cocinaEn(olakease, lu).
cocinaEn(guendis, ale).
cocinaEn(cantin, mar).

% tieneEstilo(Restaurante, Estilo)
tieneEstilo(pinpun, bodegon(parqueChas, 6000)).
tieneEstilo(laPececita, bodegon(palermo, 20000)).
tieneEstilo(laParolacha, italiano(15)).
tieneEstilo(sushiRock, oriental(japon)).
tieneEstilo(olakease, oriental(japon)).
tieneEstilo(cantin, oriental(tailandia)).
tieneEstilo(cajaTaco, mexicano([habanero, rocoto])).
tieneEstilo(guendis, comidaRapida(5)).

% italiano(CantidadDePastas)
% oriental(País)
% bodegon(Barrio, PrecioPromedio)
% mexicano(VariedadDeAjies)
% comidaRapida(cantidadDeCombos)

restaurante(Restaurante) :-
    cocinaEn(Restaurante, _).

%Punto 1
esCrack(Chef) :-
    cocinaEn(Restaurante, Chef),
    cocinaEn(OtroRestaurante, Chef),
    Restaurante \= OtroRestaurante.

esCrack(Chef) :-
    elabora(Chef, padThai).

%Punto 2
esOtaku(Chef) :-
    cocinaEn(Resto, Chef),
    esRestauranteJapones(Resto).

esRestauranteJapones(Restaurante) :-
    cocinaEn(Restaurante,_),
    forall(cocinaEn(Restaurante, _), tieneEstilo(Restaurante, oriental(japon))).
    
%Punto 3
esTop(Plato) :-
    elabora(Chef, Plato),
    forall(elabora(Chef, _), esCrack(Chef)).

%Punto 4
esDificil(Plato) :-
    receta(Plato, Duracion,_),
    Duracion > 120.
esDificil(Plato) :-
    receta(Plato, _, Ingredientes),
    member(trufa, Ingredientes).
esDificil(souffleDeQueso).

%Punto 5
seMereceLaMichelin(Restaurante) :-
    restaurante(Restaurante),
    tieneChefCrack(Restaurante),
    tieneEstiloMichelinero(Restaurante).

tieneChefCrack(Restaurante) :-
    cocinaEn(Restaurante, Chef),
    esCrack(Chef).

tieneEstiloMichelinero(Restaurante) :-
    tieneEstilo(Restaurante, oriental(tailandia)).

tieneEstiloMichelinero(Restaurante) :-
    tieneEstilo(Restaurante, bodegon(palermo,_)).

tieneEstiloMichelinero(Restaurante) :-
    esItalianoYTieneMasDeCincoPastas(Restaurante).

tieneEstiloMichelinero(Restaurante) :-
    tieneEstilo(Restaurante, mexicano(Ajies)),
    member(habanero, Ajies),
    member(rocoto, Ajies).

tieneEstiloMichelinero(Restaurante) :-
    not(tieneEstilo(Restaurante, comidaRapida(_))).

esItalianoYTieneMasDeCincoPastas(Restaurante) :-
    findall(Pasta, tieneEstilo(Restaurante, italiano(Pasta)), Pastas),
    length(Pastas, Cuantas),
    Cuantas > 5.

%Punto 6
tieneMayorRepertorio(Restaurante, OtroRestaurante) :-
    cocinaEn(Restaurante, UnChef),
    cocinaEn(OtroRestaurante, OtroChef),
    cantidadDePlatos(UnChef, Platos),
    cantidadDePlatos(OtroChef, OtrosPlatos),
    Platos > OtrosPlatos.

cantidadDePlatos(Chef, Cuantos) :-
    findall(Plato, elabora(Chef, Plato), Platos),
    length(Platos, Cuantos).

%Punto 7
calificacionGastronomica(Restaurante, Calificacion) :-
    cocinaEn(Restaurante, Chef),
    cantidadDePlatos(Chef, Cuantos),
    Calificacion is 5*Cuantos.