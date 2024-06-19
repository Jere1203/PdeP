import Text.Show.Functions

data Ciudad = Ciudad {
    nombre :: String,
    anioFundacion :: Int, 
    atracciones :: [String],
    costoDeVida :: Float
} deriving (Show)


-- <- Ciudades ->

baradero :: Ciudad
baradero = Ciudad {
    nombre = "Baradero",
    anioFundacion = 1615,
    atracciones = ["Parque del Este", "Museo Alejandro Barbich"],
    costoDeVida = 150
}

caletaOlivia :: Ciudad
caletaOlivia = Ciudad {
    nombre = "Caleta Olivia",
    anioFundacion = 1901,
    atracciones = ["El Gorosito", "Faro Costanera"],
    costoDeVida = 120
}

nullish :: Ciudad
nullish = Ciudad {
    nombre = "Nullish",
    anioFundacion = 1800,
    atracciones = [],
    costoDeVida = 140
}

maipu :: Ciudad
maipu = Ciudad {
    nombre = "Maipu",
    anioFundacion = 1878,
    atracciones = ["Fortin Kakel"],
    costoDeVida = 115
}

azul :: Ciudad
azul = Ciudad {
    nombre = "Azul",
    anioFundacion = 1832,
    atracciones = ["Teatro Español", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"],
    costoDeVida = 190
}
-- ================================= PUNTO 1 ==================================================

valorDeUnaCiudad :: Ciudad -> Float
valorDeUnaCiudad (Ciudad _ anioFundacion atracciones costoDeVida)
    | anioFundacion < 1800   =  5 * (1800 - fromInteger (toInteger anioFundacion))
    | null  atracciones      = 2 * costoDeVida 
    | otherwise              = 3 * costoDeVida 

-- ================================= PUNTO 2 ==================================================

esVocal :: Char -> Bool
esVocal letra = elem letra "aeiouAEIOU"

algunaAtraccionCopada :: Ciudad -> Bool
algunaAtraccionCopada (Ciudad _ _ atracciones _) = any (esVocal . head) atracciones 

esCiudadSobria :: Ciudad -> Int -> Bool
esCiudadSobria (Ciudad _ _ atracciones _) cantidadLetras = all ((> cantidadLetras) . length)  atracciones 

tieneNombreRaro :: Ciudad -> Bool
tieneNombreRaro = (<5) . length . nombre  

-- ================================= PUNTO 3 ==================================================

-- <-- Sumar atraccion -->

type Evento = Ciudad -> Ciudad

sumarNuevaAtraccion :: String -> Evento
sumarNuevaAtraccion nuevaAtraccion unaCiudad = agregarAtraccion nuevaAtraccion . sumarCostoDeVida (0.2 * costoDeVida unaCiudad) $ unaCiudad

agregarAtraccion :: String -> Ciudad -> Ciudad
agregarAtraccion unaAtraccion = mapAtracciones (unaAtraccion :)

mapAtracciones :: ([String] -> [String]) -> Ciudad -> Ciudad
mapAtracciones f unaCiudad = unaCiudad {atracciones = f $ atracciones unaCiudad}


sumarCostoDeVida :: Float -> Ciudad -> Ciudad
sumarCostoDeVida unCostoDeVida = mapCostoDeVida (unCostoDeVida +)

mapCostoDeVida :: (Float -> Float) -> Ciudad -> Ciudad
mapCostoDeVida f unaCiudad = unaCiudad {costoDeVida = f $ costoDeVida unaCiudad}

-- <-- Atravesar crisis -->


atravesoCrisis :: Evento
atravesoCrisis unaCiudad = cerrarUltima . quitarCostoDeVida (0.1 * costoDeVida unaCiudad) $ unaCiudad

cerrarUltima :: Ciudad -> Ciudad
cerrarUltima = mapAtracciones sacarUltimoElemento 

quitarCostoDeVida :: Float -> Ciudad -> Ciudad
quitarCostoDeVida unCostoDeVida = mapCostoDeVida (subtract unCostoDeVida)

sacarUltimoElemento :: [a] -> [a]
sacarUltimoElemento [] = []
sacarUltimoElemento [x] = []
sacarUltimoElemento (x:xs) = x : sacarUltimoElemento xs

-- <-- Remodelar ciudad -->

remodelacionCiudad :: Float -> Evento
remodelacionCiudad porcentaje unaCiudad = nuevoNombre . sumarCostoDeVida (porcentaje/100 * costoDeVida unaCiudad) $ unaCiudad
    
nuevoNombre :: Ciudad -> Ciudad
nuevoNombre unaCiudad = unaCiudad {nombre = "New " ++ nombre unaCiudad}

-- <-- Reevaluar ciudad -->

reevaluacionCiudad :: Int -> Evento
reevaluacionCiudad cantidadLetras unaCiudad 
    | esCiudadSobria unaCiudad cantidadLetras = sumarCostoDeVida (0.1 * costoDeVida unaCiudad) unaCiudad
    | otherwise                               = quitarCostoDeVida 3 unaCiudad

-- ================================= PUNTO 4 ==================================================

-- 1er opcion --> (reevaluacionCiudad cantidadLetras) . atravesoCrisis . (remodelacionCiudad porcentaje) . (sumarNuevaAtraccion "atraccion") $ unaCiudad

-- 2da opcion --> (reevaluacionCiudad cantidadLetras) $ atravesoCrisis $ remodelacionCiudad porcentaje $ sumarNuevaAtraccion "atraccion" unaCiudad

-- Ejemplo: (reevaluacionCiudad 14).atravesoCrisis.(remodelacionCiudad 100).(sumarNuevaAtraccion "atraccion") $ azul
-- 1) Se agrega "atraccion" y actualiza costoDeVida = 228
-- 2) Se agrega "New" al nombre y actualiza costoDeVida = 456
-- 3) Se saca "atraccion" y actualiza costoDeVida= 410.4
-- 4) Baja 3 puntos y actualiza costoDeVida = 407.4

