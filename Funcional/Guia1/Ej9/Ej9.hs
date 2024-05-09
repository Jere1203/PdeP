module Funcional.Ej9.Ej9 where
--Definir la función mcm/2 que devuelva el mínimo común múltiplo entre dos números, de acuerdo a esta fórmula. 
--m.c.m.(a, b) = {a * b} / {m.c.d.(a, b)} 
--Más información. 
--Nota: Se puede utilizar gcd.
mcm :: Int -> Int -> Int
mcm x y = x*y `div` gcd x y 