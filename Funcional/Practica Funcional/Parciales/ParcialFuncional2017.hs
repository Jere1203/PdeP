import Data.List
import Text.Show.Functions

-----------
--Punto 1--
-----------

data Carrera = Carrera{
    vueltas :: Int,
    longitud :: Int,
    participantes :: [Auto],
    publico :: [String]
} deriving(Show)

data Auto = Auto{
    nombre :: String,
    nivelDeNafta :: Int,
    velocidad :: Int,
    nombreEnamorado :: String,
    truco :: Truco
} deriving(Show)

rochaMcQueen = Auto "Rocha Mc Queen" 282 0 "Ronco" (deReversaRocha (Carrera _ longitud _ _))

biankerr = Auto "Biankerr" 378 0 "Tincho" (impresionar (Carrera _ _ _ publico))

gushtav = Auto "Gushtav" 230 0 "Peti" (nitro)

rodra = Auto "Rodra" 153 0 "Tais" (comboLoco (Carrera _ longitud _ _))

type Truco = Auto -> Auto

-----------
--Punto 2--
-----------

deReversaRocha :: Carrera -> Truco
deReversaRocha unaCarrera = aumentarNafta (5 * longitud unaCarrera)

aumentarNafta :: Int -> Auto -> Auto
aumentarNafta cantidadNafta = modificarNafta (+ cantidadNafta)

modificarNafta :: (Int -> Int) -> Auto -> Auto
modificarNafta unaFuncion unAuto = unAuto {nivelDeNafta = unaFuncion $ nivelDeNafta unAuto}

modificarVelocidad :: (Int -> Int) -> Auto -> Auto
modificarVelocidad unaFuncion unAuto = unAuto {velocidad = unaFuncion $ velocidad unAuto}

aumentarVelocidad :: Int -> Auto -> Auto
aumentarVelocidad cantidadVelocidad = modificarVelocidad (+ cantidadVelocidad)

impresionar :: Carrera -> Truco
impresionar unaCarrera unAuto
    | estaEnLaCarrera (nombreEnamorado unAuto) unaCarrera = aumentarVelocidad (2*velocidad unAuto) $ unAuto
    | otherwise                                           = unAuto

estaEnLaCarrera :: String -> Carrera -> Bool
estaEnLaCarrera nombre = any (== nombre) . publico

nitro :: Truco
nitro = aumentarVelocidad 15

comboLoco :: Carrera -> Truco
comboLoco unaCarrera = nitro . deReversaRocha unaCarrera    

-----------
--Punto 3--
-----------

darVuelta :: Carrera -> Auto -> Auto
darVuelta unaCarrera unAuto
    | entre 1 5 $ nombre unAuto  = aumentarVelocidad 15 $ unAuto
    | entre 6 8 $ nombre unAuto  = aumentarVelocidad 20 $ unAuto
    | length (nombre unAuto) > 8 = aumentarVelocidad 30 $ unAuto

entre :: Int -> Int -> String -> Bool
entre a b c = elem (length c) [a..b]

-----------
--Punto 4--
-----------

correrCarrera :: Int -> Carrera -> Auto -> Auto
correrCarrera cantidadVueltas unaCarrera unAuto
    | cantidadVueltas == 0 = unAuto
    | otherwise            = correrCarrera (vueltas unaCarrera-1) unaCarrera . darVuelta unaCarrera $ unAuto

-----------
--Punto 5--
-----------

gano :: Auto -> Carrera -> Bool
gano unAuto unaCarrera = all ((<) (velocidad unAuto)) . map velocidad . filter (/= unAuto) $ participantes unaCarrera

-----------
--Punto 6--
-----------

recompetidores :: Carrera -> [Auto]
recompetidores unaCarrera = filter (puedeRecompetir unaCarrera . correrCarrera (vueltas unaCarrera) unaCarrera) . participantes $ unaCarrera

puedeRecompetir :: Carrera -> Auto -> Bool
puedeRecompetir unaCarrera unAuto = nivelDeNafta unAuto > 27 || gano unAuto unaCarrera

-----------
--Punto 7--
-----------

--a) Si, se puede recorrer ya que tiene una cantidad de vueltas finita, y por Lazy Evaluation Haskell deja de operar sobre la lista infinita cuando ya no se considera necesario, en este caso, cuando ya se recorrió el total de las vueltas.
--b) No, ya que al ser infinitos participantes nunca se arribaría a un valor final de cuál auto tiene mayor velocidad luego de la vuelta 2 ya que el interpreter se quedaría comparando de forma infinita las velocidades de cada uno.
--c) Si, se puede dar la primera vuelta por lo mencionado en el inciso a), ya que al realizar la primera vuelta haskell deja de operar sobre la lista.