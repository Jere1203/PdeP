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

pikachu = Pokemon "Pikachu" Electrico 55 38 [(usarCaminadora 1 10)] ["Impactrueno","Placaje Electrico"]

snorlax = Pokemon "Snorlax" Normal 30 80 [(dormirLaSiesta 10),(levantarPesas 30)] ["Bostezo","Golpe cuerpo"]

-----------
--Punto 2--
-----------
dormirLaSiesta :: Float -> Rutina
dormirLaSiesta cantidadHoras unPokemon
    | cantidadHoras < 5 = modificarFuerza (+ cantidadFuerza) unPokemon
    | otherwise         = modificarNivel (subtract 1) unPokemon
    where
        cantidadFuerza = 10 * cantidadHoras

modificarFuerza :: (Float -> Float) -> Pokemon -> Pokemon
modificarFuerza cuantaFuerza unPokemon = unPokemon {fuerza = cuantaFuerza $ fuerza unPokemon}

modificarNivel :: (Float -> Float) -> Pokemon -> Pokemon
modificarNivel cuantoNivel unPokemon = unPokemon {nivel = cuantoNivel $ nivel unPokemon}

usarCaminadora :: Float -> Float -> Rutina
usarCaminadora cantidadMinutos unaVelocidad = modificarFuerza (+ velocidadPorCadaQuinceMinutos)
    where
        velocidadPorCadaQuinceMinutos = (cantidadMinutos / 15) * unaVelocidad

levantarPesas :: Float -> Rutina
levantarPesas pesoMancuernas unPokemon
    | pesoMancuernas < fuerza unPokemon = modificarNivel(+1) . modificarFuerza (+ pesoMancuernas) $ unPokemon
    | otherwise                         = modificarFuerza (subtract diezPorcientoDeFuerza) $ unPokemon
    where
        diezPorcientoDeFuerza = fuerza unPokemon * 0.9

darUnPaseo :: Rutina
darUnPaseo unPokemon = unPokemon

-----------
--Punto 3--
-----------

superEntrenamiento :: Rutina
superEntrenamiento = agregarHabilidad "Patada alta" . levantarPesas 15 . usarCaminadora 60 6

agregarHabilidad :: String -> Pokemon -> Pokemon
agregarHabilidad unaHabilidad = modificarHabilidades (unaHabilidad :)

modificarHabilidades :: ([String] -> [String]) -> Pokemon -> Pokemon
modificarHabilidades f unPokemon = unPokemon {habilidades = f $ habilidades unPokemon}

rutinaTranqui :: Rutina
rutinaTranqui = limpiarHabilidades . darUnPaseo . dormirLaSiesta 2

limpiarHabilidades :: Pokemon -> Pokemon
limpiarHabilidades unPokemon = modificarHabilidades (drop cantidadTotalDeHabilidades) unPokemon

    where
        cantidadTotalDeHabilidades = length . habilidades $ unPokemon

nuevaRutina :: Rutina
nuevaRutina unPokemon = dormirLaSiesta 3. darUnPaseo . agregarHabilidad "Placaje" . modificarFuerza (+ 10) $ unPokemon --No termino de entender como armar un ejercicio sin utilizar funciones auxiliares

-----------
--Punto 4--
-----------

realizarRutinas :: [Rutina] -> Pokemon -> Pokemon
realizarRutinas unasRutinas unPokemon = foldl (\unPokemon unasRutinas -> unasRutinas unPokemon) unPokemon unasRutinas

realizarRutinaEnGrupo :: Rutina -> [Pokemon] -> [Pokemon]
realizarRutinaEnGrupo unaRutina = map unaRutina

listarPokemonesPotentes :: Float -> Rutina -> [Pokemon] -> [Pokemon]
listarPokemonesPotentes unPoderDeCombate unaRutina unosPokemones = filter ((<) unPoderDeCombate . calcularPoderDeCombatePokemon) . realizarRutinaEnGrupo unaRutina $ unosPokemones

calcularPoderDeCombatePokemon :: Pokemon -> Float
calcularPoderDeCombatePokemon unPokemon = (nivel unPokemon + fuerza unPokemon) / 2

quedanOrdenadosSegunFuerza :: [Pokemon] -> Bool
quedanOrdenadosSegunFuerza []                                    = True
quedanOrdenadosSegunFuerza (unPokemon:otroPokemon:unosPokemones) = fuerza (realizarSuperEntrenamientoYRutinaTranqui unPokemon) < fuerza (realizarSuperEntrenamientoYRutinaTranqui otroPokemon) && quedanOrdenadosSegunFuerza unosPokemones

realizarSuperEntrenamientoYRutinaTranqui :: Pokemon -> Pokemon
realizarSuperEntrenamientoYRutinaTranqui = superEntrenamiento . rutinaTranqui

-----------
--Punto 5--
-----------

charmander = Pokemon "Charmander" Fuego 30 40 (repeat superEntrenamiento) []

-- El pokemon modelado arriba puede realizar las rutinas, ya que unicamente se modificarian sus estadisticas mas no la lista infinita de rutina, y como haskell utiliza lazy evaluation
-- no requiere evaluar los datos que no son solicitados.
-- Por ejemplo, si aplicamos la funcion "superEntrenamiento" con "charmander" este va a realizar las actividades que corresponden a dicha funcion y le agregará una habilidad a la lista
-- y como no se opera sobre la lista infinita de ejercicios se llega a un resultado final aunque el interpreter de haskell intenta mostrar todos los infinitos ejercicios.