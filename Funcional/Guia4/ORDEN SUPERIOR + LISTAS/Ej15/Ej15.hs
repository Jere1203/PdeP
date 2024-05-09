--Usar takeWhile/2 para definir las siguientes funciones: primerosPares/1, que recibe una lista de números y 
--devuelve la sublista hasta el primer no par exclusive.

primerosPares :: [Int] -> [Int]
primerosPares = takeWhile even

---primerosDivisores/2, que recibe una lista de números y un número n, y devuelve la sublista hasta el primer número 
--que no es divisor de n exclusive. 
primerosDivisores :: Int -> [Int] ->[Int]
primerosDivisores nro = takeWhile $ (==0).mod nro

--primerosNoDivisores/2, que recibe una lista de números y un número n, y devuelve la sublista hasta el primer número 
--que sí es divisor de n exclusive.
primerosNoDivisores :: Int -> [Int] -> [Int]
primerosNoDivisores num = takeWhile $ (/=0).mod num