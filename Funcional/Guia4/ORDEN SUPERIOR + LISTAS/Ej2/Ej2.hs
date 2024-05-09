--Armar una función promedios/1, que dada una lista de listas me devuelve la lista de los promedios de cada lista-elemento.

promedios :: [[Int]] -> [Float]
promedios = map promedio

promedio :: [Int] -> Float
promedio lista = fromInteger(toInteger (sum lista)) / fromInteger(toInteger(length lista))