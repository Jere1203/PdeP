--Definir la función sumaF/2, que dadas una lista de funciones y un número, 
--devuelve la suma del resultado de aplicar las funciones al número.
sumaF :: [Int->Int] -> Int -> Int
sumaF f nro = sum (aplicarFunciones f nro)

aplicarFunciones :: [a->a] -> a -> [a]
aplicarFunciones f num = map($ num)f