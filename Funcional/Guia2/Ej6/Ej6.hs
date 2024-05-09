--Resolver la función del ejercicio 2 de la guía anterior esMultiploDe/2, utilizando aplicación parcial y composición.
esMultiploDe :: (Ord a, Num a, Integral a) => a -> a -> Bool
esMultiploDe x y = ((==0) . mod y) x