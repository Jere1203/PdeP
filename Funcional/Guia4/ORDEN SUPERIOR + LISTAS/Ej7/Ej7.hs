--Definir la función divisores/1, que recibe un número y devuelve la lista de divisores.
divisores :: Int -> [Int]
divisores nro = filter ((==0).mod nro) [1..nro]