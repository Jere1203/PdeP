import Data.List
import Text.Show.Functions

-----------
--Punto 1--
-----------

data Personaje = Personaje {
    nombre :: String,
    dinero :: Int,
    felicidad :: Int
} deriving (Show, Eq)

type Actividad = Personaje -> Personaje

irAEscuela :: Actividad
irAEscuela unPersonaje
    | (== lisa) unPersonaje = subirFelicidad 20 unPersonaje
    | otherwise             = bajarFelicidad 20 unPersonaje

subirFelicidad :: Int -> Personaje -> Personaje
subirFelicidad cantidadFelicidad = modFelicidad (+cantidadFelicidad)

modFelicidad :: (Int -> Int) -> Personaje -> Personaje
modFelicidad f unPersonaje = unPersonaje {felicidad = f $ felicidad unPersonaje}

bajarFelicidad :: Int -> Personaje -> Personaje
bajarFelicidad cantidadFelicidad = modFelicidad (subtract cantidadFelicidad)

comerDonas :: Int -> Actividad
comerDonas donas = (subirFelicidad (10*donas) . restarDinero donas)

restarDinero :: Int -> Personaje -> Personaje
restarDinero cantDinero = modDinero (subtract cantDinero)

modDinero :: (Int -> Int) -> Personaje -> Personaje
modDinero f unPersonaje = unPersonaje {dinero = f $ dinero unPersonaje}

irATrabajar :: String -> Actividad
irATrabajar unLugar = sumaDinero (length unLugar)

sumaDinero :: Int -> Personaje -> Personaje
sumaDinero cantDinero = modDinero (+cantDinero)

trabajarDeDirector :: Actividad
trabajarDeDirector = (irATrabajar "escuela elemental" . irAEscuela) 

tocarElSaxofon :: Actividad 
tocarElSaxofon unPersonaje
    | (==lisa) unPersonaje = subirFelicidad 50 unPersonaje
    | otherwise            = bajarFelicidad 50 unPersonaje

lisa :: Personaje
lisa = Personaje "Lisa" 5 50

homero :: Personaje 
homero = Personaje "Homero" 50 20

skinner :: Personaje
skinner = Personaje "Skinner" 30 10

srBurns :: Personaje
srBurns = Personaje "Senior Burns" 1000000 20

-----------
--Punto 2--
-----------

type Logro = Personaje -> Bool

esMillonario :: Logro
esMillonario unPersonaje = (> dinero srBurns) . dinero $ unPersonaje

alegrarse :: Int -> Logro
alegrarse nivelFelicidad unPersonaje = (> nivelFelicidad) . felicidad $ unPersonaje

irAVerAKrusty :: Logro
irAVerAKrusty unPersonaje = (>=10) . dinero $ unPersonaje

tristementeMillonario :: Logro
tristementeMillonario unPersonaje = (not . alegrarse 100) unPersonaje && esMillonario unPersonaje

esActividadDecisiva :: Logro -> Personaje -> Actividad -> Bool
esActividadDecisiva unLogro unPersonaje unaActividad = logroSinActividad == False && logroConActividad == True

    where
        logroConActividad = unLogro . unaActividad $ unPersonaje
        logroSinActividad = unLogro $ unPersonaje

buscaPrimeraDecisiva :: Personaje -> Logro -> [Actividad] -> Actividad
buscaPrimeraDecisiva unPersonaje unLogro unasActividades = head listaDecisivas

    where 
        listaDecisivas = filter (esActividadDecisiva unLogro unPersonaje) unasActividades

realizaLaPrimerDecisiva :: Personaje -> Logro -> [Actividad] -> Personaje
realizaLaPrimerDecisiva unPersonaje unLogro unasActividades
    | primerActividadDecisiva unPersonaje == unPersonaje     = unPersonaje
    | otherwise                                              = primerActividadDecisiva unPersonaje

    where
        primerActividadDecisiva = buscaPrimeraDecisiva unPersonaje unLogro unasActividades

-- C)

realizarInfinitasVeces :: Actividad -> Personaje -> Personaje
realizarInfinitasVeces unaActividad unPersonaje = foldl (\unPersonaje unasActividades -> unasActividades unPersonaje) unPersonaje (repeat unaActividad)