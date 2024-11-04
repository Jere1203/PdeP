import Text.Show.Functions
import Data.List
import Data.Char(toUpper)
import Data.Char(isUpper)

-----------
--Punto 1--
-----------

data Barbaro = Barbaro{
    nombre :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos :: [Objeto]
} deriving(Show)

type Objeto = Barbaro -> Barbaro

dave = Barbaro "Dave" 100 ["Tejer","Escribir poesia"] [ardilla, varitasDefectuosas]

espadas :: Int -> Objeto
espadas unPeso = modFuerza (+ 2*unPeso)

modFuerza :: (Int -> Int) -> Barbaro -> Barbaro
modFuerza f unBarbaro = unBarbaro {fuerza = f $ fuerza unBarbaro}

amuletosMisticos :: String -> Objeto
amuletosMisticos unaHabilidad  = modHabilidades (unaHabilidad :)

modHabilidades :: ([String] -> [String]) -> Barbaro -> Barbaro
modHabilidades f unBarbaro = unBarbaro {habilidades = f $ habilidades unBarbaro} 

varitasDefectuosas :: Objeto
varitasDefectuosas = modHabilidades ("hacerMagia" :) . desaparecerObjetos

desaparecerObjetos :: Barbaro -> Barbaro
desaparecerObjetos unBarbaro = unBarbaro {objetos = []}

ardilla :: Objeto
ardilla unBarbaro = unBarbaro

unaCuerda :: Objeto -> Objeto -> Barbaro -> Barbaro
unaCuerda objeto1 objeto2 = objeto2 . objeto1

-----------
--Punto 2--
-----------

megafono :: Objeto
megafono  = modHabilidades (poneHabilidadesMayuscula . concatenaHabilidades)

concatenaHabilidades :: [String] -> [String]
concatenaHabilidades habilidades = [concat habilidades]

poneHabilidadesMayuscula :: [String] -> [String]
poneHabilidadesMayuscula = map (map (toUpper))

megafonoBarbarico :: Objeto
megafonoBarbarico  = unaCuerda ardilla megafono

-----------
--Punto 3--
-----------

type Evento = Barbaro -> Bool
type Aventura = [Evento]

tieneHabilidad :: String -> Barbaro -> Bool
tieneHabilidad habilidad unBarbaro = elem habilidad $ habilidades unBarbaro

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes unBarbaro = tieneHabilidad "Escribir poesia atroz" unBarbaro

cremalleraDelTiempo :: Evento
cremalleraDelTiempo (Barbaro "Faffy" _ _ _) = True
cremalleraDelTiempo (Barbaro "Astro" _ _ _) = True
cremalleraDelTiempo (Barbaro _ _ _ _)       = False

ritualDeFechorias :: Evento
ritualDeFechorias unBarbaro = saqueo unBarbaro || gritoDeGuerra unBarbaro || caligrafia unBarbaro

saqueo :: Evento
saqueo unBarbaro = tieneHabilidad "Robar" unBarbaro && fuerza unBarbaro > 80 

gritoDeGuerra :: Evento
gritoDeGuerra unBarbaro = (>= poderDeGritoRequerido unBarbaro) . poderDeGrito $ unBarbaro

cantObjetos :: Barbaro -> Int
cantObjetos unBarbaro = length (objetos unBarbaro)

poderDeGrito :: Barbaro -> Int
poderDeGrito = cantLetrasHabilidades

poderDeGritoRequerido :: Barbaro -> Int
poderDeGritoRequerido unBarbaro = 4* cantObjetos unBarbaro

cantLetrasHabilidades :: Barbaro -> Int
cantLetrasHabilidades unBarbaro = sum . map length . habilidades $ unBarbaro

caligrafia :: Evento
caligrafia unBarbaro =  all tieneCaligrafiaPerfecta $ habilidades unBarbaro

tieneCaligrafiaPerfecta :: String -> Bool
tieneCaligrafiaPerfecta unaHabilidad = cantVocales unaHabilidad >3 && comienzaConVocal unaHabilidad

esVocal :: Char -> Bool
esVocal letra = elem letra "aeiouAEIOU"

cantVocales :: String -> Int
cantVocales [] = 0
cantVocales (x:xs)
    | esVocal x = 1 + cantVocales xs
    | otherwise = 0 + cantVocales xs

comienzaConVocal :: String -> Bool
comienzaConVocal unaHabilidad = isUpper $ head unaHabilidad

sobrevivientes :: Aventura -> [Barbaro] -> [Barbaro]
sobrevivientes unaAventura unosBarbaros = filter (sobrevivenAventura unaAventura) unosBarbaros

sobrevivenAventura :: Aventura -> Barbaro -> Bool
sobrevivenAventura unaAventura unBarbaro = all ($ unBarbaro) unaAventura

-----------
--Punto 4--
-----------

sinRepetidos :: [String] -> [String]
sinRepetidos [] = []
sinRepetidos (x:y:xs)
    | x == y    = x : sinRepetidos (y:xs)
    | otherwise = x : y : sinRepetidos (xs)

obtenerDescendiente :: Barbaro -> Barbaro
obtenerDescendiente unBarbaro = agregaAsterisco . aplicaObjetos $ unBarbaro

agregaAsterisco :: Barbaro -> Barbaro
agregaAsterisco unBarbaro = modNombre (++"*") unBarbaro

modNombre :: (String -> String) -> Barbaro -> Barbaro
modNombre f unBarbaro = unBarbaro {nombre = f $ nombre unBarbaro}

aplicaObjetos :: Barbaro -> Barbaro
aplicaObjetos unBarbaro = foldl (\unBarbaro unosObjetos -> unosObjetos unBarbaro) unBarbaro (objetos unBarbaro)

descendientes :: Barbaro -> [Barbaro]
descendientes unBarbaro = iterate (obtenerDescendiente) unBarbaro

-- "sinRepetidos" no se podria aplicar sobre la lista de objetos ya que no comparten tipo, lo mismo sucede con "nombre", ya que 
-- "sinRepetidos" es una funcion que recibe [String], mientras que "nombre" es de tipo String.