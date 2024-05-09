--Se representa la información sobre ingresos y egresos de una persona en cada mes de un año mediante dos listas, de 12 
--elementos cada una. P.ej., si entre enero y junio gané 100, y entre julio y diciembre gané 120, mi lista de ingresos es:
--[100,100,100,100,100,100,120,120,120,120,120,120] 
--Si empecé en 100 y fui aumentando de a 20 por mes, llegando a 220, queda:
--[100,120..220] 
--Y si es al revés, empecé en 220 y fui bajando de a 20 por mes hasta llegar a 100, queda:
--[220,200..100] 
--(jugar un poco con esta notación) 
--Definir la función: huboMesMejorDe/3, que dadas las listas de ingresos y egresos y un número, devuelve True si el resultado de algún mes es mayor que el número. P.ej. 
--Main> huboMesMejorDe [1..12] [12,11..1] 10 
--True 
--Porque en diciembre el resultado fue 12-1=11 > 10.

listaIngresos = [100, 120 ..200]
listaEgresos = [220, 200 .. 100]

huboMesMejorDe :: [Int] -> [Int] -> Int -> Bool
huboMesMejorDe listaIngresos listaEgresos num = any (> num) $ zipWith (-) listaIngresos listaEgresos 