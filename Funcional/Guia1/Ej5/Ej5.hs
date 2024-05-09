module Funcional.Ej5.Ej5 where
--Definir la función esBisiesto/1, indica si un año es bisiesto. 
--(Un año es bisiesto si es divisible por 400 o es divisible por 4 pero no es divisible por 100) 
--Nota: Resolverlo reutilizando la función esMultiploDe/2
esBisiesto :: Int -> Bool
esBisiesto anio = esMultiploDe anio 400 || esMultiploDe anio 4 && not (esMultiploDe anio 100)
esMultiploDe :: Int -> Int -> Bool
esMultiploDe anio x = mod anio x == 0