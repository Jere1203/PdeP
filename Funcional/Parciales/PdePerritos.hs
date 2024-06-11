import Data.List
import Text.Show.Functions

-----------
--Parte A--
-----------

data Perro = Perro {
    raza :: String,
    juguetesFavoritos :: Juguetes,
    tiempoPermanencia :: Int,
    energia :: Int
} deriving (Show)

zara :: Perro
zara = Perro "dalmata" ["pelota","mantita"] 90 80

perroPi :: Perro
perroPi = Perro "labrador" (sogasInfinitas) 314 159

sogasInfinitas :: Juguetes
sogasInfinitas = map soguitasInfinitas [1..]

soguitasInfinitas :: Int -> String
soguitasInfinitas n = "soguita " ++ show n

guarderiaPDePerritos :: Guarderia
guarderiaPDePerritos = Guarderia "Guarderia P de Perritos" [(jugar,30),(ladrar 18,20),(regalar "pelota",0),(diaDeSpa,120),(diaDeCampo,720)]

type Juguetes = [String]

data Guarderia = Guarderia {
    nombre :: String,
    rutina :: [(Actividad,Int)]
} deriving (Show)

type Actividad = Perro -> Perro

jugar :: Actividad
jugar = disminuyeEnergia 10

disminuyeEnergia :: Int -> Perro -> Perro
disminuyeEnergia cantidadEnergia = modEnergia (subtract cantidadEnergia)

modEnergia :: (Int -> Int) -> Perro -> Perro
modEnergia f unPerro = unPerro {energia = max 0 . f $ energia unPerro}

ladrar :: Int -> Actividad
ladrar cantidadLadridos = aumentaEnergia mitadLadridos

    where
        mitadLadridos = cantidadLadridos `div` 2

aumentaEnergia :: Int -> Perro -> Perro
aumentaEnergia cantidadEnergia = modEnergia (+ cantidadEnergia)

regalar :: String -> Actividad
regalar unJuguete = modJuguetes (unJuguete :)

modJuguetes :: (Juguetes -> Juguetes) -> Perro -> Perro
modJuguetes f unPerro = unPerro {juguetesFavoritos = f $ juguetesFavoritos unPerro}

diaDeSpa :: Actividad
diaDeSpa unPerro
    | ((>=50) . tiempoPermanencia $ unPerro) || esRazaExtravagante unPerro      = modEnergia (const 100) . regalar "peine de goma" $ unPerro
    | otherwise                                              = unPerro

esRazaExtravagante :: Perro -> Bool
esRazaExtravagante unPerro = ((=="dalmata") . raza $ unPerro) || ((=="pomerania") . raza $ unPerro)

diaDeCampo :: Actividad
diaDeCampo = modJuguetes (drop 1)

-----------
--Parte B--
-----------

tiempoRutina :: Guarderia -> Int
tiempoRutina unaGuarderia = sum . map (snd) . rutina $ unaGuarderia

actividadesRutina :: Guarderia -> [Actividad]
actividadesRutina unaGuarderia = map (fst) . rutina $ unaGuarderia

puedeEstar :: Guarderia -> Perro -> Bool
puedeEstar unaGuarderia = ((>tiempoRutina unaGuarderia) . tiempoPermanencia)

esPerroResponsable :: Perro -> Bool
esPerroResponsable unPerro = (>3) . length . juguetesFavoritos . diaDeCampo $ unPerro

realizarRutina :: Guarderia -> Perro -> Perro
realizarRutina unaGuarderia unPerro
    | (>= tiempoRutina unaGuarderia) . tiempoPermanencia $ unPerro = haceRutina unaGuarderia unPerro
    | otherwise                                                    = unPerro

haceRutina :: Guarderia -> Perro -> Perro
haceRutina unaGuarderia unPerro = foldl (\x f -> f x) unPerro (actividadesRutina unaGuarderia)

quedanCansados :: Guarderia -> [Perro] -> [Perro]
quedanCansados unaGuarderia unosPerros = filter (quedaCansado unaGuarderia) unosPerros

quedaCansado :: Guarderia -> Perro -> Bool
quedaCansado unaGuarderia unPerro = estaCansado . haceRutina unaGuarderia $ unPerro

estaCansado :: Perro -> Bool
estaCansado = (<5) . energia

-----------
--Parte C--
-----------

-- Es posible conocer la raza ya que la funcion esRazaExtravagante recibe la raza de un perro y sólo compara.
-- 2a) No se puede conocer ya que al tener una infinita lista de "soguitas" nunca se llegará a un valor de verdad que represente el valor final. Caso contrario sería si "perroPi" tuviese en su lista de juguetes un "huesito" antes que las infinitas "soguitas".
-- 2b) Nos arroja un valor "True", ya que cuando atraviesa la actividad "regalo" se le agrega como primer elemento "pelota", y como haskell analiza bajo "lazy evaluation" una vez que el "any (=="pelota")" tiene un valor verdadero deja de analizar. Por esa razón obtenemos un resultado final.
-- 2c) Obtenemos un valor verdadero por la misma razón mencionada en el inciso B, como haskell analiza bajo lazy evaluation una vez que encuentra a "soguita 31112" deja de buscar en la lista infinita y nos devuelve el valor verdadero. En cambio, si el juguete no se encontrase en la lista núnca llegaríamos a un valor "False", ya que permanecería buscando en forma permanente.
-- 3) Sí, es posible, pero tendríamos infinitos resultados ya que la lista "juguetesFavoritos" es infinita.
-- 4) Si le regalamos un hueso a perroPi se le agrega el ítem a su lista de juguetes, solo que por consola veríamos además del regalo las infinitas sogas que ya poseía previamente.
