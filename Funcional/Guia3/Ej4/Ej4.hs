--Representamos las notas que se sacó un alumno en dos parciales mediante un par (nota1,nota2), p.ej. un patito en el 1ro y un 7 en el 2do se 
--representan mediante el par (2,7). 
--A partir de esto: 
--Definir la función esNotaBochazo, recibe un número y devuelve True si no llega a 6, False en caso contrario. No vale usar guardas. 
--Definir la función aprobo, recibe un par e indica si una persona que se sacó esas notas aprueba. Usar esNotaBochazo. 
--Definir la función promociono, que indica si promocionó, para eso tiene las dos notas tienen que sumar al menos 15 y además haberse sacado al 
--menos 7 en cada parcial. 
--Escribir una consulta que dado un par indica si aprobó el primer parcial, usando esNotaBochazo y composición. La consulta tiene que tener esta
--forma 

esNotaBochazo :: (Int,Int) -> (Bool,Bool)
esNotaBochazo (nota1,nota2) = (nota1 >= 6,nota2 >= 6)

aprobo :: (Int,Int) -> Bool
aprobo (n1,n2)
    | esNotaBochazo (n1,n2) == (True,True) = True
    | otherwise = False

promociono :: (Int,Int) -> Bool
promociono (n1,n2)
    | n1+n2 >= 15 && (n1 >= 7 || n2 >= 7) = True
    | otherwise = False
