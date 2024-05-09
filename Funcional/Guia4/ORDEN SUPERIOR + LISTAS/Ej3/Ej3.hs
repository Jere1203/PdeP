--Armar una función promediosSinAplazos que dada una lista de listas me devuelve la lista de los promedios de cada 
--lista-elemento, excluyendo los que sean menores a 4 que no se cuentan.

listaPromedios :: [[Int]] -> [Float]
listaPromedios = map promedio

promediosSinAplazos :: [[Int]] -> [Float]
promediosSinAplazos = filter (>=4) . listaPromedios

promedio :: [Int] -> Float
promedio lista = fromInteger(toInteger (sum lista)) / fromInteger(toInteger(length lista))