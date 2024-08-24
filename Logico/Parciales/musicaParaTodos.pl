% disco(artista, nombreDelDisco, cantidadVendida, año).
disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).

%manager(artista, manager).
manager(floydRosa, normal(15)).
manager(tablasDeCanada, buenaOnda(cachito, canada)).
manager(rodrigoMalo, estafador(tito)).
% habitual(porcentajeComision)
% internacional(nombre, lugar)
% trucho(nombre)


artista(Artista) :-
    disco(Artista, _, _, _).

%1)
clasico(Artista) :-
    disco(Artista, loMejorDe, _, _).
clasico(Artista) :-
    disco(Artista, _, Cantidad, _),
    Cantidad > 100000.

%2)
cantidadesVendidas(Artista, Cuantas) :-
    artista(Artista),
    findall(Cantidad, disco(Artista, _, Cantidad, _), Ventas),
    sum_list(Ventas, Cuantas).

%3)
derechosDeAutor(Artista, Importe) :-
    manager(Artista, habitual(Importe)).

derechosDeAutor(Artista, Importe) :-
    manager(Artista, internacional(_, Pais)),
    porcentajeSegunPais(internacional(_,Pais), Importe).

derechosDeAutor(trucho(_),100).

%porcentajeSegunPais(Pais, Porcentaje).
porcentajeSegunPais(mexico, 15).
porcentajeSegunPais(canada,  5).

%4)
namberuan(Artista, Anio) :-
    noTieneManager(Artista),
    mayoresVentasPara(Artista, Anio, Cuantas),
    forall(mayoresVentasPara(_, Anio, OtrasCuantas), Cuantas >= OtrasCuantas).

mayoresVentasPara(Artista, Anio, Cuantas) :-
    noTieneManager(Artista),
    disco(Artista, _, Cuantas, Anio),
    forall(disco(Artista, _, OtrasCuantas, Anio), Cuantas >= OtrasCuantas).

noTieneManager(Artista) :-
    artista(Artista),
    not(manager(Artista,_)).

%5)
%Si se agrega un nuevo tipo de mánager podríamos agregar un predicado en manager(Artista,Manager), donde Manager sería un functor,
% luego, aprovechando el concepto de polimorfismo nos quedaría únicamente añadir las cláusulas necesarias en los predicados que se utilice al
% mánager

