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
pressDeBanca = sumarKi (90) . sumarCansancio(100)

sumarKi :: Float -> GuerreroZ -> GuerreroZ
sumarKi cantidadKi = modificarKi (+cantidadKi)

sumarCansancio :: Float -> GuerreroZ -> GuerreroZ
sumarCansancio cantidadCansancio = modificarCansancio (+cantidadCansancio)

modificarCansancio :: (Float -> Float) -> GuerreroZ -> GuerreroZ
modificarCansancio cantidadCansancio unGuerrero = unGuerrero {cansancio = max 0 (cantidadCansancio $ cansancio unGuerrero)}

modificarKi :: (Float -> Float) -> GuerreroZ -> GuerreroZ
modificarKi cantidadKi unGuerrero = unGuerrero {ki = cantidadKi $ ki unGuerrero}

flexionesDeBrazo :: Ejercicio
flexionesDeBrazo = sumarCansancio (50)

saltosAlCajon :: Float -> Ejercicio
saltosAlCajon medidaCajon =  sumarCansancio (medidaCajon / 5) . sumarKi(medidaCajon / 10)

snatch :: Ejercicio
snatch unGuerrero
    | esGuerreroExperimentado unGuerrero = sumarKi (ki unGuerrero * 0.05) . sumarCansancio(ki unGuerrero * 0.10) $ unGuerrero
    | otherwise                          = sumarCansancio (100) unGuerrero 

esGuerreroExperimentado :: GuerreroZ -> Bool
esGuerreroExperimentado = (>= 22000) . ki

estaCansado :: GuerreroZ -> Bool
estaCansado unGuerrero = (> porcentajeKi 44 unGuerrero) . cansancio $ unGuerrero

estaExhausto :: GuerreroZ -> Bool
estaExhausto unGuerrero = (> porcentajeKi 72 unGuerrero) . cansancio $ unGuerrero

-----------
--Punto 3--
-----------

realizaEjercicio :: Ejercicio -> GuerreroZ -> GuerreroZ
realizaEjercicio unEjercicio unGuerrero
    | estaExhausto unGuerrero = sumarKi (- porcentajeKi 20 unGuerrero) unGuerrero
    | estaCansado unGuerrero  = realizaEjercicioCansado unEjercicio unGuerrero
    | otherwise               = unEjercicio unGuerrero

porcentajeKi :: Float -> GuerreroZ -> Float
porcentajeKi unPorcentaje unGuerrero = ki unGuerrero * (unPorcentaje/100)

realizaEjercicioCansado :: Ejercicio -> GuerreroZ -> GuerreroZ
realizaEjercicioCansado unEjercicio unGuerrero = sumarKi alDoble . sumarCansancio alCuadruple $ unGuerrero

    where
        alDoble     = (diferenciaDeAtributo ki unGuerrero unEjercicio) * 2
        alCuadruple = (diferenciaDeAtributo cansancio unGuerrero unEjercicio) * 4

diferenciaDeAtributo :: (GuerreroZ -> Float) -> GuerreroZ -> Ejercicio -> Float
diferenciaDeAtributo unAtributo unGuerrero unEjercicio = unAtributo (unEjercicio unGuerrero) - unAtributo unGuerrero

-----------
--Punto 4--
-----------
type Rutina = [(Ejercicio, Descanso)]
type Descanso = Float

armarRutina' :: GuerreroZ -> [Ejercicio] -> Rutina
armarRutina' (GuerreroZ _ _ _ _ Sacado)   unosEjercicios    = armaRutina unosEjercicios 0
armarRutina' (GuerreroZ _ _ _ _ Perezoso) unosEjercicios    = armaRutina unosEjercicios 5
armarRutina' (GuerreroZ _ _ _ _ _)        unosEjercicios    = []

armaRutina :: [Ejercicio] -> Float -> Rutina
armaRutina unosEjercicios tiempoDescanso = zip (unosEjercicios) (repeat tiempoDescanso)

--rutinaInfinita :: Ejercicio -> Rutina
--rutinaInfinita unEjercicio = armarRutina gohan (repeat unEjercicio)

-- Haskell al utilizar Lazy Evaluation no requiere evaluar una lista completa para poder operar sobre ella, por ejemplo, si utilizasemos la funcion
-- "head", "!!" o incluso "take" podriamos obtener un valor definitivo sin mayor inconveniente.

-----------
--Punto 5--
-----------

serieDeEjercicios :: Rutina -> [Ejercicio]
serieDeEjercicios = map fst

realizaRutina :: GuerreroZ -> Rutina-> GuerreroZ
realizaRutina unGuerrero unaRutina  = foldl (flip realizaEjercicio) unGuerrero $ serieDeEjercicios unaRutina


-----------
--Punto 6--
-----------

descansar :: Float -> GuerreroZ -> GuerreroZ
descansar unosMinutos unGuerrero = sumarCansancio (- puntosDeDescanso) unGuerrero
    where
        puntosDeDescanso = calcularPuntosDeDescanso unosMinutos

calcularPuntosDeDescanso :: Float -> Float
calcularPuntosDeDescanso 0 = 0
calcularPuntosDeDescanso unosMinutos = unosMinutos + calcularPuntosDeDescanso(unosMinutos - 1)

-----------
--Punto 7--
-----------

cantidadOptimaDeMinutos :: GuerreroZ -> Float
cantidadOptimaDeMinutos unGuerrero
    | not . estaCansado $ unGuerrero = 0
    | otherwise                      = head $ filter (not . estaCansado . flip descansar unGuerrero) [0..]
