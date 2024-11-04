import Text.Show.Functions
import Data.List

-- Funciones que tal vez te pueden servir, tal vez no

-- Main*> :t takeWhile
-- takeWhile :: (a -> Bool) -> [a] -> [a]
-- Main*> takeWhile even [2,4,6,5,6,7,8,9]
-- [2,4,6]

-- Main*> :t genericLength
-- genericLength :: Num i => [a] -> i
-- Main*> genericLength [2,4,6,5,6,7,8,9]
-- 8

-----------
--PUNTO 1--
-----------

data GuerreroZ = GuerreroZ{
    nombre :: String,
    ki :: Float,
    raza :: Raza,
    cansancio :: Float,
    estado :: Estado,
    personalidad :: Personalidad
} deriving (Show)

type Raza = String
type Personalidad = String
type Estado = String

type Ejercicio = GuerreroZ -> GuerreroZ

gohan :: GuerreroZ
gohan = GuerreroZ "Son Gohan" 10000 "Saiyajin" 0 "Fresco" "perezoso"

vegeta :: GuerreroZ
vegeta = GuerreroZ "Vegeta" 100000 "Saiyajin" 0 "Fresco" "sacado"

yajirobe :: GuerreroZ
yajirobe = GuerreroZ "Yajirobe" 500 "Humano" 0 "Fresco" "tramposo"

-----------
--PUNTO 2--
-----------

esPoderoso :: GuerreroZ -> Bool
esPoderoso unGuerrero = ((>8000) . ki $ unGuerrero) || ((=="Saiyajin") . raza $ unGuerrero)

pressDeBanca :: Ejercicio
pressDeBanca unGuerrero
    | estaCansado unGuerrero = estadoGuerrero . aumentaCansancio (4*cantCansancio) . aumentaKi (2*cantKi) $ unGuerrero
    | otherwise              = estadoGuerrero . aumentaCansancio cantCansancio . aumentaKi cantKi $ unGuerrero
    where
        cantCansancio = 100
        cantKi = 90
aumentaCansancio :: Float -> GuerreroZ -> GuerreroZ
aumentaCansancio cuantoCansancio = modCansancio (+cuantoCansancio)

aumentaKi :: Float -> GuerreroZ -> GuerreroZ
aumentaKi cuantoKi = modKi (+cuantoKi)

modCansancio :: (Float -> Float) -> GuerreroZ -> GuerreroZ
modCansancio f unGuerrero = unGuerrero {cansancio = max 0 . f $ cansancio unGuerrero}

modKi :: (Float -> Float) -> GuerreroZ -> GuerreroZ
modKi f unGuerrero = unGuerrero {ki = f $ ki unGuerrero}

flexionesDeBrazo :: Int -> Ejercicio
flexionesDeBrazo cantidadFlexiones unGuerrero
    | cantidadFlexiones > 50 && estaFresco unGuerrero   = estadoGuerrero . aumentaCansancio cantCansancio $ unGuerrero
    | cantidadFlexiones > 50 && estaCansado unGuerrero  = estadoGuerrero . aumentaCansancio (4*cantCansancio) $ unGuerrero
    | otherwise                                         = unGuerrero
    where
        cantCansancio = 50

saltosAlCajon :: Float -> Ejercicio
saltosAlCajon alturaCajon unGuerrero
    | estaFresco unGuerrero  = estadoGuerrero . aumentaCansancio cantidadCansancio . aumentaKi cantidadKi $ unGuerrero
    | otherwise              = estadoGuerrero . aumentaCansancio (4*cantidadCansancio) . aumentaKi (2*cantidadKi) $ unGuerrero
    where
        cantidadCansancio = alturaCajon / 5
        cantidadKi = alturaCajon / 10

snatch :: Ejercicio
snatch unGuerrero
    | esGuerreroExperimentado unGuerrero && estaFresco unGuerrero  = estadoGuerrero . modKi (*porcentajeKi) . modCansancio (*porcentajeCansancio) $ unGuerrero
    | esGuerreroExperimentado unGuerrero && estaCansado unGuerrero = estadoGuerrero . modKi (*(2*porcentajeKi)) . modCansancio (*(4*porcentajeCansancio)) $ unGuerrero
    | otherwise                                                    = aumentaCansancio 100 $ unGuerrero
    where
        porcentajeCansancio = 1.10
        porcentajeKi = 1.05

esGuerreroExperimentado :: GuerreroZ -> Bool
esGuerreroExperimentado = ((>= 22000) . ki)

-----------
--PUNTO 3--
-----------

