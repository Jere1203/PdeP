% Acá va el código

% persona/3(Nombre, Edad, Genero).
% puedeSerPretendiente/4(Persona, Genero, EdadMinima, EdadMaxima).
% gustos/2(Persona, [Gusto]).
% disgustos/2(Persona, [Disgusto]).

% EJEMPLOS %

persona(pedro, 25, hombre).
persona(jose, 30, hombre).
persona(jazmin, 27, mujer).
persona(sofia, 22, mujer).
%persona(jorge, 20, hombre).

%puedeSerPretendiente(jorge, mujer, 20, 24).
puedeSerPretendiente(pedro, mujer, 20, 30).
puedeSerPretendiente(pedro, hombre, 25, 35).
puedeSerPretendiente(jose, mujer, 20, 25).
puedeSerPretendiente(jazmin, hombre, 25, 35).
puedeSerPretendiente(sofia, hombre, 20, 35).

gustos(jorge, [hola]).
gustos(pedro, [cerveza, jugarAlFutbol, comerAsado, irAlGimnasio]).
gustos(jose, [salirDeGira, jugarAlFutbol, juntarseConAmigos, irAlGimnasio, irDeViaje]).
gustos(jazmin, [leer, escribir, estudiar, escucharMusica, juntarseConAmigos]).
gustos(sofia, [salirDeGira, jugarAlFutbol, juntarseConAmigos, irAlGimnasio, irALaFacultad]).

disgustos(pedro, [irAlBoliche]).
disgustos(jorge, [chau]).
disgustos(jose, [fumar, jugarAlTenis, queMascheranoDirijaLaSeleccion, laPolitica, estudiarFisica]).
disgustos(jazmin, [elTerere, tomarMateDulce, lasAceitunasConCarozo, viajarHastaMicrocentroEnHoraPico, esperarAl155]).
disgustos(sofia, [fumar, jugarAlTenis, queMascheranoDirijaLaSeleccion, laPolitica, estudiarMatematica]).


% tienePerfilIncompleto/1(Persona).
tienePerfilIncompleto(Persona) :-
    usuario(Persona),
    tipoPerfilIncompleto(Persona).
tipoPerfilIncompleto(Persona) :-
    persona(Persona, Edad, _),
    Edad < 18.
tipoPerfilIncompleto(Persona) :-
    gustos(Persona, Gustos),
    tieneGustosODisgustosIncompleto(Gustos).
tipoPerfilIncompleto(Persona) :-
    disgustos(Persona, Disgusto),
    tieneGustosODisgustosIncompleto(Disgusto).
tipoPerfilIncompleto(Persona) :-
    not(persona(Persona, _, _)).
tipoPerfilIncompleto(Persona) :-
    not(puedeSerPretendiente(Persona, _, _, _)).

tieneGustosODisgustosIncompleto(ListaGustos) :-
    length(ListaGustos, Cuantos),
    Cuantos < 5.

usuario(Usuario) :-
    persona(Usuario, _, _).
usuario(Usuario) :-
    puedeSerPretendiente(Usuario, _ , _, _).
usuario(Usuario) :-
    gustos(Usuario, _).
usuario(Usuario) :-
    disgustos(Usuario, _).

%%%%%%%%%%%%%% ANALISIS %%%%%%%%%%%%%%%%%%%%%%%

% almaLibra/1(Usuario).
almaLibre(Usuario) :-
    usuario(Usuario),
    not(tienePerfilIncompleto(Usuario)),
    criterioAlmaLibre(Usuario).

criterioAlmaLibre(Usuario) :-
    sienteInteresPorTodosLosGeneros(Usuario).
criterioAlmaLibre(Usuario) :-
    leGustanMayores(Usuario).

sienteInteresPorTodosLosGeneros(Usuario) :-
    usuario(Usuario),
    forall(usuario(Pretendiente), tieneInteres(Usuario, Pretendiente)).

tieneInteres(Usuario, Pretendiente) :-
    puedeSerPretendiente(Usuario, Genero, EdadMinima, EdadMaxima),
    persona(Pretendiente, EdadPretendiente, GeneroPretendiente),
    sonIguales(Genero, GeneroPretendiente),
    between(EdadMinima, EdadMaxima, EdadPretendiente),
    Usuario \= Pretendiente.

sonIguales(Genero, Genero).    

leGustanMayores(Usuario) :-
    puedeSerPretendiente(Usuario, _, EdadMinima, EdadMaxima),
    intervaloDeEdad(EdadMinima, EdadMaxima, Intervalo),
    Intervalo > 30.
intervaloDeEdad(Minimo, Maximo, Intervalo) :-
    Intervalo is (Maximo - Minimo).

%quiereLaHerencia/1(Usuario).
quiereLaHerencia(Usuario) :-
    usuario(Usuario),
    not(tienePerfilIncompleto(Usuario)),
    edad(Usuario, Edad),
    puedeSerPretendiente(Usuario, _, EdadMinima, _),
    EdadMinima > Edad.