-- ================================= PUNTO 5=================================================

-- ==== PUNTO 5.1 ====

data Anio = Anio {
    numero :: Int,
    eventos :: [Evento]
} deriving (Show)

veinteVeintiDos :: Anio
veinteVeintiDos = Anio {
    numero = 2022,
    eventos = [atravesoCrisis, remodelacionCiudad 5, reevaluacionCiudad 7]
}

dosMilQuince :: Anio
dosMilQuince = Anio{
    numero = 2015,
    eventos = []
}

aplicaVariosEventos :: Ciudad -> [Evento] -> Ciudad
aplicaVariosEventos = foldl (\ciudad evento -> evento ciudad)  

aniosPasan :: Ciudad -> Anio -> Ciudad
aniosPasan unaCiudad unAnio = aplicaVariosEventos unaCiudad (eventos unAnio)

-- ==== PUNTO 5.2 ====

-- Ejemplo de Criterio
cantidadAtracciones :: Ciudad -> Int 
cantidadAtracciones  = length . atracciones  
-- -------------------

algoMejor :: (Ord a) => Ciudad -> (Ciudad -> a) -> Evento -> Bool
algoMejor unaCiudad unCriterio unEvento = unCriterio (unEvento unaCiudad) > unCriterio unaCiudad



-- ==== PUNTO 5.3 ====

costoDeVidaSuba :: Ciudad -> Anio -> Ciudad
costoDeVidaSuba unaCiudad (Anio _ eventos) = aplicaVariosEventos unaCiudad $ filter (algoMejor unaCiudad costoDeVida) eventos 

-- ==== PUNTO 5.4 ====

costoDeVidaBaje :: Ciudad -> Anio -> Ciudad
costoDeVidaBaje unaCiudad (Anio _ eventos) = aplicaVariosEventos unaCiudad $ filter (not.algoMejor unaCiudad costoDeVida) eventos

-- ==== PUNTO 5.5 ====

valorQueSuba :: Ciudad -> Anio -> Ciudad
valorQueSuba unaCiudad (Anio _ eventos)   = aplicaVariosEventos unaCiudad $ filter (algoMejor unaCiudad valorDeUnaCiudad) eventos 

-- ================================= PUNTO 6 =================================================

