import Data.List
import Text.Show.Functions

data Genero = Genero{
    nombreGenero :: String,
    cantidadSeguidores :: Integer,
    nivelDeDescontrolQueGenera :: Integer
} deriving(Show, Eq)

rock = Genero "rock" 311250 3
pop = Genero "pop" 53480 1
electronico = Genero "electronico" 10000 4
hipHop = Genero "hip-hop" 2000 1

data Banda = Banda{
    nombre :: String,
    seguidores :: Integer,
    estilo :: [Genero]
} deriving(Show, Eq)

cuadraditos = Banda "emilioPrincipeYSusCuadraditosDeDulceDeLeche" 75000 [rock]
aguaSinGas = Banda "aguaSinGasDolbySurround" 61815 [rock, pop]
djCutaneo = Banda "djCutaneoInTheMix" 2000 [electronico, hipHop]

type Festival = [Banda]
cabalgataMusic = [aguaSinGas, djCutaneo]
beinakerRock = [cuadraditos, aguaSinGas]

--1

calcularDescontrolTotal :: Genero -> Integer
calcularDescontrolTotal unGenero = (*) (cantidadSeguidores unGenero) . nivelDeDescontrolQueGenera $ unGenero

--calcularPorcentajeDeRelevancia :: Banda -> Genero -> Integer
--calcularPorcentajeDeRelevancia unaBanda unGenero
--    | perteneceGeneroABanda unGenero unaBanda = (*100) . (/) (seguidores unaBanda) . cantidadSeguidores $ unGenero
--    | otherwise                               = 0

perteneceGeneroABanda :: Genero -> Banda -> Bool
perteneceGeneroABanda unGenero  = elem unGenero . estilo

calcularDescontrolDeUnaBanda :: Banda -> Integer
calcularDescontrolDeUnaBanda unaBanda = sum . map (* porcentajesDeRelevancia) (descontrolTotal)
    where
        porcentajesDeRelevancia = map (calcularPorcentajeDeRelevancia unaBanda) estilo unaBanda
        descontrolTotal         = map calcularDescontrolTotal . estilo $ unaBanda 

--2
devuelveMejorElemento :: Ord a => (b -> c) -> [a] -> a
devuelveMejorElemento unCriterio unaLista = 