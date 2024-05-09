--Definir la función esCapicua/1, si data una lista de listas, me devuelve si la concatenación de las sublistas es una 
--lista capicua.
esCapicua :: [String] -> Bool
esCapicua palabra = concat palabra == (reverse.concat)palabra