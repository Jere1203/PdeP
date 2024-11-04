import Data.List
import Text.Show.Functions

-----------
--Punto 1--
-----------

data Auto = Auto {
    marca :: String,
    modelo :: String,
    desgaste :: Desgaste,
    velocidadMaxima :: Float,
    tiempoCarrera :: Float
} deriving(Show)

type Desgaste = (Float,Float) --Primer componente es de chasis y la segunda de ruedas

ferrari :: Auto
ferrari = Auto "Ferrari" "F50" (0,0) 65 0

lamborghini :: Auto
lamborghini = Auto "Lamborghini" "Diablo" (7,4) 73 0

fiat :: Auto
fiat = Auto "Fiat" "600" (33,27) 44 0

-----------
--Punto 2--
-----------
chasis :: Desgaste -> Float
chasis = fst
ruedas :: Desgaste -> Float 
ruedas = snd

estaEnBuenEstado :: Auto -> Bool
estaEnBuenEstado unAuto = chasis (desgaste unAuto) < 40 && ruedas (desgaste unAuto) < 60

noDaMas :: Auto -> Bool
noDaMas unAuto = chasis (desgaste unAuto) > 80 || ruedas (desgaste unAuto) > 80

-----------
--Punto 3--
-----------

repararAuto :: Auto -> Auto
repararAuto unAuto = modDesgasteChasis (*0.15) . modDesgasteRuedas (const 0) $ unAuto

modDesgasteChasis :: (Float -> Float) -> Auto -> Auto
modDesgasteChasis f unAuto = unAuto {desgaste = (f $ chasis (desgaste unAuto), ruedas (desgaste unAuto))}

modDesgasteRuedas :: (Float -> Float) -> Auto -> Auto
modDesgasteRuedas f unAuto = unAuto {desgaste = (chasis (desgaste unAuto), f $ ruedas (desgaste unAuto))}

-----------
--Punto 4--
-----------

type Tramo = Auto -> Auto

atraviesaCurva :: Float -> Float -> Tramo
atraviesaCurva unAngulo unaLongitud unAuto = modDesgasteRuedas (+desgasteCurva) . sumaTiempo tiempoCurva $ unAuto

    where 
        desgasteCurva = 3 * unaLongitud / unAngulo
        tiempoCurva   = unaLongitud / mediaMaximaVelocidad unAuto


mediaMaximaVelocidad :: Auto -> Float
mediaMaximaVelocidad unAuto = velocidadMaxima unAuto / 2

sumaTiempo :: Float -> Auto -> Auto
sumaTiempo unTiempo unAuto = modTiempo (+unTiempo) unAuto

modTiempo :: (Float -> Float) -> Auto -> Auto
modTiempo f unAuto = unAuto {tiempoCarrera = f $ tiempoCarrera unAuto}

curvaPeligrosa :: Tramo
curvaPeligrosa = atraviesaCurva 60 300

curvaTranca :: Tramo
curvaTranca = atraviesaCurva 110 550

--b) 

atraviesaTramoRecto :: Float -> Tramo
atraviesaTramoRecto unaLongitud unAuto = modDesgasteChasis (+ unaLongitud/100) . sumaTiempo (tiempoTramo unaLongitud unAuto) $ unAuto

tiempoTramo :: Float -> Auto -> Float
tiempoTramo unaLongitud unAuto = unaLongitud / velocidadMaxima unAuto

tramoRectoClassic :: Tramo
tramoRectoClassic = atraviesaTramoRecto 750

tramito :: Tramo
tramito = atraviesaTramoRecto 280

--c)

tramoBoxes :: Tramo -> Auto -> Auto
tramoBoxes unTramo unAuto
    | estaEnBuenEstado unAuto = unTramo unAuto
    | otherwise               = sumaTiempo (10) . unTramo . repararAuto $ unAuto

--d)

tramoMojado :: Tramo -> Auto -> Auto
tramoMojado unTramo unAuto = sumaTiempo (tiempoMojado unTramo unAuto) . unTramo $ unAuto

tiempoMojado :: Tramo -> Auto -> Float
tiempoMojado unTramo unAuto = (tiempoCarrera (unTramo unAuto) - tiempoCarrera unAuto)/2

--e)

tramoRipio :: Tramo -> Auto -> Auto
tramoRipio unTramo = (unTramo . unTramo)

--f)

tramoObstruido :: Float -> Tramo -> Auto -> Auto
tramoObstruido distObstruida unTramo unAuto = modDesgasteRuedas (+ cantDesgate) . unTramo $ unAuto

    where
        cantDesgate = 2 * distObstruida

-----------
--Punto 5--
-----------

pasarPorTramo :: Tramo -> Auto -> Auto
pasarPorTramo unTramo unAuto
    | not . noDaMas $ unAuto = unTramo unAuto
    | otherwise              = id unAuto

-----------
--Punto 6--
-----------

type Pista = [Tramo]
superPista :: Pista
superPista = [
        tramoRectoClassic,
        curvaTranca,
        tramito . tramoMojado tramito,
        tramoObstruido 2 $ atraviesaCurva 80 400,
        atraviesaCurva 115 650,
        atraviesaTramoRecto 970,
        curvaPeligrosa,
        tramoRipio tramito,
        tramoBoxes $ atraviesaTramoRecto 800
    ]   

--b) 

peganLaVuelta :: Pista -> [Auto] -> [Auto]
peganLaVuelta unaPista unosAutos = filter (not . noDaMas) . map (pegaLaVuelta unaPista) $ unosAutos

pegaLaVuelta :: Pista -> Auto -> Auto
pegaLaVuelta unaPista unAuto = foldl (\unAuto unaPista -> unaPista unAuto) unAuto unaPista

-----------
--Punto 7--
-----------

data Carrera = Carrera{
    vueltas :: Int,
    pista :: Pista
} deriving (Show)

tourBuenosAires :: Carrera
tourBuenosAires = Carrera 20 superPista

correCarrera :: Carrera -> [Auto] -> [[Auto]]
correCarrera unaCarrera unosAutos = take (vueltas unaCarrera) . daVariasVueltas (pista unaCarrera) $ unosAutos

daVariasVueltas :: Pista -> [Auto] -> [[Auto]]
daVariasVueltas unaPista unosAutos = iterate (peganLaVuelta unaPista) unosAutos