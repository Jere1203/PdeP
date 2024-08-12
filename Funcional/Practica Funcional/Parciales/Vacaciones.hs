import Data.List
import Text.Show.Functions

-----------
--Punto 1--
-----------

data Turista = Turista{
    cansancio :: Int,
    stress :: Int,
    viajaSolo :: Bool,
    idiomas :: [String]
} deriving (Show)

ana :: Turista
ana = Turista 0 21 False ["Espaniol"]

beto :: Turista
beto = Turista 15 15 True ["Aleman"]

cathi :: Turista
cathi = Turista 15 15 True ["Aleman","Catalan"]
-----------
--Punto 2--
-----------

type Excursion = Turista -> Turista

irALaPLaya :: Excursion
irALaPLaya unTurista
    | viajaSolo unTurista = bajaCansancio 5 unTurista
    | otherwise           = bajaStress 1 unTurista

bajaCansancio :: Int -> Turista -> Turista
bajaCansancio cantCansancio = modCansancio (subtract cantCansancio)

bajaStress :: Int -> Turista -> Turista
bajaStress cantStress = modStress (subtract cantStress)

modCansancio :: (Int -> Int) -> Turista -> Turista
modCansancio f unTurista = unTurista {cansancio = f $ cansancio unTurista}

modStress :: (Int -> Int) -> Turista -> Turista
modStress f unTurista = unTurista {stress = f $ stress unTurista}

apreciarElementoPaisaje :: String -> Excursion
apreciarElementoPaisaje cualPaisaje = bajaCansancio cantCansancio

    where
        cantCansancio = length cualPaisaje

salirAHablarUnIdioma :: String -> Excursion
salirAHablarUnIdioma unIdioma = (modViajaSolo (not) . aprendeIdioma unIdioma)

modViajaSolo :: (Bool -> Bool) -> Turista -> Turista
modViajaSolo f unTurista = unTurista {viajaSolo = f $ viajaSolo unTurista}

aprendeIdioma :: String -> Turista -> Turista
aprendeIdioma unIdioma = modIdioma (unIdioma :) 

modIdioma :: ([String] -> [String]) -> Turista -> Turista
modIdioma f unTurista = unTurista {idiomas = f $ idiomas unTurista}

salirACaminar :: Int -> Excursion
salirACaminar cuantoTiempo = (bajaStress intensidadCaminata . subeCansancio intensidadCaminata)

    where
        intensidadCaminata = cuantoTiempo `div` 4

subeCansancio :: Int -> Turista -> Turista
subeCansancio cantCansancio = modCansancio (+ cantCansancio)

paseoEnBarco :: String -> Excursion
paseoEnBarco nivelMarea unTurista
    | nivelMarea == "fuerte"    = subeStress 6 . subeCansancio 10 $ unTurista
    | nivelMarea == "tranquila" = salirACaminar 10 . apreciarElementoPaisaje "mar" . salirAHablarUnIdioma "Aleman" $ unTurista
    | otherwise                 = unTurista

subeStress :: Int -> Turista -> Turista
subeStress cantStress = modStress (+cantStress)

--a)

hacerExcurion :: Excursion -> Turista -> Turista
hacerExcurion unaExcursion unTurista = bajaStress porcentajeStress . unaExcursion $ unTurista

    where
        porcentajeStress = stress unTurista * 10 `div` 100

--b)
deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

type Indice = Turista -> Int

deltaExcursionSegun :: Indice -> Turista -> Excursion -> Int
deltaExcursionSegun unIndice unTurista unaExcursion = deltaSegun unIndice (hacerExcurion unaExcursion unTurista) unTurista

--c)

esExcursionEducativa :: Excursion -> Turista -> Bool
esExcursionEducativa unaExcursion unTurista = (==1) $ deltaExcursionSegun (length . idiomas) unTurista unaExcursion

esExcursionDesestresante :: Turista -> Excursion -> Bool
esExcursionDesestresante unTurista unaExcursion  = (==3) $ deltaExcursionSegun (stress) unTurista unaExcursion

-----------
--Punto 3--
-----------

type Tour = [Excursion]

completo :: Tour
completo = [salirAHablarUnIdioma "melmaquiano", salirACaminar 40, apreciarElementoPaisaje "cascada", salirACaminar 20]

ladoB :: Excursion -> Tour
ladoB unaExcursion = [salirACaminar 120, hacerExcurion unaExcursion, paseoEnBarco "tranquila"]

islaVecina :: String -> Tour
islaVecina unaMarea = [excursionSegunMarea unaMarea]

excursionSegunMarea :: String -> Turista -> Turista
excursionSegunMarea unaMarea unTurista
    | unaMarea == "fuerte" = hacerExcurion (apreciarElementoPaisaje "lago") $ unTurista
    | otherwise            = hacerExcurion irALaPLaya $ unTurista

--a)
hacerTour :: Tour -> Turista -> Turista
hacerTour unTour unTurista = subeStress cantExcursiones . foldl (\x f -> f x) unTurista $ unTour

    where
        cantExcursiones = length unTour

--b)
esTourConvincente :: Turista -> [Tour] -> Bool
esTourConvincente unTurista unosTours = any (esConvincente unTurista) unosTours

esConvincente :: Turista -> Tour -> Bool
esConvincente unTurista unTour = dejaAcompaniado . hacerTour tourDesestresante $ unTurista

    where
        tourDesestresante = filter (esExcursionDesestresante unTurista) unTour

dejaAcompaniado :: Turista -> Bool
dejaAcompaniado unTurista = (==False) . viajaSolo $ unTurista

--c)

efectividadTour :: Tour -> [Turista] -> Int
efectividadTour unTour unosTuristas = sum . map (calculaEspiritualidad unTour) . filter (flip esConvincente unTour) $ unosTuristas

calculaEspiritualidad :: Tour -> Turista -> Int
calculaEspiritualidad unTour unTurista = deltaSegun espiritualidad (hacerTour unTour unTurista) unTurista

espiritualidad :: Turista -> Int
espiritualidad unTurista = stress unTurista + cansancio unTurista

-----------
--Punto 4--
-----------
--a)
infinitasPlayas :: Tour
infinitasPlayas = repeat irALaPLaya

--b)
-- Si aplico la funcion "esConvincente" con "infinitasPlayas" y "ana" como parámetros el intérprete de Haskell no concluye en ningún resultado,
-- ya que núnca termina de analizar la lista de excursiones. Lo mismo ocurre si "pedro" es parámetro
--c) Sí, si pasamos una lista vacía de turistas como argumento para la función esta nos devolverá un "0", esto es así debido a que Haskell utiliza
-- "Lazy Evaluation" para calcular el resultado. Como se llega al resultado final (0) es en vano seguir evaluando los infinitos resultados.