-- ==== PUNTO 6.1 ====
veinteVeintiTres :: Anio
veinteVeintiTres = Anio {
    numero = 2023,
    eventos = [atravesoCrisis, sumarNuevaAtraccion "parque", remodelacionCiudad 10, remodelacionCiudad 20]
}

eventosOrdenados :: Anio -> Ciudad -> Bool
eventosOrdenados (Anio _ []) _ = True           
eventosOrdenados (Anio _ [evento]) _ = True   
eventosOrdenados (Anio numero (evento1:evento2:eventos)) unaCiudad = (costoDeVida . evento1) unaCiudad <= (costoDeVida . evento2) unaCiudad && eventosOrdenados (Anio numero (evento2:eventos)) unaCiudad


-- ==== PUNTO 6.2 ====
estaOrdenadaMenorAMayor :: (Num a, Ord a) => [a] -> Bool
estaOrdenadaMenorAMayor f [] = True
estaOrdenadaMenorAMayor f [x] = True
estaOrdenadaMenorAMayor f (x:y:xs) = f x <= f y  && estaOrdenadaMenorAMayor f (y:xs)

ciudadesOrdenadas :: Evento -> [Ciudad] -> Bool
ciudadesOrdenadas unEvento = estaOrdenadaMenorAMayor (costoDeVida . unEvento) 

-- ==== PUNTO 6.3 ====
veinteVeintiUno :: Anio
veinteVeintiUno = Anio{
    numero = 2021,
    eventos = [atravesoCrisis, sumarNuevaAtraccion "playa"]
}

aniosOrdenados :: Ciudad -> [Anio] -> Bool
aniosOrdenados unaCiudad  = estaOrdenadaMenorAMayor (costoDeVida . aniosPasan unaCiudad) 

-- ================================= PUNTO 7 =================================================   

-- == Eventos ordenados ==
veinteVeintiCuatro :: Anio
veinteVeintiCuatro = Anio {
    numero = 2024,
    eventos = [atravesoCrisis, reevaluacionCiudad 7] ++ map remodelacionCiudad [1..]
}
-- Si, puede haber un resultado posible. Si una ciudad es sobria significa que a la hora de aplicarle reevaluacionCiudad 7 (todas sus atracciones tienen mas de 7 letras) le va a sumar un 10% al costo de vida. Por su parte remodelacionCiudad 1, le va a sumar un 1% al costo de vida (un menor aumento que la funcion anterior). Por lo tanto, en este caso particular, la funcion eventosOrdenados va a devolver False. Esto ocurre debido a que Haskell funciona con Lazy Evaluation, por lo que al encontrar un False en una comparacion, no va a seguir evaluando el resto de la lista, haciendo que no importe si quedan 1, 2 o infinitos elementos por evaluar, la funcion devuelve directamente false. 

-- == Ciudades ordenadas ==

discoRayado :: [Ciudad]
discoRayado = [azul, nullish] ++ cycle [caletaOlivia, baradero]

-- Si, en el caso de que el evento sea atravesoCrisis ocurre que el costo de vida de la ciudad azul queda mas alto que el de nullish entonces la funcion estaOrdenadaMenorAMayor retonaria un valor Falso, como en la funcion se utiliza el operador && no se necesita evaluar los demas resultados de la lista, ya que, el valor falso es el valor absorbente.

-- == Años ordenadas ==
laHistoriaSinFin :: [Anio] 
laHistoriaSinFin = [veinteVeintiUno, veinteVeintiDos] ++ repeat veinteVeintiTres

-- ¿Puede haber un resultado posible para la función del punto 6.3 (años ordenados) para “la historia sin fin”? Justificarlo relacionándolo con conceptos vistos en la materia. 
-- Si, el resultado obtuvido en forma unánime con las distintas ciudades fue el de "False", esto debido a lo anteriormente mencionado respecto al Lazy Evaluation. Ya que al encontrar un contraejemplo en la lista de años, la función devuelve directamente False sin evaluar al resto de la lista.
-- En el año 2022 el costo de vida de todas las ciudades se ve disminuido respecto al costo de vida del 2021, motivo por el cual cuando se aplica la función "aniosOrdenados" esta nos devuelve un False como resultado. 
