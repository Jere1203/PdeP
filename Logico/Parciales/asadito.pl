% define quiénes son amigos de nuestro cliente  
amigo(mati).  
amigo(pablo).  
amigo(leo).  
amigo(fer).   
amigo(flor). 
amigo(ezequiel).   
amigo(marina).

% define quiénes no se pueden ver 
noSeBanca(leo, flor).
noSeBanca(pablo, fer). 
noSeBanca(fer, leo).   
noSeBanca(flor, fer). 

% define cuáles son las comidas y cómo se componen 
% functor achura   contiene nombre, cantidad de calorías 
% functor ensalada contiene nombre, lista de ingredientes 
% functor morfi    contiene nombre (el morfi es una comida principal)

comida(achura(chori, 200)). % ya sabemos que el chori no es achura
comida(achura(chinchu, 150)). 
comida(ensalada(waldorf, [manzana, apio, nuez, mayo])). 
comida(ensalada(mixta, [lechuga, tomate, cebolla])). 
comida(morfi(vacio)). 
comida(morfi(mondiola)). 
comida(morfi(asado)).

% relacionamos la comida que se sirvió en cada asado
% cada asado se realizó en una única fecha posible: functor fecha + comida
asado(fecha(22,9,2011), chori).
asado(fecha(15,9,2011), mixta).
asado(fecha(22,9,2011), waldorf). 
asado(fecha(15,9,2011), mondiola).
asado(fecha(22,9,2011), vacio).
asado(fecha(15,9,2011), chinchu).

% relacionamos quiénes asistieron a ese asado
asistio(fecha(15,9,2011), flor).
asistio(fecha(22,9,2011), marina).
asistio(fecha(15,9,2011), pablo). 
asistio(fecha(22,9,2011), pablo).
asistio(fecha(15,9,2011), leo).
asistio(fecha(22,9,2011), flor).
asistio(fecha(15,9,2011), fer).
asistio(fecha(22,9,2011), mati).

% definimos qué le gusta a cada persona
leGusta(mati, chori).
leGusta(fer, mondiola).
leGusta(mati, vacio).
leGusta(fer, vacio).
leGusta(mati, waldorf).
leGusta(flor, mixta).
leGusta(pablo, asado).

%1)
leGusta(ezequiel, Gustos) :-
    leGusta(mati, Gustos).
leGusta(ezequiel, Gustos) :-
    leGusta(fer, Gustos).

leGusta(marina, Gustos) :-
    leGusta(flor, Gustos).
leGusta(marina, mondiola).

% No se molesta el (no) gusto de Leo por la ensalada ya que por principio de universo cerrado si se pregunta por eso tendra un valor de verdad Falso.

%2)
asadoViolento(FechaAsado) :-
    asado(FechaAsado, _),
    asistio(FechaAsado, Persona),
    asistio(FechaAsado, OtraPersona),
    noSeBanca(Persona, OtraPersona),
    Persona \= OtraPersona.

%3)
calorias(Comida, Calorias) :-
    comida(achura(Comida, Calorias)).
calorias(Comida, Calorias) :-
    comida(ensalada(Comida, Ingredientes)),
    length(Ingredientes, Calorias).
calorias(Comida, 200) :-
    comida(morfi(Comida)).

%4)
asadoFlojito(FechaAsado) :-
    asado(FechaAsado, _),
    caloriasDeUnAsado(FechaAsado, Calorias),
    Calorias < 400.

caloriasDeUnAsado(FechaAsado, Cuantas) :-    
    findall(Calorias, caloriasDeUnPlato(FechaAsado, Calorias), ListaCalorias),
    sum_list(ListaCalorias, Cuantas).

caloriasDeUnPlato(FechaAsado, Cuantas) :-
    asado(FechaAsado, Comida),
    calorias(Comida, Cuantas).

%5)
hablo(fecha(15,09,2011), flor, pablo).
hablo(fecha(15,09,2011), pablo, leo).
hablo(fecha(15,09,2011), leo, fer).
hablo(fecha(22,09,2011), flor, marina).
hablo(fecha(22,09,2011), marina, pablo).
reservado(marina).

chismeDe(FechaAsado, UnaPersona, OtraPersona) :-
    hablo(FechaAsado, OtraPersona, UnaPersona).

chismeDe(FechaAsado, UnaPersona, OtraPersona) :-
    hablo(FechaAsado, OtraPersona, OtraPersonaMas),
    not(reservado(OtraPersonaMas)),
    chismeDe(FechaAsado, UnaPersona, OtraPersonaMas).
%NO RESPONDE BIEN SALU2

%6)
disfruto(Persona, FechaAsado) :-
    asado(FechaAsado, _),
    findall(Comida, leGustaLaComida(Persona, FechaAsado, Comida), ListaComida),
    length(ListaComida, Cantidad),
    Cantidad >= 3.

leGustaLaComida(Persona, FechaAsado, Comida) :-
    asado(FechaAsado, Comida),
    leGusta(Persona, Comida).

%7)
asadoRico(FechaAsado) :-
    asado(FechaAsado, _),
    forall(asado(FechaAsado, Comida), esComidaRica(Comida)).

esComidaRica(morfi(_)).
esComidaRica(Comida) :-
    comida(ensalada(Comida, Ingredientes)),
    length(Ingredientes, Cuantos),
    Cuantos > 3.
esComidaRica(achura(chori)).
esComidaRica(achura(morci)).

%PIDE QUE GENERE LISTAS, NO TENGO NI IDEA COMO ES ESO. ∭