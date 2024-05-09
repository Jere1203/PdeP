--Resolver la función del ejercicio 5 de la guía anterior esBisiesto/1, utilizando aplicación parcial y composición.
esBisiesto :: (Ord a, Fractional a, Num a, Integral a) => a -> Bool
esBisiesto anio =  (esMultiploDe 4 || esMultiploDe 400) anio

esMultiploDe :: (Ord a, Num a, Integral a) => a -> a -> Bool
esMultiploDe x y = ((==0) . mod y) x