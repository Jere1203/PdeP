--Definir una función esNumeroPositivo, que invocando a la función con un número cualquiera me devuelva true 
--si el número es positivo y false en caso contrario.
esNumeroPositivo :: (Num a, Ord a) => a-> Bool
esNumeroPositivo num = num > 0