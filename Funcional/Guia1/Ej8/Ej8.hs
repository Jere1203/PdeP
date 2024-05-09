module Funcional.Ej8.Ej8 where
--Definir la función haceFrioF/1, indica si una temperatura expresada en grados Fahrenheit es fría. 
--Decimos que hace frío si la temperatura es menor a 8 grados Celsius.
fahrToCelsius :: Fractional a => a -> a
fahrToCelsius temp = (temp - 32)*5/9

haceFrioF ::  (Ord a , Fractional a) => a -> Bool 
haceFrioF temp = fahrToCelsius temp < 8
