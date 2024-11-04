import Data.List
import Text.Show.Functions

-- ========================================PARTE A=================================================
-----------
--Punto 1--
-----------

data Personaje = Personaje{
    nombre :: String,
    poder :: Int,
    derrotas :: [Derrota],
    equipamiento :: [Equipamiento]
} deriving(Show)

data Derrota = Derrota{
    nombreOponente :: String,
    anio :: Int
} deriving(Show)

-----------
--Punto 2--
-----------

entrenamiento :: [Personaje] -> [Personaje]
entrenamiento personajes = map (multiplicarPoder (cantidadPersonajes)) personajes
    where
        cantidadPersonajes = length personajes

multiplicarPoder :: Int -> Personaje -> Personaje
multiplicarPoder cantidadPoder = modificarPoder (*cantidadPoder)

modificarPoder :: (Int -> Int) -> Personaje -> Personaje
modificarPoder unaFuncion unPersonaje = unPersonaje {poder = unaFuncion $ poder unPersonaje}

-----------
--Punto 3--
-----------

rivalesDignos :: [Personaje] -> [Personaje]
rivalesDignos = filter (esRivalDigno) . entrenamiento

esRivalDigno :: Personaje -> Bool
esRivalDigno unPersonaje = any (== "Hijo de Thanos") (oponentes unPersonaje) && poder unPersonaje > 500

oponentes :: Personaje -> [String]
oponentes unPersonaje = map nombreOponente (derrotas unPersonaje)

-----------
--Punto 4--
-----------

guerraCivil :: Int -> [Personaje] -> [Personaje] -> [Personaje]
guerraCivil unAnio grupo1 grupo2 = zipWith (pelear unAnio) grupo1 grupo2

pelear :: Int -> Personaje -> Personaje -> Personaje
pelear unAnio ganador perdedor
    | gana ganador perdedor = agregarDerrota unAnio perdedor $ ganador
    | otherwise             = agregarDerrota unAnio ganador $ perdedor

agregarDerrota :: Int -> Personaje -> Personaje -> Personaje
agregarDerrota unAnio perdedor ganador = ganador {derrotas = (Derrota (nombre perdedor) unAnio) : derrotas ganador}

gana :: Personaje -> Personaje -> Bool
gana unPersonaje otroPersonaje = poder unPersonaje > poder otroPersonaje 

-- ============================================PARTE B ==========================================00
-----------
--Punto 1--
-----------

type Equipamiento = Personaje -> Personaje

-----------
--Punto 2--
-----------

escudo :: Equipamiento
escudo unPersonaje
    | cantidadDerrotas < 5 = aumentaPoder 50 $ unPersonaje
    | otherwise            = aumentaPoder (-100) $ unPersonaje
    where
        cantidadDerrotas = length . derrotas $ unPersonaje

aumentaPoder :: Int -> Personaje -> Personaje
aumentaPoder cantidadPoder = modificarPoder (+cantidadPoder)

trajeMecanizado :: String -> Equipamiento
trajeMecanizado versionTraje = modificarNombre("Iron" ++) . modificarNombre(++ "V" ++ versionTraje)

modificarNombre :: (String -> String) -> Personaje -> Personaje
modificarNombre unaFuncion unPersonaje = unPersonaje {nombre = unaFuncion $ nombre unPersonaje}

-----------
--Punto 3--
-----------

stormBreaker :: Equipamiento
stormBreaker (Personaje "Thor" poder derrotas equipamiento) = (Personaje "Thor, dios del trueno" poder [] equipamiento)
stormBreaker (Personaje nombre poder derrotas equipamiento) = (Personaje nombre poder derrotas equipamiento)

--gemaDelAlma :: Equipamiento
--gemaDelAlma (Personaje "Thanos" poder derrotas equipaimento) = (Personaje "Thanos" poder [(Derrota (map (infinitosExtras) [1..]) (map (show) [2018..]))] equipaimento)
--gemaDelAlma (Personaje nombre poder derrotas equipaimento)   = (Personaje nombre poder derrotas equipaimento)

infinitosExtras :: Int -> String
infinitosExtras n = "Extra numero " ++ show n

--guanteleteInfinito :: Equipamiento
--guanteleteInfinito unPersonaje
--    | nombre unPersonaje == "Thanos" = foldl (\unPersonaje unosEquipamientos -> unosEquipamientos unPersonaje) unPersonaje . filter (esGemaDelInfinito) equipamiento $ unPersonaje
--    | otherwise                      = unPersonaje

-- ===================================================================Parte C=================================================================

--No se podra arribar a un resultado final ya que al contener una infinita lista de derrotas no se podra calcular la cantidad de elementos de la misma
--En caso que uno de los infinitos derrotados sea "Hijo de Thanos" se arribara a un resultado final ya que Haskell utiliza Lazy Evaluation, motivo por el cual dejara de operar sobre la lista infinita una vez encuentra el rival buscado. Caso contrario nunca se llegara a un resultado final y no se sabra si es rival digno.
--Si, ya que como se menciono anteriormente Haskell utiliza lazy evaluation, lo cual nos permite operar sobre una lista infinita siempre y cuando se pueda alcanzar un resultado final.
--Por ejemplo, si utilizasemos "take 100" en la lista infinita de derrotas de thanos, a partir de la derrota 100 Haskell dejara de operar sobre la lista y nos mostrara los 100 primeros derrotados.
