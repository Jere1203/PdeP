module Funcional.Ej7.Ej7 where
--Definir la función fahrToCelsius/1, la inversa de la anterior.
fahrToCelsius :: Fractional a => a -> a
fahrToCelsius temp = (temp - 32)*5/9