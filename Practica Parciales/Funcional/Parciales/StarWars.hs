import Text.Show.Functions
import Data.List

-----------
--Punto 1--
-----------

data Nave = Nave {
    nombre :: String,
    durabilidad :: Int,
    escudo :: Int,
    ataque :: Int,
    poder :: Habilidad
} deriving (Show)

type Habilidad = (Nave -> Nave)

tieFigther :: Nave
tieFigther = Nave "Tie Fighter" 200 100 50 movimientoTurbo

movimientoTurbo :: Habilidad
movimientoTurbo unaNave = modAtaque (+25) unaNave

modAtaque :: (Int -> Int) -> Nave -> Nave
modAtaque f unaNave = unaNave {ataque = max 0 . f $ ataque unaNave}

xWing :: Nave
xWing = Nave "X-Wing" 300 150 100 reparacionEmergencia

reparacionEmergencia :: Habilidad
reparacionEmergencia unaNave = modDurabilidad (+50) . modAtaque (subtract 30) $ unaNave

modDurabilidad :: (Int -> Int) -> Nave -> Nave
modDurabilidad f unaNave = unaNave {durabilidad = max 0 . f $ durabilidad unaNave}

naveDarthVader :: Nave
naveDarthVader = Nave "Nave de Darth Vader" 500 300 200 (movimientoSuperTurbo . quitarDurabilidad 45)

quitarDurabilidad :: Int -> Nave -> Nave
quitarDurabilidad cant = modDurabilidad (subtract cant)

movimientoSuperTurbo :: Nave -> Nave
movimientoSuperTurbo = movimientoTurboNVeces 3

movimientoTurboNVeces :: Int -> Nave -> Nave
movimientoTurboNVeces n unaNave
    | n > 0 = movimientoTurboNVeces (n-1) $ movimientoTurbo unaNave
    | otherwise = unaNave

milleniumFalcon :: Nave
milleniumFalcon = Nave "Millenium Falcon" 1000 500 50 (reparacionEmergencia . incrementarEscudos 100) 

incrementarEscudos :: Int -> Nave -> Nave
incrementarEscudos cantidad = modEscudos (+ cantidad)

modEscudos :: (Int -> Int) -> Nave -> Nave
modEscudos f unaNave = unaNave {escudo = max 0 . f $ escudo unaNave}

starDestroyer :: Nave
starDestroyer = Nave "Imperial Star Destroyer" 10000 50000 20000 saltoAlHiperespacio --Incrementa los escudos y reduce el daño

saltoAlHiperespacio :: Habilidad
saltoAlHiperespacio = incrementarEscudos 25000 . reducirAtaque 10000

reducirAtaque :: Int -> Nave -> Nave
reducirAtaque cant = modAtaque (subtract cant)

-----------
--Punto 2--
-----------

durabilidadTotal :: [Nave] -> Int
durabilidadTotal = sum . map durabilidad

-----------
--Punto 3--
-----------

enfrentamientoNaves :: Nave -> Nave -> Nave
enfrentamientoNaves atacante defensora = peleaDeNaves (aplicarPoder (poder atacante) atacante) (aplicarPoder (poder defensora) defensora)

aplicarPoder :: Habilidad -> Nave -> Nave
aplicarPoder f unaNave = f $ unaNave

peleaDeNaves :: Nave -> Nave -> Nave
peleaDeNaves atacante defensora 
    | (< ataque atacante) . escudo $ defensora  = reducirDurabilidad (danioRecibido atacante defensora) $ defensora
    | otherwise                                 = defensora

reducirDurabilidad :: Int -> Nave -> Nave
reducirDurabilidad cant =  modDurabilidad (subtract cant)


danioRecibido :: Nave -> Nave -> Int
danioRecibido atacante defensora = abs $ escudo defensora - ataque atacante


-----------
--Punto 4--
-----------

estaFueraDeCombate :: Nave -> Bool  
estaFueraDeCombate = (== 0) . durabilidad 

-----------
--Punto 5--
-----------

type Estrategia = Nave -> Bool

esNaveDebil :: Estrategia
esNaveDebil = (<200) . escudo

navesConPeligrosidad :: Int -> Estrategia
navesConPeligrosidad peligrosidad = (> peligrosidad) . ataque

quedaFueraDeCombate :: Nave -> Estrategia
quedaFueraDeCombate naveAtacante naveDefensora = estaFueraDeCombate . enfrentamientoNaves naveAtacante $ naveDefensora

recibeDanioCritico :: Nave -> Estrategia
recibeDanioCritico naveAtacante = (== 0) . escudo . ataqueNave naveAtacante

ataqueNave :: Nave -> Nave -> Nave
ataqueNave naveAtacante = modEscudos (subtract $ ataque naveAtacante)

misionSorpresa :: Nave -> Estrategia -> [Nave] -> [Nave] 
misionSorpresa unaNave unaEstrategia unaFlota = map (atacarSegunEstrategia unaNave unaEstrategia) unaFlota

atacarSegunEstrategia :: Nave -> Estrategia -> Nave -> Nave
atacarSegunEstrategia unaNave unaEstrategia naveFlota
    | unaEstrategia naveFlota = enfrentamientoNaves unaNave naveFlota
    | otherwise               = naveFlota

-----------
--Punto 6--
-----------

mejorEstrategia :: Estrategia -> Estrategia -> [Nave] -> Nave -> [Nave]
mejorEstrategia estrategia1 estrategia2 unaFlota unaNave = flotaConMenorDurabilidad (misionSorpresa unaNave estrategia1 unaFlota) (misionSorpresa unaNave estrategia2 unaFlota)

flotaConMenorDurabilidad :: [Nave] -> [Nave] -> [Nave]
flotaConMenorDurabilidad flota1 flota2
    | durabilidadTotal flota1 > durabilidadTotal flota2 = flota2
    | otherwise                                         = flota1

-----------
--Punto 7--
-----------
flotaInfinita :: Nave ->[Nave]
flotaInfinita = repeat

-- ¿Es posible determinar su durabilidad total?
-- No, ya que el lenguaje haskell utiliza evualuación ansiosa cuando realiza sumatorias en listas, por lo tanto, nunca se llegará a un resultado final ya que se encuentra sumando infinitamente.

-- ¿Qué se obtiene como respuesta cuando se lleva adelante una misión sobre ella?
-- Se obtienen infinitos resultados.