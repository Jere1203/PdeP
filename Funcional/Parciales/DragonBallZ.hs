import Text.Show.Functions
import Data.List

-- Main*> :t takeWhile
-- takeWhile :: (a -> Bool) -> [a] -> [a]
-- Main*> takeWhile even [2,4,6,5,6,7,8,9]
-- [2,4,6]

-----------
--Punto 1--
-----------
data GuerreroZ = GuerreroZ {
    nombre :: String,
    ki :: Float,
    raza :: Raza,
    cansancio :: Float,
    personalidad :: Personalidad
} deriving (Show, Eq)

data Raza = Saiyajin | Humano | Namekusei deriving (Show,Eq)
data Personalidad = Sacado | Perezoso | Tramposo deriving (Show,Eq)

gohan :: GuerreroZ
gohan = GuerreroZ{
    nombre = "Gohan",
    ki = 10000,
    raza = Saiyajin,
    cansancio = 0,
    personalidad = Perezoso
}

vegeta :: GuerreroZ
vegeta = GuerreroZ "Vegeta" 1000 Saiyajin 444 Sacado

yajirobe :: GuerreroZ
yajirobe = GuerreroZ "Yajirobe" 100 Humano 0 Tramposo

-----------
--Punto 2--
-----------
esPoderoso :: GuerreroZ -> Bool
esPoderoso unGuerrero = ki unGuerrero > 8000 || raza unGuerrero == Saiyajin 


type Ejercicio = GuerreroZ -> GuerreroZ

pressDeBanca :: Ejercicio
pressDeBanca = aumentaKi (90) . aumentaCansancio(100)

aumentaCansancio :: Float -> GuerreroZ -> GuerreroZ
aumentaCansancio cantidadCansancio unGuerrero = unGuerrero {cansancio = max 0 (cantidadCansancio + cansancio unGuerrero)}

aumentaKi :: Float -> GuerreroZ -> GuerreroZ
aumentaKi cantidadKi unGuerrero = unGuerrero {ki = cantidadKi + ki unGuerrero}

flexionesDeBrazo :: Ejercicio
flexionesDeBrazo = aumentaCansancio (50)

saltosAlCajon :: Float -> Ejercicio
saltosAlCajon medidaCajon =  aumentaCansancio (medidaCajon / 5) . aumentaKi(medidaCajon / 10)

snatch :: Ejercicio
snatch unGuerrero
    | esGuerreroExperimentado unGuerrero = aumentaKi (ki unGuerrero * 0.05) . aumentaCansancio(ki unGuerrero * 0.10) $ unGuerrero
    | otherwise                          = aumentaCansancio (100) unGuerrero 

esGuerreroExperimentado :: GuerreroZ -> Bool
esGuerreroExperimentado = (>= 22000) . ki

estaCansado :: GuerreroZ -> Bool
estaCansado unGuerrero = cansancio unGuerrero > ki unGuerrero * 0.44 && not (estaExhausto unGuerrero)

estaExhausto :: GuerreroZ -> Bool
estaExhausto unGuerrero = (> ki unGuerrero * 0.72) . cansancio $ unGuerrero

-----------
--Punto 3--
-----------

realizaEjercicio :: Ejercicio -> GuerreroZ -> GuerreroZ
realizaEjercicio unEjercicio unGuerrero
    | estaCansado unGuerrero  = realizaEjercicioCansado unEjercicio unGuerrero
    | estaExhausto unGuerrero = aumentaKi (- ki unGuerrero * 0.02) unGuerrero
    | otherwise               = unEjercicio unGuerrero

realizaEjercicioCansado :: Ejercicio -> GuerreroZ -> GuerreroZ
realizaEjercicioCansado unEjercicio unGuerrero = aumentaKi alDoble . aumentaCansancio alCuadruple $ unGuerrero

    where
        alDoble     = (ki (unEjercicio unGuerrero) - ki unGuerrero) * 2
        alCuadruple = (ki (unEjercicio unGuerrero) - ki unGuerrero) * 4

-----------
--Punto 4--
-----------
type Rutina = [(Ejercicio,TiempoDescanso)]
type TiempoDescanso = Float

armarRutina :: GuerreroZ -> [Ejercicio] -> Rutina
armarRutina unGuerrero unosEjercicios
    | (==Sacado) . personalidad $ unGuerrero   = armaRutinaSacados unosEjercicios
    | (==Perezoso) . personalidad $ unGuerrero = armaRutinaPerezosos unosEjercicios
    | otherwise                                = []

armaRutinaSacados :: [Ejercicio] -> Rutina
armaRutinaSacados unosEjercicios = zip (unosEjercicios) (repeat 0)

armaRutinaPerezosos :: [Ejercicio] -> Rutina
armaRutinaPerezosos unosEjercicios = zip (unosEjercicios) (repeat 5)

rutinaInfinita :: Ejercicio -> Rutina
rutinaInfinita unEjercicio = armarRutina gohan (repeat unEjercicio)

-- Haskell al utilizar Lazy Evaluation no requiere inferir una lista completa para poder operar sobre ella, por ejemplo, si utilizasemos la funcion
-- "head", "!!" o incluso "take" podriamos obtener un valor definitivo sin mayor inconveniente.

-----------
--Punto 5--
-----------

serieDeEjercicios :: Rutina -> [Ejercicio]
serieDeEjercicios = map fst

realizaRutina :: Rutina -> GuerreroZ -> GuerreroZ
realizaRutina unaRutina unGuerrero = foldl (flip realizaEjercicio) unGuerrero (serieDeEjercicios unaRutina)


-----------
--Punto 6--
-----------

descansar :: Float -> GuerreroZ -> GuerreroZ
descansar unosMinutos unGuerrero = aumentaCansancio (- puntosDeDescanso unosMinutos) unGuerrero

puntosDeDescanso :: Float -> Float
puntosDeDescanso 0 = 0
puntosDeDescanso unosMinutos = unosMinutos + puntosDeDescanso(unosMinutos - 1)

-----------
--Punto 7--
-----------

cantidadOptimaDeMinutos :: GuerreroZ -> Float
cantidadOptimaDeMinutos unGuerrero
    | not . estaCansado $ unGuerrero = 0
    | otherwise                      = last $ takeWhile (estaCansado . flip descansar unGuerrero) [1..]
