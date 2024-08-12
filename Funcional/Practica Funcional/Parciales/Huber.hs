import Text.Show.Functions
import Data.List

-----------
--Punto 1--
-----------

data Chofer = Chofer{
    nombreChofer :: String,
    kilometraje :: Int,
    cantidadViajes :: Int,
    condicion :: Condicion,
    viajes :: [Viaje]
} deriving(Show)

type Condicion = Viaje -> Bool

data Viaje = Viaje{
    fecha :: String,
    cliente :: Cliente,
    costo :: Int
} deriving(Show)

data Cliente = Cliente{
    nombreCliente :: String,
    domicilio :: String
} deriving (Show)

-----------
--Punto 2--
-----------

cualquierViaje :: Condicion
cualquierViaje _ = True

viajesCaros :: Condicion
viajesCaros = ((>200) . costo)

clientesConMasDeNLetras :: Int -> Condicion
clientesConMasDeNLetras cantidadLetras = ((>cantidadLetras) . length . nombreCliente . cliente)

zonaDistintaA :: String -> Condicion
zonaDistintaA unaZona = ((/= unaZona) . domicilio . cliente)

-----------
--Punto 3--
-----------

lucas :: Cliente
lucas = Cliente "Lucas" "Victoria"

daniel :: Chofer
daniel = Chofer "Daniel" 23500 1 (zonaDistintaA "Olivos") [Viaje "20/04/2017" lucas 150]

alejandra :: Chofer
alejandra = Chofer "Alejandra" 180000 0 cualquierViaje []

-----------
--Punto 4--
-----------

puedeTomarViaje :: Viaje -> Chofer -> Bool
puedeTomarViaje unViaje unChofer = condicion unChofer $ unViaje

-----------
--Punto 5--
-----------

liquidacionChofer :: Chofer -> Int
liquidacionChofer unChofer = sum $ map costo (viajes unChofer)

-----------
--Punto 6--
-----------

--a)
filtrarViajes :: Viaje -> [Chofer] -> [Chofer]
filtrarViajes unViaje = filter (puedeTomarViaje unViaje)

--b)
menorCantidadViajes :: [Chofer] -> Chofer
menorCantidadViajes (unChofer : otroChofer : otrosChoferes)
    | cantidadViajes unChofer < cantidadViajes otroChofer = unChofer
    | otherwise                                           = menorCantidadViajes (otroChofer:otrosChoferes)

--c)
efectuarViaje :: Viaje -> Chofer -> Chofer
efectuarViaje unViaje = sumaViaje . agregarViaje unViaje

agregarViaje :: Viaje -> Chofer -> Chofer
agregarViaje unViaje = modViajes (unViaje :)

modViajes :: ([Viaje] -> [Viaje]) -> Chofer -> Chofer
modViajes f unChofer = unChofer {viajes = f $ viajes unChofer}

sumaViaje :: Chofer -> Chofer
sumaViaje = modCantViajes (+1)

modCantViajes :: (Int -> Int) -> Chofer -> Chofer
modCantViajes f unChofer = unChofer{cantidadViajes = f $ cantidadViajes unChofer}

-----------
--Punto 7--
-----------

--a)
nitoInfy :: Chofer
nitoInfy = Chofer "Nito Infy" 70000 0 (clientesConMasDeNLetras 3) (repeat $ Viaje "11/03/2017" lucas 50)

--b)
-- No se puede calcular, ya que al ser una lista infinita el intérprete quedará calculando una suma infinta que nunca mostrará en consola, ya que 
-- siempre hay un siguiente valor para sumar.

--c)
--Sí, puede ya que la única operación que se realiza es concatenar un elemento a la lista. No implica ninguna sumatoria.

-----------
--Punto 8--
-----------
gongNeng :: (Ord b) => b -> (b -> Bool) -> (a -> b) -> [a] -> b
gongNeng arg1 arg2 arg3 = (max arg1 . head . filter arg2 . map arg3)