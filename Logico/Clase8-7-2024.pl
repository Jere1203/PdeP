%Modelar una base de conocimientos sobre los JJOO para cada disciplina separado por categoría y género

%Solucion 1

%Natacion -> Categoría por metro y estilo
natacion(masculino, 200, espalda).
natacion(femenino, 1000, pecho).

%Lanzamiento -> Categorías por qué se lanza
lanzamiento(masculino, jabalina).
lanzamiento(masculino, bala).
lanzamiento(femenino, disco).

%Judo -> Categorías por kilo
judo(masculino, 90).
judo(masculino, 100).
judo(masculino, masDe100kg).
judo(femenino, 70).
judo(femenino, 78).
judo(femenino, masDe78kg).

%Deportes en grupo
futbol(masculino).
voley(femenino).
futbol(femenino).

%Si quiero saber cuántas disciplinas por género se puede pero repite lógica
%Se puede saber las variedades por disciplina pero repito lógica

%Se necesita agrupar las disciplinas para no repetir lógica

%Solución 2
%De natacion se sabe metros y estilo
disciplina(natacion200Espalda, masculino).
disciplina(natacion1000Pecho, femenino).

%De lanzamiento se sabe qué lanzan
disciplina(lanzamientoJabalina, masculino).
disciplina(lanzamientoBala, masculino).
disciplina(lanzamientoDisco, femenino).

%De judo se sabe cuántos kilos permiten
disciplina(judo90kg, masculino).
disciplina(judo100kg, masculino).
disciplina(judoMasDe100kg, masculino).
%etc

%De deportes en grupo no tenemos más información
disciplina(futbol, masculino).
disciplina(futbol, femenino).
disciplina(voley, femenino).

%Ya no se repite lógica para las disciplinas por género pero sí para saber cuántas categorías hay

%Solución 3
disciplina(natacion, masculino, [espalda200]).
disciplina(natacion, femenino, [pecho1000]).

disciplina(lanzamiento, masculino, [jabalina, bala]).
disciplina(lanzamiento, femenino, [disco]).

disciplina(judo, masculino, [90, 100, masDe100]).
disciplina(judo, femenino, [70, 78, masDe78]).

disciplina(futbol, masculino).
disciplina(futbol, femenino).
disciplina(voley, femenino).

%El predicado "disciplina" es de distina aridad (2 y 3)

%Hay que agregar un caso aparte por cada predicado de distinta aridad

%La solución 3 permite saber cuáles son las disciplinas por género (Repite un poco de lógica)
% saber cuántas variedades tiene una disciplina (repite un poco de lógica) pero ambas pierden declaratividad.

%Solución 4
disciplina(masculino, natacion(200, espalda)).
disciplina(femenino, natacion(1000, pecho)).
%                                    ^-----Functor
disciplina(masculino, lanzamiento(jabalina)).
disciplina(masculino, lanzamiento(bala)).
disciplina(femenino, lanzamiento(disco)).

disciplina(masculino, judo([60, 66, 73, 81, 90, 100, masDe100])).
disciplina(femenino, judo([48,52,57,63,70,78, masDe78])).

disciplina(femenino, futbol).
disciplina(masculino, futbol).
disciplina(femenino, voley).

%De esta forma evito el problema de la aridad ya que todos mis predicados son de aridad 2.

disciplinaPorGenero(Genero, Disciplina) :-
    disciplina(Genero, Disciplina).

%Nos deja saber la disciplina por género.
%Pero ya no puedo saber la variedad de las disciplinas.

%Solucion 5

disciplina(natacion, caracteristicas(masculino, 200, espalda)).
disciplina(natacion, caracteristicas(femenino, 1000, pecho)).

disciplina(lanzamiento, caracteristicas(masculino, jabalina)).
disciplina(lanzamiento, caracteristicas(masculino, bala)).
disciplina(lanzamiento, caracteristicas(femenino, disco)).

disciplina(judo, caracteristicas(masculino, 90)).
disciplina(judo, caracteristicas(masculino, 100)).
disciplina(judo, caracteristicas(masculino, masDe100kg)).
disciplina(judo, caracteristicas(femenino, 70)).
disciplina(judo, caracteristicas(femenino, 78)).
disciplina(judo, caracteristicas(femenino, masDe78kg)).

disciplina(futbol, caracteristicas(femenino)).
disciplina(futbol, caracteristicas(masculino)).
disciplina(voley, caracteristicas(femenino)).

%Cuantas variedades por disciplina

variedadesPorDisciplina(Disciplina, Cuantas) :-
    disciplina(Disciplina,_),
    findall(Disciplina, disciplina(Disciplina, _), Disciplinas),
    length(Disciplinas, Cuantas).

disciplinaPorGenero(Disciplina, Genero) :-
    disciplina(Disciplina, Caracteristicas),
    generoEnCaracteristicas(Genero, Caracteristicas).

generoEnCaracteristicas(Genero, caracteristicas(Genero)).
generoEnCaracteristicas(Genero, caracteristicas(Genero,_)).
generoEnCaracteristicas(Genero, caracteristicas(Genero, _, _)).


%Esta alternativa nos permite saber cuáles son las disciplinas por género
%Saber cuántas variedades hay de cada disciplina

