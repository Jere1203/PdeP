--Definir la función esMultiploDeAlguno/2, que recibe un número y una lista y devuelve True si el número es múltiplo de 
--alguno de los números de la lista.

esMultiploDeAlguno :: Int -> [Int] -> Bool
esMultiploDeAlguno num = any(esMultiploDe num)

esMultiploDe :: Int -> Int -> Bool
esMultiploDe x = (==0).mod x