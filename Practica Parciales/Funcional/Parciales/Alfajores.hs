import Text.Show.Functions
import Data.List

data Alfajor = Alfajor{
    capasRelleno :: [Relleno],
    peso :: Float,
    dulzor :: Float,
    nombre :: String
} deriving (Show, Eq)

data Relleno = DulceDeLeche | Mousse | Fruta deriving (Show, Eq)

-----------
--Parte 1--
-----------

jorgito :: Alfajor
jorgito = Alfajor{
    capasRelleno = [DulceDeLeche],
    peso = 80,
    dulzor = 8,
    nombre = "Jorgito"
} 

havanna :: Alfajor
havanna = Alfajor{
    capasRelleno = [Mousse, Mousse],
    peso = 60,
    dulzor = 12,
    nombre = "Havanna"
}

capitanDelEspacio :: Alfajor
capitanDelEspacio = Alfajor{
    capasRelleno = [DulceDeLeche],
    peso = 40,
    dulzor = 12,
    nombre = "Capitan del espacio"
}

coeficienteDeDulzor :: Alfajor -> Float
coeficienteDeDulzor (Alfajor _ peso dulzor _) = dulzor / peso

precioAlfajor :: Alfajor -> Float
precioAlfajor (Alfajor capasRelleno peso _ _) = (2*) peso  + sumatoriaRellenos capasRelleno

sumatoriaRellenos :: [Relleno] -> Float
sumatoriaRellenos = sum . map listaPrecios 

listaPrecios :: Relleno -> Float
listaPrecios DulceDeLeche = 12
listaPrecios Mousse       = 15  
listaPrecios    _         = 10

esPotable :: Alfajor -> Bool
esPotable unAlfajor = (not . null . capasRelleno $ unAlfajor) && sonMismoSabor unAlfajor && coeficienteDeDulzor unAlfajor >= 0.1

sonMismoSabor :: Alfajor -> Bool
sonMismoSabor (Alfajor capasRelleno _ _ _) = all (== head capasRelleno) capasRelleno

-----------
--Parte 2--
-----------

abaratarAlfajor :: Alfajor -> Alfajor
abaratarAlfajor unAlfajor = bajarPeso 10 . bajarDulzor 7 $ unAlfajor

bajarPeso :: Float -> Alfajor -> Alfajor
bajarPeso unNum = modificarPeso (subtract unNum)

bajarDulzor :: Float -> Alfajor -> Alfajor
bajarDulzor unNum = modificarDulzor (subtract unNum)

modificarPeso :: (Float -> Float) -> Alfajor -> Alfajor
modificarPeso f unAlfajor = unAlfajor {peso = f $ peso unAlfajor}

modificarDulzor :: (Float -> Float) -> Alfajor -> Alfajor
modificarDulzor f unAlfajor = unAlfajor {dulzor = f $ dulzor unAlfajor}

modificarNombre :: String -> Alfajor -> Alfajor
modificarNombre unNombre = renombrarAlfajor (const unNombre)

renombrarAlfajor :: (String -> String) -> Alfajor -> Alfajor
renombrarAlfajor f unAlfajor = unAlfajor {nombre = f $ nombre unAlfajor}

agregarCapa :: Relleno -> Alfajor -> Alfajor
agregarCapa unaCapa unAlfajor = unAlfajor {capasRelleno = unaCapa : capasRelleno unAlfajor}

hacerPremium :: Alfajor -> Alfajor
hacerPremium unAlfajor
    | esPotable unAlfajor = nombrePremium . agregarCapa (tipoDeCapa unAlfajor) $ unAlfajor
    | otherwise           = unAlfajor

tipoDeCapa :: Alfajor -> Relleno
tipoDeCapa  = head . capasRelleno

nombrePremium :: Alfajor -> Alfajor
nombrePremium  = renombrarAlfajor (++" premium") 

