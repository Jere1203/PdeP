
--Definir la función mejor/3, 
--que recibe dos funciones y un número, y devuelve el resultado de la función que dé un valor 
--más alto.

mejor :: (Int -> Int) -> (Int -> Int) -> Int -> Int
mejor f g num = max(f num)(g num)

triple :: Int -> Int
triple = (*3)

cuadrado :: Int -> Int
cuadrado = (^2)