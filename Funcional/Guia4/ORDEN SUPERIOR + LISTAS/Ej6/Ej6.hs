--Definir la función aprobaron/1, que dada la información de un curso devuelve la información de los alumnos que aprobaron.
aprobaron :: [[Int]] -> [[Int]]
aprobaron = filter aprobo 

aprobo :: [Int] -> Bool
aprobo = all (>=6)