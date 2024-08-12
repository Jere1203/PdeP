import Data.List
import Text.Show.Functions

-----------
--Punto 1--
-----------

data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

type Palo = Habilidad -> Tiro

-- Funciones útiles
between n m x = elem x [n .. m]

--maximoSegun f = foldl1 (mayorSegun f)
--mayorSegun f a b
--  | f a > f b = a
--  | otherwise = b


putter :: Palo
putter unaHabilidad = UnTiro 10 (precisionJugador unaHabilidad * 2) 0

madera :: Palo
madera unaHabilidad = UnTiro 100 (precisionJugador unaHabilidad `div` 2) 5

hierros :: Int -> Palo
hierros n unaHabilidad = UnTiro (fuerzaJugador unaHabilidad * n) (precisionJugador unaHabilidad `div` n) (max 0 (n-3))

palos :: [Palo]
palos = [putter,madera] ++ map hierros [1..10]
-----------
--Punto 2--
-----------

golpe :: Palo -> Jugador -> Tiro
golpe unPalo = unPalo . habilidad

-----------
--Punto 3--
-----------

type Obstaculo = Tiro -> Tiro

atravesarObstaculo :: Obstaculo -> Tiro -> Tiro
atravesarObstaculo unObstaculo = unObstaculo  

tunelConRampita :: Obstaculo
tunelConRampita unTiro 
    | precision unTiro > 90 && vaAlRasDelSuelo unTiro = modificarPrecision (const 100) . modificarVelocidad (*2) $ unTiro
    | otherwise                                       = seDetiene unTiro

vaAlRasDelSuelo :: Tiro -> Bool
vaAlRasDelSuelo = (==0) . altura

seDetiene :: Tiro -> Tiro
seDetiene (UnTiro _ _ _) = UnTiro 0 0 0 

modificarAltura :: (Int -> Int) -> Tiro -> Tiro
modificarAltura f unTiro = unTiro {altura = f $ altura unTiro}

modificarPrecision :: (Int -> Int) -> Tiro -> Tiro
modificarPrecision f unTiro = unTiro {precision = f $ precision unTiro}

modificarVelocidad :: (Int -> Int) -> Tiro -> Tiro
modificarVelocidad f unTiro = unTiro {velocidad = f $ velocidad unTiro}

laguna :: Int -> Obstaculo
laguna longLaguna unTiro
    | velocidad unTiro > 80 && between 1 5 (altura unTiro) = modificarAltura (const alturaFinal) $ unTiro
    | otherwise                                            = seDetiene unTiro
    where
        alturaFinal = altura unTiro `div` longLaguna

hoyo :: Obstaculo
hoyo = seDetiene

-----------
--Punto 4--
-----------

tiroDetenido :: Tiro
tiroDetenido = UnTiro 0 0 0

palosUtiles :: Jugador -> Obstaculo  -> [Palo] -> [Palo]
palosUtiles unJugador unObstaculo = filter (superaAlObstaculo unObstaculo . flip golpe unJugador)

superaAlObstaculo :: Obstaculo -> Tiro -> Bool
superaAlObstaculo unObstaculo unTiro = (/= tiroDetenido) . atravesarObstaculo unObstaculo $ unTiro

obstaculosConsecutivosQueSupera :: Tiro -> [Obstaculo] -> Int
obstaculosConsecutivosQueSupera unTiro = length . obstaculosQueSupera unTiro

obstaculosQueSupera :: Tiro -> [Obstaculo] -> [Obstaculo]
obstaculosQueSupera unTiro = takeWhile (flip superaAlObstaculo unTiro)

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: Ord d => (c -> d) -> c -> c -> c
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

paloMasUtill :: Jugador -> [Obstaculo] -> Palo
paloMasUtill unJugador unosObstaculos = maximoSegun (flip obstaculosConsecutivosQueSupera unosObstaculos . flip golpe unJugador) $ palos

-----------
--Punto 5--
-----------

type Participante = (Jugador, Puntos)
type Participantes = [Participante]

padresQueNoGanaron :: Participantes -> [String]
padresQueNoGanaron unosParticipantes = listaDePadres . listaDePerdedores $ unosParticipantes

listaDePerdedores :: Participantes -> Participantes
listaDePerdedores unosParticipantes = filter (not . gana) $ unosParticipantes



puntos :: Participante -> Puntos
puntos = snd

listaDePadres :: Participantes -> [String]
listaDePadres unosJugadores = map padre . map fst $ unosJugadores