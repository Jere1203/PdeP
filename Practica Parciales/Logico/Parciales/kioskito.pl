%1)
horario(dodain, lunes, 9,15).
horario(dodain, miercoles, 9, 15).
horario(dodain, viernes, 9, 15).

horario(lucas, martes, 10, 20).

horario(juanC, sabado, 18, 22).
horario(juanC, domingo, 18, 22).

horario(juanFdS, jueves, 10, 20).
horario(juanFdS, viernes, 12, 20).

horario(leoC, lunes, 14, 18).
horario(leoC, miercoles, 14, 18).

horario(martu, miercoles, 23,24).

horario(vale, Dia, HoraInicio, HoraFin) :-
    horario(dodain, Dia, HoraInicio, HoraFin).
horario(vale, Dia, HoraInicio, HoraFin) :-
    horario(juanC, Dia, HoraInicio, HoraFin).

horario(maiu, martes, 0, 8).
horario(maiu, miercoles, 0, 8).

%Como nadie hace el mismo horario que leoC no se modela, ya que por principio de universo cerrado cualquier caso que no se modele tiene un valor de verdad Falso.

%2) cuandoAtiende/2(Persona, Dia).
cuandoAtiende(Persona, Dia, Horario) :-
    horario(Persona, Dia, HoraInicio, HoraFin),
    between(HoraInicio, HoraFin, Horario).

%3) foreverAlone(Persona, Dia, Hora).
foreverAlone(Persona, Dia, Hora) :-
    cuandoAtiende(Persona, Dia, Hora),
    not(hayOtraPersona(Persona, Dia, Hora)).

hayOtraPersona(Persona, Dia, Hora) :-
    cuandoAtiende(OtraPersona, Dia, Hora),
    OtraPersona \= Persona.

%4) podriaAtender(Persona, Dia).
podriaAtender(Persona, Dia) :-
    cuandoAtiende(Persona, Dia, _).

%5)
% venta(Persona, dia, [golosina(Valor), cigarrillos([Marcas]), bebida(Tipo, Cantidad)].

venta(dodain, lunes, [golosina(1200), cigarrillos(jockey), golosina(50)]).
venta(dodain, miercoles, [bebida(alcoholica, 8), bebida(noAlcoholica, 1), golosina(10)]).

venta(martu, miercoles, [golosina(1000), cigarrillos([chesterfield, colorado, parisiennes])]).

venta(lucas, martes, [golosina(600)]).
venta(lucas, martes, [bebida(noAlcoholica, 2), cigarrillos(derby)]).

esSuertuda(Persona) :-
    venta(Persona, Dia, _),
    forall(venta(Persona, Dia, Ventas), esVentaSuertuda(Ventas)).

esVentaSuertuda(Ventas) :-
    nth1(1, Ventas, Venta),
    esVentaImportante(Venta).

esVentaImportante(golosina(Precio)) :-
    Precio > 100.
esVentaImportante(cigarrillos(Marcas)) :-
    length(Marcas, Cuantas),
    Cuantas > 2.
esVentaImportante(bebida(alcoholica,_)).
esVentaImportante(bebida(noAlcoholica,Cantidad)) :-
    Cantidad > 5.