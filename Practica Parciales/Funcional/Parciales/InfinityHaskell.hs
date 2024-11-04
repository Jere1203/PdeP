import Text.Show.Functions
import Data.List
-----------
--Punto 1--
-----------

data Personaje = Personaje{
    nombre :: String,
    poder :: Int,
    derrotas :: [Derrota]
} deriving (Show)

type Derrota = (String, Int)

-----------
--Punto 2--
-----------
entrenamiento :: [Personaje] -> [Personaje]
entrenamiento unosPersonajes = map (multiplicarPoder . length $ unosPersonajes) unosPersonajes

multiplicarPoder :: Int -> Personaje -> Personaje
multiplicarPoder multiplicador unPersonaje = modificarPoder (multiplicador *) unPersonaje

modificarPoder :: (Int -> Int) -> Personaje -> Personaje
modificarPoder f unPersonaje = unPersonaje {poder = f $ poder unPersonaje}

-----------
--Punto 3--
-----------
rivalesDignos :: [Personaje] -> [Personaje]
rivalesDignos unosPersonajes = filter rivalDeThanos $ entrenamiento unosPersonajes

rivalDeThanos :: Personaje -> Bool
rivalDeThanos unPersonaje = poder unPersonaje > 500 && any ((== "Hijo de Thanos") . fst) (derrotas unPersonaje)

-----------
--Punto 4--
-----------
guerraCivil :: Int -> [Personaje] -> [Personaje] -> [Personaje]
guerraCivil anio grupo1 grupo2 = zipWith (pelea anio) grupo1 grupo2

pelea :: Int -> Personaje -> Personaje -> Personaje
pelea anio heroe1 heroe2 
    | gana heroe1 heroe2 = agregarDerrota (nombre heroe1, anio) heroe2
    | otherwise          = agregarDerrota (nombre heroe2, anio) heroe1

gana :: Personaje -> Personaje -> Bool
gana heroe1 heroe2 = poder heroe1 > poder heroe2

agregarDerrota :: Derrota -> Personaje -> Personaje
agregarDerrota unaDerrota unHeroe = unHeroe {derrotas = unaDerrota : derrotas unHeroe}

-----------
--Parte B--
-----------

-----------
--Punto 1--
-----------

type Equipamiento = Personaje -> Personaje

-----------
--Punto 2--
-----------

escudo :: Equipamiento
escudo unHeroe
    | (<5) . length . derrotas $ unHeroe = agregarPoder 50 unHeroe
    | otherwise                          = quitarPoder 100 unHeroe

agregarPoder :: Int -> Personaje -> Personaje
agregarPoder poder unHeroe = modificarPoder (poder +) unHeroe

quitarPoder :: Int -> Personaje -> Personaje
quitarPoder poder unHeroe = modificarPoder (subtract poder) unHeroe

trajeMecanizado :: String -> Equipamiento
trajeMecanizado unaVersion unHeroe = unHeroe {nombre = "Iron " ++ nombre unHeroe ++ "V" ++ unaVersion}

-----------
--Punto 3--
-----------

stormBreaker :: Equipamiento
stormBreaker unHeroe
    | (== "Thor") . nombre $ unHeroe = limpiarDerrotas . agregarSufijo ", dios del trueno" $ unHeroe
    | otherwise                      = unHeroe

agregarSufijo :: String -> Personaje -> Personaje
agregarSufijo sufijo unHeroe = unHeroe {nombre = nombre unHeroe ++ sufijo}

limpiarDerrotas :: Personaje -> Personaje
limpiarDerrotas unHeroe = unHeroe {derrotas = []}

thanos :: Personaje
thanos = Personaje{
    nombre = "Thanos",
    poder = 10000,
    derrotas = []
}

gemaDelAlma :: Int -> Equipamiento
gemaDelAlma unAnio unHeroe
    | (== "Thanos") . nombre $ unHeroe = modificarDerrotas (agregarExtras unAnio) unHeroe
    | otherwise                        = unHeroe

modificarDerrotas :: [Derrota] -> Personaje -> Personaje
modificarDerrotas unasDerrotas unPersonaje = unPersonaje {derrotas = unasDerrotas ++ derrotas unPersonaje}

agregarExtras :: Int -> [Derrota]
agregarExtras unAnio = zip (map extrasInfinitos [1..]) (iterate (+1) unAnio)

extrasInfinitos :: Int -> String
extrasInfinitos unNumero = "Extra numero " ++ show unNumero

--guanteleteInfinito :: [Equipamiento] -> Personaje -> Personaje
--guanteleteInfinito unosEquipamientos unHeroe = foldl (\x f -> f x) unHeroe $ filtrarGemaInfinito unosEquipamientos
--
--filtrarGemaInfinito :: [Equipamiento] -> [Equipamiento]
--filtrarGemaInfinito  = filter (esGemaDelInfinito)

-----------
--Parte C--
-----------

--Black Widow tiene infinitas derrotas:
--a. ¿Qué pasará si le decimos que utilice el escudo? Justificá.
--b. ¿Qué pasará si al usar rivalesDignos, blackWidow formase parte de la lista que pasamos por
--parámetro? Justificá
--c. ¿Podemos conseguir las primeras 100 derrotas de Thanos luego de usar la gema del alma?
--Justificá.

-- a) Se le quitará 100 de poder, ya que excede las 5 derrotas.
-- b) Dependerá si contiene en su lista de derrota a "Hijo de Thanos" o si, luego de entrenar, su poder es mayor a 500
-- c) Si, utilizando la funcion "take 100" podemos obtener las primeras 100 derrotas de la lista, esta funcion se la debe componer a gemaDelAlma y aplicársela a Thanos.
--    se analiza la situacion de la siguiente manera: take 100 . derrotas $ gemaDelAlma 2018 thanos
    