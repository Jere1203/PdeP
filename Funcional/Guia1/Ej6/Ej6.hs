module Funcional.Ej6.Ej6 where
--Definir la función celsiusToFahr/1, pasa una temperatura en grados Celsius a grados Fahrenheit.
celsiusToFahr :: Fractional a => a -> a
celsiusToFahr temp = (temp*9/5)+32