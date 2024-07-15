linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

%1) estaEn/2: en qué línea está una estación
estaEn(Estacion, Linea) :-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).

%2) distancia/3: dadas dos estaciones de la misma línea, cuántas estaciones hay entre ellas: por ejemplo,
% entre Perú y Primera Junta hay 5 estaciones.
distancia(UnaEstacion, OtraEstacion, Distancia) :-
    linea(_, Estaciones),
    nth1(Posicion1, Estaciones, UnaEstacion),
    nth1(Posicion2, Estaciones, OtraEstacion),
    DiferenciaPosicion is Posicion1 - Posicion2,
    abs(DiferenciaPosicion, Distancia),
    UnaEstacion \= OtraEstacion.

%3) mismaAltura/2: dadas dos estaciones de distintas líneas, si están a la misma altura (osea, las dos terceras, las dos 
% quintas, etc.), por ejemplo: Pellegrini y Santa Fe están ambas segundas
mismaAltura(UnaEstacion, OtraEstacion) :-
    estaEn(UnaEstacion, UnaLinea),
    estaEn(OtraEstacion, OtraLinea),
    UnaLinea \= OtraLinea,
    posicion(UnaEstacion, Posicion1),
    posicion(OtraEstacion, Posicion2),
    estanAMismaAltura(Posicion1, Posicion2).

posicion(Estacion, Posicion) :-
    estaEn(Estacion, Linea),
    linea(Linea, Estaciones),
    nth1(Posicion, Estaciones, Estacion).

estanAMismaAltura(Posicion, Posicion).

%4) granCombinacion/1: se cumple para una combinación de más de dos estaciones.
granCombinacion(UnaCombinacion) :-
    combinacion(UnaCombinacion),
    length(UnaCombinacion, Longitud),
    Longitud > 2.
    
%5) cuantasCombinan/2: dada una línea, relaciona con la cantidad de estaciones de esa
%   slínea que tienen alguna combinación. Por ejemplo, la línea C tiene tres estaciones que
%   scombinan (avMayo, diagNorte e independenciaC).
cuantasCombinan(Linea, Cuantas) :-
    linea(Linea,_),
    findall(Estacion, combinaPara(Estacion, Linea), Estaciones),
    length(Estaciones, Cuantas).

combinaPara(Estacion, Linea) :-
    estaEn(Estacion, Linea),
    combinacion(Estaciones),
    member(Estacion, Estaciones).

%6) lineaMasLarga/1: es verdadero para la línea con más estaciones.
lineaMasLarga(Linea) :-
    linea(Linea, Estaciones),
    length(Estaciones, CuantasEstaciones),
    forall(linea(OtraLinea,_), menosEstacionesQue(CuantasEstaciones,OtraLinea)).

menosEstacionesQue(Cantidad, OtraLinea) :-
    linea(OtraLinea, Estaciones),
    length(Estaciones, CuantasEstaciones),
    Cantidad >= CuantasEstaciones.

% 7) viajeFacil/2: dadas dos estaciones, si puedo llegar fácil de una a la otra; esto es, si
%    están en la misma línea, o bien puedo llegar con una sola combinación.
viajeFacil(Estacion1, Estacion2) :-
    estaEn(Estacion1, Linea1),
    estaEn(Estacion2, Linea2),
    estanEnMismaLinea(Linea1, Linea2).
viajeFacil(Estacion1, Estacion2) :-
    combinaPara(Estacion1, _),
    combinaPara(Estacion2, _),
    mismaCombinacion(Estacion1, Estacion2).

mismaCombinacion(Estacion1, Estacion2) :-
    combinacion(Combinacion),
    member(Estacion1, Combinacion),
    member(Estacion2, Combinacion).

estanEnMismaLinea(Linea, Linea).
