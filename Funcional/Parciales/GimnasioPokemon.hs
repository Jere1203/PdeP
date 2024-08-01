import Text.Show.Functions
import Data.List

data Pokemon = Pokemon{
    nombre :: String,
    tipo :: TipoPokemon,
    nivel :: Float,
    fuerza :: Float,
    actividades :: [Rutina],
    habilidades :: [String]
} deriving (Show)

data TipoPokemon = Electrico | Normal | Fuego deriving (Show)

type Rutina = Pokemon -> Pokemon
type Actividad = Rutina

pikachu = Pokemon "Pikachu" Electrico 55 38 [(usarCaminadora 1 10)] ["Impactrueno","Placaje Electrico"]

snorlax = Pokemon "Snorlax" Normal 30 80 [(dormirLaSiesta 10),(levantarPesas 30)] ["Bostezo","Golpe cuerpo"]

-----------
--Punto 2--
-----------
dormirLaSiesta :: Float -> Actividad
dormirLaSiesta cantidadHoras unPokemon
    | cantidadHoras < 5 = modificarFuerza (+ cantidadFuerza) unPokemon
    | otherwise         = modificarNivel (subtract 1) unPokemon
    where
        cantidadFuerza = 10 * cantidadHoras

modificarFuerza :: (Float -> Float) -> Pokemon -> Pokemon
modificarFuerza unaFuncion unPokemon = unPokemon {fuerza = unaFuncion $ fuerza unPokemon}

modificarNivel :: (Float -> Float) -> Pokemon -> Pokemon
modificarNivel unaFuncion unPokemon = unPokemon {nivel = unaFuncion $ nivel unPokemon}

aumentarFuerza :: Float -> Pokemon -> Pokemon
aumentarFuerza cantidadFuerza = modificarFuerza (+ cantidadFuerza)

usarCaminadora :: Float -> Float -> Actividad
usarCaminadora cantidadMinutos unaVelocidad = aumentarFuerza velocidadPorCadaQuinceMinutos
    where
        velocidadPorCadaQuinceMinutos = (cantidadMinutos / 15) * unaVelocidad

levantarPesas :: Float -> Actividad
levantarPesas pesoMancuernas unPokemon
    | pesoMancuernas < fuerza unPokemon = modificarNivel(+1) . aumentarFuerza pesoMancuernas $ unPokemon
    | otherwise                         = modificarFuerza (* 0.9) $ unPokemon

darUnPaseo :: Actividad
darUnPaseo unPokemon = unPokemon

-----------
--Punto 3--
-----------

superEntrenamiento :: Rutina
superEntrenamiento = agregarHabilidad "Patada alta" . levantarPesas 15 . usarCaminadora 60 6

agregarHabilidad :: String -> Pokemon -> Pokemon
agregarHabilidad unaHabilidad = modificarHabilidades (unaHabilidad :)

modificarHabilidades :: ([String] -> [String]) -> Pokemon -> Pokemon
modificarHabilidades unaFuncion unPokemon = unPokemon {habilidades = unaFuncion $ habilidades unPokemon}

rutinaTranqui :: Rutina
rutinaTranqui = limpiarHabilidades . darUnPaseo . dormirLaSiesta 2

limpiarHabilidades :: Pokemon -> Pokemon
limpiarHabilidades = modificarHabilidades (const [])

nuevaRutina :: Rutina
nuevaRutina unPokemon = dormirLaSiesta 3. darUnPaseo . agregarHabilidad "Placaje" . modificarFuerza (+ 10) $ unPokemon --No termino de entender como armar un ejercicio sin utilizar funciones auxiliares

-----------
--Punto 4--
-----------

realizarRutinas :: [Rutina] -> Pokemon -> Pokemon
realizarRutinas unasRutinas unPokemon = foldl (\unPokemon unasRutinas -> unasRutinas unPokemon) unPokemon unasRutinas

realizarRutinaEnGrupo :: Rutina -> [Pokemon] -> [Pokemon]
realizarRutinaEnGrupo unaRutina = map unaRutina

pokemonesPotentes :: Float -> Rutina -> [Pokemon] -> [Pokemon]
pokemonesPotentes unPoderDeCombate unaRutina unosPokemones = filter ((<) unPoderDeCombate . poderDeCombate) . realizarRutinaEnGrupo unaRutina $ unosPokemones

poderDeCombate :: Pokemon -> Float
poderDeCombate unPokemon = (nivel unPokemon + fuerza unPokemon) / 2

estanOrdenadosSegunFuerza :: [Pokemon] -> Bool
estanOrdenadosSegunFuerza = quedanOrdenadosSegunFuerza . realizarRutinaEnGrupo superEntrenamientoYRutinaTranqui

quedanOrdenadosSegunFuerza :: [Pokemon] -> Bool
quedanOrdenadosSegunFuerza []                                    = True
quedanOrdenadosSegunFuerza (unPokemon:otroPokemon:unosPokemones) = fuerza unPokemon < fuerza otroPokemon && quedanOrdenadosSegunFuerza unosPokemones

superEntrenamientoYRutinaTranqui :: Pokemon -> Pokemon
superEntrenamientoYRutinaTranqui = superEntrenamiento . rutinaTranqui

-----------
--Punto 5--
-----------

charmander = Pokemon "Charmander" Fuego 30 40 (repeat (usarCaminadora 1 20)) []

-- El pokemon modelado arriba puede realizar las rutinas, ya que unicamente se modificarian sus estadisticas mas no la lista infinita de rutina, y como haskell utiliza lazy evaluation
-- no requiere evaluar los datos que no son solicitados.
-- Por ejemplo, si aplicamos la funcion "superEntrenamiento" con "charmander" este va a realizar las actividades que corresponden a dicha funcion y le agregará una habilidad a la lista
-- y como no se opera sobre la lista infinita de ejercicios se llega a un resultado final aunque el interpreter de haskell intenta mostrar todos los infinitos ejercicios.