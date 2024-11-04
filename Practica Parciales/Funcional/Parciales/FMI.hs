import Data.List
import Text.Show.Functions

-----------
--Punto 1--
-----------

data Pais = Pais{
    ingresoPerCapita :: Float,
    poblacionActivaSectorPublico :: Float,
    poblacionActivaSectorPrivado :: Float,
    recursosNaturales :: [Recursos],
    deuda :: Float
} deriving (Show, Eq)

data Recursos = Mineria | Petroleo | IndustriaPesada | Ecoturismo deriving (Show, Eq)

namibia = Pais 4140 400000 650000 [Mineria, Ecoturismo] 50000000

-----------
--Punto 2--
-----------

type Estrategia = Pais -> Pais

prestamoNMillones :: Float -> Estrategia
prestamoNMillones prestamo unPais = unPais {deuda = prestamo * 1.5}

reducirPuestosSectorPublico :: Float -> Estrategia
reducirPuestosSectorPublico puestos unPais
    | (>100) . poblacionActivaSectorPublico $ unPais = reducirSectorPublico puestos . reducirIngresoPerCapita 0.20 $ unPais
    | otherwise                                      = reducirSectorPublico puestos . reducirIngresoPerCapita 0.15 $ unPais

reducirSectorPublico :: Float -> Pais -> Pais
reducirSectorPublico cantPuestos unPais = unPais {poblacionActivaSectorPublico = poblacionActivaSectorPublico unPais - cantPuestos}

reducirIngresoPerCapita :: Float -> Pais -> Pais
reducirIngresoPerCapita porcentaje unPais = unPais {ingresoPerCapita = ingresoPerCapita unPais - porcentajeIngreso porcentaje unPais}

porcentajeIngreso :: Float -> Pais -> Float
porcentajeIngreso porcentaje unPais = porcentaje * ingresoPerCapita unPais

explotarRecursos :: Recursos -> Estrategia
explotarRecursos unRecurso unPais = quitarRecurso unRecurso . reducirDeuda 2000000 $ unPais

quitarRecurso :: Recursos -> Pais -> Pais
quitarRecurso unRecurso unPais = unPais {recursosNaturales = filter (/= unRecurso) $ recursosNaturales unPais}

reducirDeuda :: Float -> Pais -> Pais
reducirDeuda cantDeuda unPais = modDeuda (subtract cantDeuda) unPais

modDeuda :: (Float -> Float) -> Pais -> Pais
modDeuda f unPais = unPais {deuda = f $ deuda unPais}

blindarPais :: Estrategia
blindarPais unPais = reducirSectorPublico 500 . prestamoNMillones (pbi unPais / 2) $ unPais

pbi :: Pais -> Float
pbi unPais = ingresoPerCapita unPais * sumaPoblacionActiva unPais

sumaPoblacionActiva :: Pais -> Float
sumaPoblacionActiva unPais = poblacionActivaSectorPrivado unPais + poblacionActivaSectorPublico unPais

-----------
--Punto 3--
-----------
punto3A :: Float -> Pais -> Pais
punto3A prestamo unPais = prestamoNMillones prestamo . explotarRecursos Mineria $ unPais

aplicarReceta :: Pais -> [Estrategia] -> Pais
aplicarReceta unPais estrategias = foldl (\unPais estrategias -> estrategias unPais) unPais estrategias

--aplicarReceta namibia [prestamoNMillones 200000000, explotarRecursos Mineria] = foldl (\unPais estrategias -> estrategias unPais) namibia [prestamoNMillones 200000000, explotarRecursos Mineria]

-----------
--Punto 4--
-----------

paisesQueZafan :: [Pais] -> [Pais]
paisesQueZafan = filter (tienePetroleo)

tienePetroleo :: Pais -> Bool
tienePetroleo unPais = elem Petroleo $ recursosNaturales unPais

deudaAFavorFMI :: [Pais] -> Float
deudaAFavorFMI unosPaises = sum . map deuda $ unosPaises

-----------
--Punto 5--
-----------

type Receta = [Estrategia]

estaOrdenada :: (Num a, Ord a) => [a] -> Bool
estaOrdenada []       = True
estaOrdenada [x]      = True
estaOrdenada (x:y:xs) = x <= y && estaOrdenada (y:xs) 

recetasOrdenadas :: Pais -> Receta -> Bool
recetasOrdenadas unPais unaReceta = estaOrdenada (pbi . unaReceta) unPais