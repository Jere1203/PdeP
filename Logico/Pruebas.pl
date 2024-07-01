guerreroZ(goku).



poderoso(Guerrero):-
    guerreroZ(Guerrero).

% vuelo/3

vuelo(aep,scl, 150000).
vuelo(scl,aep,160000).
vuelo(eze,gru,200000).
vuelo(gru,eze,190000).

%costoIdaYVuelta/3

costoIdaYVuelta(Costo,Ida,Vuelta) :-
    vuelo(Ida,Vuelta,CostoIda),
    vuelo(Vuelta,Ida,CostoVuelta),
    Costo is CostoIda + CostoVuelta.

costoIdaYVueltaMillas(Millas,Ida,Vuelta):-
    costoIdaYVuelta(Costo,Ida,Vuelta),
    Millas is Costo / 100.

vueloBarato(Ida,Vuelta):-
    costoIdaYVuelta(Costo,Ida,Vuelta),
    Costo < 200000.

diferenciaEnPesos(Diferencia,Ida,Vuelta) :- %Diferencia entre tramo ida y tramo vuelta
    vuelo(Ida,Vuelta,CostoIda),
    vuelo(Vuelta,Ida,CostoVuelta),
    DiferenciaParcial is CostoIda - CostoVuelta,
    abs(DiferenciaParcial,Diferencia).  %Cuando uno pregunta por "Diferencia" el predicado "abs" busca cuál es el valor para "Diferencia" que satisfaga que sea el valor absoluto de "DiferenciaParcial" 

%No se usa DiferenciaParcial is abs(CostoIda - CostoVuelta). porque trabajamos puramente en el paradigma lógico (este método mencionado sigue al paradigma funcional).


aeropuerto(aep,buenosAires).
aeropuerto(eze,buenosAires).
aeropuerto(scl,santiago).
aeropuerto(gru,saoPaulo).
ciudad(buenosAires, argentina).
ciudad(saoPaulo,brasil).
ciudad(marDelPlata,argentina).

%inaccesibleEnAvion una ciudad que no se puede llegar en avion.
accesibleEnAvion(Ciudad) :-
    aeropuerto(Aeropuerto,Ciudad),
    vuelo(_,Aeropuerto, _).

inaccesibleEnAvion(Ciudad) :-
    ciudad(Ciudad,_),   % <-- predicado generador para evitar problemas de inversibilidad.
    not(accesibleEnAvion(Ciudad)).

%Una ciudad que tiene vuelo de ida y no de vuelta

imposibleSalir(Ciudad) :-
    accesibleEnAvion(Ciudad),
    not(tieneVueloDeVuelta(Ciudad)).

tieneVueloDeVuelta(Ciudad) :-
    aeropuerto(Aeropuerto,Ciudad),
    vuelo(Aeropuerto,_,_).

%vueloNacional --> para dos aeropuertos sale y llega a/de Argentina
vueloNacional(Aeropuerto1,Aeropuerto2) :-
    aeropuertoArgentino(Aeropuerto1),
    aeropuertoArgentino(Aeropuerto2).

aeropuertoArgentino(Aeropuerto) :-
    aeropuerto(Aeropuerto,Ciudad),
    ciudad(Ciudad,argentina).