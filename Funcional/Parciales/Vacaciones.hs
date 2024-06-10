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
deltaSegun :: Indice -> Turista -> Excursion -> Int
deltaSegun f algo1 algo2 = f algo1 - f (hacerExcurion algo2 $ algo1)

type Indice = Turista -> Int

deltaExcursionSegun :: Indice -> Turista -> Excursion -> Int
deltaExcursionSegun unIndice unTurista unaExcursion = deltaSegun stress unTurista unaExcursion

--c)

--esExcursionEducativa :: Excursion -> Turista -> Bool
--esExcursionEducativa unaExcursion unTurista = 