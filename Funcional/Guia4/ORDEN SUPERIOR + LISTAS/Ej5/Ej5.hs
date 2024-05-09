--Definir la función aprobó/1, que dada la lista de las notas de un alumno devuelve True si el alumno aprobó. 
--Se dice que un alumno aprobó si todas sus notas son 6 o más.

aprobo :: [Int] -> Bool
aprobo = all (>=6)