estadoGuerrero :: GuerreroZ -> GuerreroZ
estadoGuerrero unGuerrero
    | (<porcentajeCansado unGuerrero) . cansancio $ unGuerrero  = cambioDeEstado "Fresco"   unGuerrero
    | (<porcentajeExhausto unGuerrero) . cansancio $ unGuerrero = cambioDeEstado "Cansado"  unGuerrero
    | otherwise                                      = cambioDeEstado "Exhausto" unGuerrero
    
porcentajeCansado :: GuerreroZ -> Float
porcentajeCansado = ((*0.44) . ki)
porcentajeExhausto :: GuerreroZ -> Float
porcentajeExhausto = ((*0.72) . ki)

cambioDeEstado :: String -> GuerreroZ -> GuerreroZ
cambioDeEstado nuevoEstado = modEstado (const nuevoEstado)

modEstado :: (String -> String) -> GuerreroZ -> GuerreroZ
modEstado f unGuerrero = unGuerrero {estado = f $ estado unGuerrero}

estaFresco :: GuerreroZ -> Bool
estaFresco = ((=="Fresco") . estado)

estaCansado :: GuerreroZ -> Bool
estaCansado = ((=="Cansado") . estado)

estaExhausto :: GuerreroZ -> Bool
estaExhausto = ((=="Exhausto") . estado)

realizaEjercicio :: Ejercicio -> GuerreroZ -> GuerreroZ
realizaEjercicio unEjercicio unGuerrero
    | estaExhausto unGuerrero = modKi (*0.98) unGuerrero
    | otherwise               = unEjercicio unGuerrero

-----------
--PUNTO 4--
-----------

type Rutina = [(Ejercicio,Descanso)]
type Descanso = Float

armarRutina :: GuerreroZ -> [Ejercicio] -> Rutina
armarRutina unGuerrero unosEjercicios 
    | (=="perezoso") . personalidad $ unGuerrero = creaRutina unosEjercicios 5
    | (=="sacado") . personalidad $ unGuerrero   = creaRutina unosEjercicios 0
    | otherwise                                  = creaRutina [] 0

creaRutina :: [Ejercicio] -> Float -> Rutina
creaRutina unosEjercicios tiempoDescanso = zip unosEjercicios listaDeNTiempos
    where
        listaDeNTiempos = take (length unosEjercicios) (repeat tiempoDescanso)

infinitosEjercicios :: Ejercicio -> [Ejercicio]
infinitosEjercicios = repeat

--Cuando armamos una rutina de infinitos ejercicios, el interpreter de Haskell nunca nos muestra la lista armada, ya que permanece armando una lista 
--con infinitos ejercicios e infinitos tiempos de descanso. Esto está relacionado con el concepto de "Evaluación ansiosa", donde el interpreter antes
--de poder mostrar el resultado debe primero llegar a un valor final (en nuestro caso, a una lista) 

-----------
--PUNTO 5--
-----------

realizarRutina :: Rutina -> GuerreroZ -> GuerreroZ
realizarRutina unaRutina unGuerrero
    | (=="sacado") . personalidad $ unGuerrero   = realizaVariosEjercicios unosEjercicios $ unGuerrero
    | (=="perezoso") . personalidad $ unGuerrero = descansar minutosDescanso . realizaVariosEjercicios unosEjercicios $ unGuerrero
    | otherwise                                  = unGuerrero
    where
        unosEjercicios = map (fst) unaRutina
        minutosDescanso = head $ map (snd) unaRutina

realizaVariosEjercicios :: [Ejercicio] -> GuerreroZ -> GuerreroZ
realizaVariosEjercicios unosEjercicios unGuerrero = foldl (flip realizaEjercicio) unGuerrero unosEjercicios

-----------
--PUNTO 6--
-----------

descansar :: Float -> GuerreroZ -> GuerreroZ
descansar tiempoDescanso = bajaCansancio (puntosDeDescanso tiempoDescanso)

puntosDeDescanso :: Float -> Float
puntosDeDescanso 0 = 0
puntosDeDescanso tiempoDescanso = tiempoDescanso + (puntosDeDescanso $ tiempoDescanso-1)

bajaCansancio :: Float -> GuerreroZ -> GuerreroZ
bajaCansancio cuantoCansancio = modCansancio (subtract cuantoCansancio)

-----------
--PUNTO 7-- (NO FUNCIONA)
-----------

--cantidadOptimaDescanso :: GuerreroZ -> Float
--cantidadOptimaDescanso unGuerrero
--    | estaCansado unGuerrero = descansar tiempoHastaEstarFresco unGuerrero
--    | otherwise              = 0
--    where
--        tiempoHastaEstarFresco = (cansancio unGuerrero) - (porcentajeCansado unGuerrero)