--En una población, se estudió que el crecimiento anual de la altura de las personas sigue esta fórmula de acuerdo a la edad:
--1 año: 22 cm 
--2 años: 20 cm 
--3 años: 18 cm 
-- ... así bajando de a 2 cm por año hasta 
--9 años: 6 cm 
--10 a 15 años: 4 cm 
--16 y 17 años: 2 cm 
--18 y 19 años: 1 cm 
--20 años o más: 0 cm 
--A partir de esta información: 
--Definir la función crecimientoAnual/1,que recibe como parámetro la edad de la persona, y devuelve cuánto tiene que crecer en un año. 
--Hacerlo con guardas. La fórmula para 1 a 10 años es 24 - (edad * 2).
--Definir la función crecimientoEntreEdades/2, que recibe como parámetros dos edades y devuelve cuánto tiene que crecer una persona entre esas 
--dos edades. P.ej. 
--Main> crecimientoEntreEdades 8 12 
--22 
--es la suma de 8 + 6 + 4 + 4, crecimientos de los años 8, 9, 10 y 11 respectivamente. 
--Nota: Definir la función crecimientoEntreEdades en una sola línea, usando map y suma.
--Armar una función alturasEnUnAnio/2, que dada una edad y una lista de alturas de personas, devuelva la altura de esas personas un año después.
--P.ej. 
--Main> alturasEnUnAnio 7 [120,108,89] 
--[130,118,99] 
--Qué es lo que van a medir las tres personas un año después, dado que el coeficiente de crecimiento anual para 7 años da 10 cm. 
--Nota: definir la función alturasEnUnAnio en una sola línea, usando map y la función (+ expresión). 
--Definir la función alturaEnEdades/3, que recibe la altura y la edad de una persona y una lista de edades, y devuelve la lista de la altura que
-- va a tener esa persona en cada una de las edades. 
--P.ej. Main> alturaEnEdades 120 8 [12,15,18] 
--[142,154,164] 
--que son las alturas que una persona que mide 120 cm a los 8 años va a tener a los 12, 15 y 18 respectivamente.

crecimientoAnual :: Int -> Int
crecimientoAnual edad
    | edad >= 1 && edad <= 10 = 24 - (edad*2)
    | edad > 10 && edad <= 15 = 4
    | edad > 15 && edad <= 17 = 2
    | edad > 17 && edad <= 19 = 1
    | otherwise = 0

crecimientoEntreEdades :: Int -> Int -> Int
crecimientoEntreEdades edad1 edad2 = sum $ map crecimientoAnual [edad1 .. edad2 - 1]

alturasEnUnAnio :: Int -> [Int] -> [Int]
alturasEnUnAnio edad  = map ((+).crecimientoAnual $ edad)

--alturaEnEdades :: Int -> Int -> [Int] -> [Int]
--alturaEnEdades = 