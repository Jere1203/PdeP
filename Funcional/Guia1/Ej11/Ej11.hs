-- En una plantación de pinos, de cada árbol se conoce la altura expresada en cm. 
-- El peso de un pino se puede calcular a partir de la altura así: 
-- 3 kg x cm hasta 3 metros, 2 kg x cm arriba de los 3 metros.
-- P.ej. 2 metros ⇒  600 kg, 5 metros ⇒  1300 kg. 
-- Los pinos se usan para llevarlos a una fábrica de muebles, a la que le sirven árboles de entre 400 y 1000 kilos, 
-- un pino fuera de este rango no le sirve a la fábrica. Para esta situación: 
-- Definir la función pesoPino, recibe la altura de un pino y devuelve su peso. 
-- Definir la función esPesoUtil, recibe un peso en kg y devuelve True si un pino de ese peso le sirve a la fábrica, 
-- y False en caso contrario. 
-- Definir la función sirvePino, recibe la altura de un pino y devuelve True si un pino de ese peso le sirve a la fábrica, 
-- y False en caso contrario. Usar composición en la definición.
pesoPino :: (Num a, Ord a) => a -> a
pesoPino h = if h<3 then 3*h if h>=3 then 2*h 

esPesoUtil :: (Num a, Ord a) => a -> Bool
esPesoUtil peso = peso < 1000 && peso > 400

sirvePino :: (Num a, Ord a) => a -> Bool
sirvePino altura = pesoPino altura < 1000 && pesoPino altura > 400