edad(Usuario, Edad) :-
    persona(Usuario, Edad, _).

indeseable(Usuario) :-
    usuario(Usuario),
    not(tienePerfilIncompleto(Usuario)),
    forall(usuario(OtroUsuario), not(esPretendiente(OtroUsuario, Usuario))).

%%%%%%%%%%%%%% MATCHES %%%%%%%%%%%%%%%%%%%%%%%

tienenElPerfilCompleto(Usuario, OtroUsuario) :-
    usuario(Usuario),
    usuario(OtroUsuario),
    not(tienePerfilIncompleto(Usuario)),
    not(tienePerfilIncompleto(OtroUsuario)).

esPretendiente(Usuario, OtroUsuario) :-
    tienenElPerfilCompleto(Usuario, OtroUsuario),
    tieneInteres(Usuario, OtroUsuario),
    compartenGusto(Usuario, OtroUsuario),
    Usuario \= OtroUsuario.

compartenGusto(Usuario, OtroUsuario) :-
    gustos(Usuario, Gustos),
    gustos(OtroUsuario, OtrosGustos),
    member(Gusto, Gustos),
    member(Gusto, OtrosGustos),
    Gustos \= OtrosGustos.

% hayMatch(Usuario, OtroUsuario).
hayMatch(Usuario, OtroUsuario) :-
    esPretendiente(Usuario, OtroUsuario),
    esPretendiente(OtroUsuario, Usuario).

% trianguloAmoroso/3(Usuario1, Usuario2, Usuario3).
trianguloAmoroso(Usuario, OtroUsuario, OtroUsuarioMas) :-
    esPretendienteYNoHayMatch(Usuario, OtroUsuario),
    esPretendienteYNoHayMatch(OtroUsuario, OtroUsuarioMas),
    esPretendienteYNoHayMatch(OtroUsuarioMas, Usuario).
    
esPretendienteYNoHayMatch(Usuario, OtroUsuario) :-
    esPretendiente(Usuario, OtroUsuario),
    not(hayMatch(Usuario, OtroUsuario)).

%elUnoParaElOtro(Usuario1, Usuario2).
elUnoParaElOtro(Usuario, OtroUsuario) :-
    tienenElPerfilCompleto(Usuario, OtroUsuario),
    hayMatch(Usuario, OtroUsuario),
    not(hayGustoQueNoLeGuste(Usuario, OtroUsuario)),
    Usuario \= OtroUsuario.

hayGustoQueNoLeGuste(Usuario, OtroUsuario) :-
    gustos(Usuario, Gustos),
    disgustos(OtroUsuario, Disgustos),
    member(Gusto, Gustos),
    member(Gusto, Disgustos).

%%%%%%%%%%%%%% MENSAJES %%%%%%%%%%%%%%%%%%%%%%%
% indiceDeAmor/3(Usuario, OtroUsuario, Indice).
indiceDeAmor(pedro, jazmin, 4).
indiceDeAmor(jazmin, pedro, 10).
indiceDeAmor(jose, sofia, 2).
indiceDeAmor(sofia, jose, 10).
indiceDeAmor(jorge, sofia, 1).

% envioMensaje/2(Usuario, OtroUsuario).
envioMensaje(Usuario, OtroUsuario) :-
    tienenElPerfilCompleto(Usuario, OtroUsuario),
    indiceDeAmor(Usuario, OtroUsuario, _),
    Usuario \= OtroUsuario.

hayDesbalance(Usuario, OtroUsuario) :-
    tienenElPerfilCompleto(Usuario, OtroUsuario),
    hayIntercambio(Usuario, OtroUsuario),
    indiceDeAmorPromedio(Usuario, Indice),
    indiceDeAmorPromedio(OtroUsuario, OtroIndice),
    IndiceAEvaluar is OtroIndice * 2,
    Indice > IndiceAEvaluar.

hayIntercambio(Usuario, OtroUsuario) :-
    envioMensaje(Usuario, OtroUsuario),
    envioMensaje(OtroUsuario, Usuario).

indiceDeAmorPromedio(Usuario, IndicePromedio) :-
    findall(Indice, indiceDeAmor(Usuario, _, Indice), ListaIndicesDeAmor),
    sum_list(ListaIndicesDeAmor, SumaIndices),
    length(ListaIndicesDeAmor, CantidadIndices),
    IndicePromedio is (SumaIndices / CantidadIndices).

% ghostea/2(Usuario, OtroUsuario).
ghostea(OtroUsuario, Usuario) :-
    tienenElPerfilCompleto(Usuario, OtroUsuario),
    envioMensaje(Usuario, OtroUsuario),
    not(envioMensaje(OtroUsuario, Usuario)).

% Sofia no ghostea a Jorge porque Jorge no tiene el perfil completo.