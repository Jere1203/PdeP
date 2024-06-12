import Data.List
import Text.Show.Functions

-----------
--Punto 1--
-----------

data Guantelete = Guantelete{
    material :: String,
    gemas :: Gemas
} deriving (Show)

type Gemas = [Habilidad]

data Personaje = Personaje{
    edad :: Int,
    energia :: Int,
    habilidades :: [String],
    nombre :: String,
    planetaNatal :: String
} deriving (Show)

punisher :: Personaje
punisher = Personaje 45 100 ["Usar pistola"] "Punisher" "Planeta Tierra"

type Habilidad = Personaje -> Personaje

type Universo = [Personaje]

esGuanteleteCompleto :: Guantelete -> Bool
esGuanteleteCompleto unGuantelete = ((=="uru") . material $ unGuantelete) && ((==6) . length . gemas $ unGuantelete)

chasquearUniverso :: Universo -> Guantelete -> Universo
chasquearUniverso unUniverso unGuantelete
    | esGuanteleteCompleto unGuantelete = drop mitad $ unUniverso
    | otherwise                         = unUniverso

    where
        mitad = (length unUniverso ) `div` 2

-----------
--Punto 2--
-----------

esAptoParaPendex :: Universo -> Bool
esAptoParaPendex = any ((<45) . edad)

energiaTotalUniverso :: Universo -> Int
energiaTotalUniverso unUniverso = sum . map energia $ listaMasDeUnaHabilidad
    
    where
        listaMasDeUnaHabilidad = filter ((>2) . length . habilidades) unUniverso

-----------------
--Segunda parte--
-----------------

-----------
--Punto 3--
-----------

gemaDeLaMente :: Int -> Habilidad
gemaDeLaMente cantidadEnergia = bajaEnergia (cantidadEnergia)

bajaEnergia :: Int -> Personaje -> Personaje
bajaEnergia cantidadEnergia = modEnergia (subtract cantidadEnergia)

modEnergia :: (Int -> Int) -> Personaje -> Personaje
modEnergia f unPersonaje = unPersonaje {energia = f $ energia unPersonaje}

gemaDelAlma :: String -> Personaje -> Personaje
gemaDelAlma unaHabilidad unPersonaje = quitarHabilidad unaHabilidad . bajaEnergia 10 $ unPersonaje

quitarHabilidad :: String -> Personaje -> Personaje
quitarHabilidad unaHabilidad unPersonaje = modHabilidades (dropWhile ((/=) unaHabilidad)) unPersonaje

modHabilidades :: ([String] -> [String]) -> Personaje -> Personaje
modHabilidades f unPersonaje = unPersonaje {habilidades = f $ habilidades unPersonaje}

gemaDelEspacio :: String -> Habilidad
gemaDelEspacio unPlaneta = (transportarPersonaje unPlaneta . bajaEnergia 20)

transportarPersonaje :: String -> Personaje -> Personaje
transportarPersonaje unPlaneta = modPlaneta (const unPlaneta)

modPlaneta :: (String -> String) -> Personaje -> Personaje
modPlaneta f unPersonaje = unPersonaje {planetaNatal = f $ planetaNatal unPersonaje}

gemaDelPoder :: Habilidad
gemaDelPoder unPersonaje
    | (<=2) . length . habilidades $ unPersonaje = bajaEnergia todaLaEnergia . modHabilidades (const []) $ unPersonaje
    | otherwise                                  = unPersonaje

    where
        todaLaEnergia = energia unPersonaje

gemaDelTiempo :: Habilidad
gemaDelTiempo unPersonaje = modEdad (subtract mediaEdad) unPersonaje

    where
        mediaEdad = edad unPersonaje `div` 2

modEdad :: (Int -> Int) -> Personaje -> Personaje
modEdad f unPersonaje = unPersonaje {edad = max 18 . f $ edad unPersonaje}

gemaLoca :: Habilidad -> Personaje -> Personaje
gemaLoca unaGema = (unaGema . unaGema)

-----------
--Punto 4--
-----------

guanteleteDeGoma :: Guantelete
guanteleteDeGoma = Guantelete "Goma" [gemaDelTiempo,gemaDelAlma "usar Mjolnir",gemaLoca (gemaDelAlma "programacion en Haskell")]

-----------
--Punto 5--
-----------

utilizar :: Personaje -> Gemas -> Personaje
utilizar = foldl (\unPersonaje unasGemas -> unasGemas unPersonaje)

-----------
--Punto 6--
-----------

type Gema = Habilidad

gemaMasPoderosa :: Gemas -> Personaje -> Gema
gemaMasPoderosa [unaGema] _ = unaGema
gemaMasPoderosa (unaGema : otraGema : unasGemas) unPersonaje
    | energia (unaGema unPersonaje) > energia (otraGema unPersonaje)  = gemaMasPoderosa (otraGema : unasGemas) unPersonaje
    | otherwise                                                       = gemaMasPoderosa (unaGema : unasGemas)  unPersonaje

-----------
--Punto 7--
-----------

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas gemaDelTiempo)
--
usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (flip utilizar . take 3. gemas) guantelete

--Se puede ejecutar gemaMasPoderosa punisher guanteleteDeLocos ya que al utilizar lazy evaluation y siempre evaluar con las mismas gemas una vez alcanzado un valor final el interpreter deja de evaluar el resto de la lista.
--En el caso de "usoLasTresPrimerasGemas guanteleteDeLocos punisher" sucede algo similar solo que al acotar la cantidad de gemas a utilizar a tres simplemente evalua en esas tres por lazy evaluation.