hacerPremium' :: Int -> Alfajor -> Alfajor
hacerPremium' veces unAlfajor
    | esPotable unAlfajor && veces > 0 = hacerPremium' (veces-1) $ nombrePremium . agregarCapa (tipoDeCapa unAlfajor) $ unAlfajor
    | otherwise                        = unAlfajor

jorgitito :: Alfajor
jorgitito = modificarNombre ("Jorgitito") . abaratarAlfajor $ jorgito

jorgelin :: Alfajor
jorgelin = modificarNombre ("Jorgelin") . agregarCapa DulceDeLeche $ jorgito

capitanDelEspacio' :: Alfajor
capitanDelEspacio' = modificarNombre ("Capitan del espacio de costa a costa") . hacerPremium' 4 . abaratarAlfajor $ capitanDelEspacio

-----------
--Parte 3--
-----------

data Cliente = Cliente{
    nombreCliente :: String,
    dinero :: Float,
    gustos :: Gusto,
    listaAlfajores :: [Alfajor]
} deriving (Show)

type Gusto = Alfajor -> Bool

emi :: Cliente
emi = Cliente {
    nombreCliente = "Emi",
    dinero = 120,
    gustos = isInfixOf ("Capitan del espacio") . nombre,
    listaAlfajores = []
}

tomi :: Cliente
tomi = Cliente {
    nombreCliente = "Tomi",
    dinero = 100,
    gustos = gustosTomi,
    listaAlfajores = []
}

gustosTomi :: Gusto
gustosTomi unAlfajor = pretencioso unAlfajor && dulcero unAlfajor

pretencioso :: Gusto
pretencioso = isInfixOf ("premium") . nombre

dulcero :: Gusto
dulcero = (> 0.15) . coeficienteDeDulzor

dante :: Cliente
dante = Cliente {
    nombreCliente = "Dante",
    dinero = 200,
    gustos = gustosDante,
    listaAlfajores = []
}

gustosDante :: Gusto
gustosDante unAlfajor = antiDulceDeLeche unAlfajor && (not . esPotable) unAlfajor

antiDulceDeLeche :: Gusto
antiDulceDeLeche unAlfajor = all (/= DulceDeLeche) (capasRelleno $ unAlfajor)

juan :: Cliente
juan = Cliente {
    nombreCliente = "Juan",
    dinero = 500,
    gustos = gustosJuan,
    listaAlfajores = []
}

gustosJuan :: Gusto
gustosJuan unAlfajor = dulcero unAlfajor && (isInfixOf ("Jorgito") $ nombre unAlfajor) && pretencioso unAlfajor && antiMousse unAlfajor

antiMousse :: Gusto
antiMousse unAlfajor = all (/= Mousse) (capasRelleno $ unAlfajor)

gustaAlCliente :: [Alfajor] -> Cliente -> [Alfajor]
gustaAlCliente listaAlfajores unCliente = filter (gustos unCliente) listaAlfajores

comprarAlfajor :: Cliente -> Alfajor -> Cliente
comprarAlfajor unCliente unAlfajor
    | dinero unCliente >= (precioAlfajor unAlfajor) = agregarALista unAlfajor . gastarDinero (precioAlfajor unAlfajor) $ unCliente
    | otherwise                                     = unCliente

gastarDinero :: Float -> Cliente -> Cliente
gastarDinero precio unCliente = modificarDinero (subtract precio) unCliente

modificarDinero :: (Float -> Float) -> Cliente -> Cliente
modificarDinero f unCliente = unCliente {dinero = f $ dinero unCliente}

agregarALista :: Alfajor -> Cliente -> Cliente
agregarALista unAlfajor unCliente  = unCliente {listaAlfajores = unAlfajor : listaAlfajores unCliente}

comprarListaAlfajores :: Cliente -> [Alfajor] -> Cliente
comprarListaAlfajores unCliente listaAlfajores = foldl (comprarAlfajor) unCliente listaAlfajores